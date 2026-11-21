import { readFileSync } from 'node:fs';
import { afterAll, beforeAll, beforeEach, describe, test } from 'vitest';
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} from '@firebase/rules-unit-testing';
import {
  Timestamp,
  arrayUnion,
  deleteDoc,
  deleteField,
  doc,
  getDoc,
  getDocs,
  collection,
  query,
  serverTimestamp,
  setDoc,
  updateDoc,
  where,
} from 'firebase/firestore';

const H = 'h1';
const ALICE = 'alice';
const BOB = 'bob';
const EVE = 'eve';
const CODE = 'ABC234';

let env;

const hours = (n) => Timestamp.fromMillis(Date.now() + n * 3600 * 1000);
const db = (uid) => env.authenticatedContext(uid).firestore();
const anon = () => env.unauthenticatedContext().firestore();

beforeAll(async () => {
  const [host, port] = (process.env.FIRESTORE_EMULATOR_HOST ?? '127.0.0.1:8080').split(':');
  env = await initializeTestEnvironment({
    projectId: 'demo-doghub',
    firestore: {
      rules: readFileSync(new URL('../firestore.rules', import.meta.url), 'utf8'),
      host,
      port: Number(port),
    },
  });
});

afterAll(() => env?.cleanup());

// Alice owns household h1 with dog d1 and a valid invite CODE.
beforeEach(async () => {
  await env.clearFirestore();
  await env.withSecurityRulesDisabled(async (ctx) => {
    const f = ctx.firestore();
    await setDoc(doc(f, `households/${H}`), {
      name: 'Dom',
      members: [ALICE],
      memberNames: { [ALICE]: 'Alice' },
      createdAt: Timestamp.now(),
    });
    await setDoc(doc(f, `households/${H}/dogs/d1`), {
      name: 'Burek',
      createdAt: Timestamp.now(),
    });
    await setDoc(doc(f, `households/${H}/dogs/d1/events/e1`), {
      type: 'walk',
      at: Timestamp.now(),
      createdAt: Timestamp.now(),
      by: ALICE,
      durationMin: 30,
      deleted: false,
    });
    await setDoc(doc(f, `households/${H}/dogs/d1/foods/f1`), {
      name: 'Acana',
      active: true,
      createdAt: Timestamp.now(),
    });
    await setDoc(doc(f, `invites/${CODE}`), {
      householdId: H,
      createdBy: ALICE,
      expiresAt: hours(24),
      createdAt: Timestamp.now(),
    });
    await setDoc(doc(f, 'invites/EXP234'), {
      householdId: H,
      createdBy: ALICE,
      expiresAt: hours(-1),
      createdAt: Timestamp.now(),
    });
  });
});

const joinPayload = (uid, code = CODE, name = 'Bob') => ({
  members: arrayUnion(uid),
  [`memberNames.${uid}`]: name,
  joinCode: code,
});

describe('households', () => {
  test('unauthenticated users can read nothing', async () => {
    await assertFails(getDoc(doc(anon(), `households/${H}`)));
  });

  test('member reads, non-member does not', async () => {
    await assertSucceeds(getDoc(doc(db(ALICE), `households/${H}`)));
    await assertFails(getDoc(doc(db(EVE), `households/${H}`)));
  });

  test('member can query own households by array-contains', async () => {
    const q = query(collection(db(ALICE), 'households'), where('members', 'array-contains', ALICE));
    await assertSucceeds(getDocs(q));
  });

  test('querying all households is denied', async () => {
    await assertFails(getDocs(collection(db(ALICE), 'households')));
  });

  test('create with only yourself as member', async () => {
    await assertSucceeds(
      setDoc(doc(db(BOB), 'households/h2'), {
        name: 'Bob home',
        members: [BOB],
        memberNames: { [BOB]: 'Bob' },
        createdAt: serverTimestamp(),
      }),
    );
  });

  test('create with someone else as member is denied', async () => {
    await assertFails(
      setDoc(doc(db(BOB), 'households/h2'), {
        name: 'X',
        members: [BOB, ALICE],
        memberNames: { [BOB]: 'Bob' },
        createdAt: serverTimestamp(),
      }),
    );
  });

  test('create with extra fields is denied', async () => {
    await assertFails(
      setDoc(doc(db(BOB), 'households/h2'), {
        name: 'X',
        members: [BOB],
        memberNames: { [BOB]: 'Bob' },
        createdAt: serverTimestamp(),
        admin: true,
      }),
    );
  });

  test('member renames household and sets own name and invite code', async () => {
    await assertSucceeds(
      updateDoc(doc(db(ALICE), `households/${H}`), {
        name: 'Nowy dom',
        [`memberNames.${ALICE}`]: 'Ala',
        inviteCode: CODE,
      }),
    );
    await assertSucceeds(updateDoc(doc(db(ALICE), `households/${H}`), { inviteCode: deleteField() }));
  });

  test("member cannot change another member's name", async () => {
    await env.withSecurityRulesDisabled((ctx) =>
      updateDoc(doc(ctx.firestore(), `households/${H}`), {
        members: [ALICE, BOB],
        [`memberNames.${BOB}`]: 'Bob',
      }),
    );
    await assertFails(
      updateDoc(doc(db(ALICE), `households/${H}`), { [`memberNames.${BOB}`]: 'Hacked' }),
    );
  });

  test('member cannot change members directly', async () => {
    await assertFails(updateDoc(doc(db(ALICE), `households/${H}`), { members: arrayUnion(EVE) }));
    await assertFails(updateDoc(doc(db(ALICE), `households/${H}`), { members: [] }));
  });

  test('household cannot be deleted', async () => {
    await assertFails(deleteDoc(doc(db(ALICE), `households/${H}`)));
  });
});

describe('joining with an invite', () => {
  test('valid code lets a user add only themselves', async () => {
    await assertSucceeds(updateDoc(doc(db(BOB), `households/${H}`), joinPayload(BOB)));
    await assertSucceeds(getDoc(doc(db(BOB), `households/${H}`)));
  });

  test('expired code is rejected', async () => {
    await assertFails(updateDoc(doc(db(BOB), `households/${H}`), joinPayload(BOB, 'EXP234')));
  });

  test('unknown code is rejected', async () => {
    await assertFails(updateDoc(doc(db(BOB), `households/${H}`), joinPayload(BOB, 'ZZZ999')));
  });

  test('missing code is rejected', async () => {
    await assertFails(
      updateDoc(doc(db(BOB), `households/${H}`), {
        members: arrayUnion(BOB),
        [`memberNames.${BOB}`]: 'Bob',
      }),
    );
  });

  test('code for another household is rejected', async () => {
    await env.withSecurityRulesDisabled(async (ctx) => {
      await setDoc(doc(ctx.firestore(), 'households/h2'), {
        name: 'Other',
        members: [EVE],
        memberNames: { [EVE]: 'Eve' },
        createdAt: Timestamp.now(),
      });
    });
    await assertFails(updateDoc(doc(db(BOB), 'households/h2'), joinPayload(BOB)));
  });

  test('joiner cannot add someone else', async () => {
    await assertFails(
      updateDoc(doc(db(BOB), `households/${H}`), {
        members: arrayUnion(EVE),
        [`memberNames.${EVE}`]: 'Eve',
        joinCode: CODE,
      }),
    );
  });

  test('joiner cannot rename the household or drop members', async () => {
    await assertFails(
      updateDoc(doc(db(BOB), `households/${H}`), { ...joinPayload(BOB), name: 'Mine' }),
    );
    await assertFails(
      updateDoc(doc(db(BOB), `households/${H}`), {
        members: [BOB],
        [`memberNames.${BOB}`]: 'Bob',
        joinCode: CODE,
      }),
    );
  });

  test('joiner must provide their name', async () => {
    await assertFails(
      updateDoc(doc(db(BOB), `households/${H}`), { members: arrayUnion(BOB), joinCode: CODE }),
    );
  });
});

describe('invites', () => {
  const invite = (overrides = {}) => ({
    householdId: H,
    createdBy: ALICE,
    expiresAt: hours(24),
    createdAt: serverTimestamp(),
    ...overrides,
  });

  test('any signed-in user can get an invite by code', async () => {
    await assertSucceeds(getDoc(doc(db(BOB), `invites/${CODE}`)));
    await assertFails(getDoc(doc(anon(), `invites/${CODE}`)));
  });

  test('invites cannot be listed', async () => {
    await assertFails(getDocs(collection(db(ALICE), 'invites')));
  });

  test('member creates a 24h invite', async () => {
    await assertSucceeds(setDoc(doc(db(ALICE), 'invites/XYZ789'), invite()));
  });

  test('non-member cannot create an invite', async () => {
    await assertFails(setDoc(doc(db(EVE), 'invites/XYZ789'), invite({ createdBy: EVE })));
  });

  test('createdBy must be the caller', async () => {
    await assertFails(setDoc(doc(db(ALICE), 'invites/XYZ789'), invite({ createdBy: BOB })));
  });

  test('validity longer than 24h is rejected', async () => {
    await assertFails(setDoc(doc(db(ALICE), 'invites/XYZ789'), invite({ expiresAt: hours(48) })));
  });

  test('already expired invite is rejected', async () => {
    await assertFails(setDoc(doc(db(ALICE), 'invites/XYZ789'), invite({ expiresAt: hours(-1) })));
  });

  test('malformed code is rejected', async () => {
    await assertFails(setDoc(doc(db(ALICE), 'invites/abc'), invite()));
    await assertFails(setDoc(doc(db(ALICE), 'invites/ABCDE0'), invite()));
  });

  test('existing invite cannot be overwritten', async () => {
    await assertFails(setDoc(doc(db(ALICE), `invites/${CODE}`), invite()));
  });

  test('member can revoke, non-member cannot', async () => {
    await assertFails(deleteDoc(doc(db(EVE), `invites/${CODE}`)));
    await assertSucceeds(deleteDoc(doc(db(ALICE), `invites/${CODE}`)));
  });
});

const dogPath = `households/${H}/dogs`;

const addBob = () =>
  env.withSecurityRulesDisabled((ctx) =>
    updateDoc(doc(ctx.firestore(), `households/${H}`), {
      members: [ALICE, BOB],
      [`memberNames.${BOB}`]: 'Bob',
    }),
  );

describe('dogs and entries', () => {

  test('member reads dogs, non-member does not', async () => {
    await assertSucceeds(getDocs(collection(db(ALICE), dogPath)));
    await assertFails(getDocs(collection(db(EVE), dogPath)));
  });

  test('member adds a dog', async () => {
    await assertSucceeds(
      setDoc(doc(db(ALICE), `${dogPath}/d2`), {
        name: 'Azor',
        breed: 'Kundel',
        birthDate: Timestamp.fromDate(new Date('2020-05-01')),
        createdAt: serverTimestamp(),
      }),
    );
  });

  test('non-member cannot add a dog', async () => {
    await assertFails(
      setDoc(doc(db(EVE), `${dogPath}/d2`), { name: 'Azor', createdAt: serverTimestamp() }),
    );
  });

  test('dog with empty name or unknown fields is rejected', async () => {
    await assertFails(
      setDoc(doc(db(ALICE), `${dogPath}/d2`), { name: '', createdAt: serverTimestamp() }),
    );
    await assertFails(
      setDoc(doc(db(ALICE), `${dogPath}/d2`), { name: 'A', chip: 1, createdAt: serverTimestamp() }),
    );
  });

  test('dogs cannot be deleted', async () => {
    await assertFails(deleteDoc(doc(db(ALICE), `${dogPath}/d1`)));
  });


  test("partner edits an entry but its author stays", async () => {
    await addBob();
    const e1 = `${dogPath}/d1/events/e1`;
    await assertSucceeds(updateDoc(doc(db(BOB), e1), { note: 'edited', deleted: true }));
    await assertSucceeds(updateDoc(doc(db(BOB), e1), { note: deleteField(), deleted: false }));
    await assertFails(updateDoc(doc(db(BOB), e1), { by: BOB }));
    await assertFails(updateDoc(doc(db(BOB), e1), { createdAt: Timestamp.now() }));
    await assertFails(updateDoc(doc(db(BOB), e1), { type: 'pee' }));
  });

  test('entries cannot be hard-deleted', async () => {
    await assertFails(deleteDoc(doc(db(ALICE), `${dogPath}/d1/events/e1`)));
  });

  test('unknown subcollections are denied', async () => {
    await assertFails(setDoc(doc(db(ALICE), `${dogPath}/d1/secrets/x`), { a: 1 }));
    await assertFails(getDocs(collection(db(ALICE), `${dogPath}/d1/secrets`)));
  });
});

describe('events', () => {
  const ev = (uid, data, id = 'new') =>
    setDoc(doc(db(uid), `${dogPath}/d1/events/${id}`), {
      at: Timestamp.now(),
      createdAt: serverTimestamp(),
      by: uid,
      deleted: false,
      ...data,
    });

  test('member adds each event type', async () => {
    await assertSucceeds(ev(ALICE, { type: 'meal', grams: 120, foodId: 'f1' }, 'a'));
    await assertSucceeds(ev(ALICE, { type: 'meal', grams: 80.5 }, 'b'));
    await assertSucceeds(ev(ALICE, { type: 'poop', poopScore: 4, poopColor: 'brown' }, 'c'));
    await assertSucceeds(ev(ALICE, { type: 'pee' }, 'd'));
    await assertSucceeds(ev(ALICE, { type: 'walk', durationMin: 45, note: 'park' }, 'e'));
    await assertSucceeds(ev(ALICE, { type: 'note', note: 'Kichał' }, 'f'));
  });

  test('non-member cannot read or add events', async () => {
    await assertFails(getDocs(collection(db(EVE), `${dogPath}/d1/events`)));
    await assertFails(ev(EVE, { type: 'pee' }));
  });

  test('by must be the caller', async () => {
    await assertFails(ev(ALICE, { type: 'pee', by: BOB }));
  });

  test('createdAt must be the server time', async () => {
    await assertFails(ev(ALICE, { type: 'pee', createdAt: Timestamp.now() }));
  });

  test('unknown type or fields are rejected', async () => {
    await assertFails(ev(ALICE, { type: 'bath' }));
    await assertFails(ev(ALICE, { type: 'pee', mood: 'happy' }));
  });

  test('type-specific fields are required and bounded', async () => {
    await assertFails(ev(ALICE, { type: 'meal' }));
    await assertFails(ev(ALICE, { type: 'meal', grams: 0 }));
    await assertFails(ev(ALICE, { type: 'meal', grams: 6000 }));
    await assertFails(ev(ALICE, { type: 'poop' }));
    await assertFails(ev(ALICE, { type: 'poop', poopScore: 0 }));
    await assertFails(ev(ALICE, { type: 'poop', poopScore: 8 }));
    await assertFails(ev(ALICE, { type: 'poop', poopScore: 3.5 }));
    await assertFails(ev(ALICE, { type: 'poop', poopScore: 4, poopColor: 'pink' }));
    await assertFails(ev(ALICE, { type: 'walk' }));
    await assertFails(ev(ALICE, { type: 'walk', durationMin: 0 }));
    await assertFails(ev(ALICE, { type: 'note' }));
    await assertFails(ev(ALICE, { type: 'note', note: '' }));
    await assertFails(ev(ALICE, { type: 'pee', note: 'x'.repeat(501) }));
  });

  test('time may be in the past but not far in the future', async () => {
    await assertSucceeds(ev(ALICE, { type: 'pee', at: hours(-48) }, 'past'));
    await assertSucceeds(ev(ALICE, { type: 'pee', at: hours(0.5) }, 'skew'));
    await assertFails(ev(ALICE, { type: 'pee', at: hours(3) }));
    await assertFails(ev(ALICE, { type: 'pee', at: 'today' }));
  });

  test('soft delete must stay boolean', async () => {
    await assertFails(updateDoc(doc(db(ALICE), `${dogPath}/d1/events/e1`), { deleted: 'yes' }));
  });
});

describe('foods', () => {
  const foods = `${dogPath}/d1/foods`;

  test('member adds and edits a food', async () => {
    await assertSucceeds(
      setDoc(doc(db(ALICE), `${foods}/f2`), {
        name: 'Brit',
        brand: 'Brit Care',
        active: true,
        createdAt: serverTimestamp(),
      }),
    );
    await assertSucceeds(updateDoc(doc(db(ALICE), `${foods}/f1`), { brand: 'Champion', active: false }));
    await assertFails(updateDoc(doc(db(ALICE), `${foods}/f1`), { createdAt: Timestamp.now() }));
  });

  test('non-member cannot read or add foods', async () => {
    await assertFails(getDocs(collection(db(EVE), foods)));
    await assertFails(
      setDoc(doc(db(EVE), `${foods}/f2`), { name: 'X', active: true, createdAt: serverTimestamp() }),
    );
  });

  test('invalid foods are rejected', async () => {
    const f = (data) =>
      setDoc(doc(db(ALICE), `${foods}/f2`), { active: true, createdAt: serverTimestamp(), ...data });
    await assertFails(f({ name: '' }));
    await assertFails(f({ name: 'X', price: 10 }));
    await assertFails(f({ name: 'X', active: 'yes' }));
    await assertFails(f({ name: 'X', brand: 'b'.repeat(51) }));
  });

  test('foods cannot be hard-deleted', async () => {
    await assertFails(deleteDoc(doc(db(ALICE), `${foods}/f1`)));
  });
});

describe('food ratings', () => {
  const f1 = `${dogPath}/d1/foods/f1`;

  test('rating is one of good/neutral/bad and can be cleared', async () => {
    await assertSucceeds(updateDoc(doc(db(ALICE), f1), { rating: 'good' }));
    await assertSucceeds(updateDoc(doc(db(ALICE), f1), { rating: deleteField() }));
    await assertFails(updateDoc(doc(db(ALICE), f1), { rating: 'great' }));
  });
});

describe('purchases', () => {
  const purchases = `${dogPath}/d1/purchases`;
  const buy = (uid, data, id = 'p1') =>
    setDoc(doc(db(uid), `${purchases}/${id}`), {
      foodId: 'f1',
      kg: 12,
      at: Timestamp.now(),
      by: uid,
      createdAt: serverTimestamp(),
      deleted: false,
      ...data,
    });

  test('member adds a purchase with or without a price', async () => {
    await assertSucceeds(buy(ALICE, { price: 249.99 }, 'a'));
    await assertSucceeds(buy(ALICE, { kg: 1.5 }, 'b'));
  });

  test('non-member cannot read or add purchases', async () => {
    await assertFails(getDocs(collection(db(EVE), purchases)));
    await assertFails(buy(EVE, {}));
  });

  test('author and server time are enforced', async () => {
    await assertFails(buy(ALICE, { by: BOB }));
    await assertFails(buy(ALICE, { createdAt: Timestamp.now() }));
  });

  test('invalid purchases are rejected', async () => {
    await assertFails(buy(ALICE, { kg: 0 }));
    await assertFails(buy(ALICE, { kg: 150 }));
    await assertFails(buy(ALICE, { kg: '12' }));
    await assertFails(buy(ALICE, { price: -1 }));
    await assertFails(buy(ALICE, { foodId: '' }));
    await assertFails(buy(ALICE, { at: hours(3) }));
    await assertFails(buy(ALICE, { shop: 'Zooplus' }));
  });

  test('partner soft-deletes a purchase; author stays; no hard delete', async () => {
    await addBob();
    await assertSucceeds(buy(ALICE, {}));
    const p1 = doc(db(BOB), `${purchases}/p1`);
    await assertSucceeds(updateDoc(p1, { deleted: true }));
    await assertFails(updateDoc(p1, { by: BOB }));
    await assertFails(deleteDoc(p1));
  });
});

describe('weights', () => {
  const weights = `${dogPath}/d1/weights`;
  const w = (uid, data, id = 'w1') =>
    setDoc(doc(db(uid), `${weights}/${id}`), {
      kg: 12.5,
      at: Timestamp.now(),
      by: uid,
      createdAt: serverTimestamp(),
      deleted: false,
      ...data,
    });

  test('member adds a plausible weight', async () => {
    await assertSucceeds(w(ALICE, {}));
    await assertSucceeds(w(ALICE, { kg: 3, at: hours(-24 * 30) }, 'w2'));
  });

  test('non-member cannot read or add weights', async () => {
    await assertFails(getDocs(collection(db(EVE), weights)));
    await assertFails(w(EVE, {}));
  });

  test('author and server time are enforced', async () => {
    await assertFails(w(ALICE, { by: BOB }));
    await assertFails(w(ALICE, { createdAt: Timestamp.now() }));
  });

  test('implausible or malformed weights are rejected', async () => {
    await assertFails(w(ALICE, { kg: 0 }));
    await assertFails(w(ALICE, { kg: 150 }));
    await assertFails(w(ALICE, { kg: '12' }));
    await assertFails(w(ALICE, { at: hours(3) }));
    await assertFails(w(ALICE, { deleted: 'no' }));
    await assertFails(w(ALICE, { note: 'po spacerze' }));
  });

  test('partner edits and soft-deletes; author stays; no hard delete', async () => {
    await addBob();
    await assertSucceeds(w(ALICE, {}));
    const w1 = doc(db(BOB), `${weights}/w1`);
    await assertSucceeds(updateDoc(w1, { kg: 12.7, at: Timestamp.now() }));
    await assertSucceeds(updateDoc(w1, { deleted: true }));
    await assertFails(updateDoc(w1, { by: BOB }));
    await assertFails(updateDoc(w1, { createdAt: Timestamp.now() }));
    await assertFails(deleteDoc(w1));
  });

  test('a pre-stage-5 entry without createdAt/deleted can be soft-deleted', async () => {
    await env.withSecurityRulesDisabled((ctx) =>
      setDoc(doc(ctx.firestore(), `${weights}/old`), { kg: 12, at: Timestamp.now(), by: ALICE }),
    );
    await assertSucceeds(updateDoc(doc(db(ALICE), `${weights}/old`), { deleted: true }));
  });
});

describe('health entries', () => {
  const health = `${dogPath}/d1/health`;
  const days = (n) => hours(24 * n);
  const entry = (uid, data, id = 'e1') =>
    setDoc(doc(db(uid), `${health}/${id}`), {
      type: 'vaccination',
      templateId: 'rabies',
      name: 'Wścieklizna',
      date: Timestamp.now(),
      nextDue: days(365),
      by: uid,
      createdAt: serverTimestamp(),
      deleted: false,
      ...data,
    });

  test('member adds entries of each type, with or without next due', async () => {
    await assertSucceeds(entry(ALICE, {}));
    await assertSucceeds(entry(ALICE, { type: 'deworming', templateId: 'deworming', name: 'Odrobaczanie' }, 'e2'));
    await assertSucceeds(entry(ALICE, { type: 'ticks', name: 'Obroża', note: 'Seresto' }, 'e3'));
    await assertSucceeds(
      setDoc(doc(db(ALICE), `${health}/e4`), {
        type: 'vet',
        name: 'Wizyta',
        date: Timestamp.now(),
        by: ALICE,
        createdAt: serverTimestamp(),
        deleted: false,
      }),
    );
    await assertSucceeds(entry(ALICE, { date: days(-400), nextDue: days(-35) }, 'e5'));
  });

  test('non-member cannot read or add', async () => {
    await assertFails(getDocs(collection(db(EVE), health)));
    await assertFails(entry(EVE, {}));
  });

  test('author and server time are enforced', async () => {
    await assertFails(entry(ALICE, { by: BOB }));
    await assertFails(entry(ALICE, { createdAt: Timestamp.now() }));
  });

  test('invalid entries are rejected', async () => {
    await assertFails(entry(ALICE, { type: 'grooming' }));
    await assertFails(entry(ALICE, { name: '' }));
    await assertFails(entry(ALICE, { name: 'x'.repeat(51) }));
    await assertFails(entry(ALICE, { date: days(2) }));
    await assertFails(entry(ALICE, { nextDue: days(-1) }));
    await assertFails(entry(ALICE, { note: 'x'.repeat(501) }));
    await assertFails(entry(ALICE, { clinic: 'Vetka' }));
  });

  test('partner edits and soft-deletes; author stays; no hard delete', async () => {
    await addBob();
    await assertSucceeds(entry(ALICE, {}));
    const e1 = doc(db(BOB), `${health}/e1`);
    await assertSucceeds(updateDoc(e1, { nextDue: deleteField(), note: 'przesunięte' }));
    await assertSucceeds(updateDoc(e1, { deleted: true }));
    await assertFails(updateDoc(e1, { by: BOB }));
    await assertFails(updateDoc(e1, { createdAt: Timestamp.now() }));
    await assertFails(deleteDoc(e1));
  });
});

describe('health templates', () => {
  const templates = `households/${H}/healthTemplates`;
  const tpl = (uid, data, id = 'tick_collar') =>
    setDoc(
      doc(db(uid), `${templates}/${id}`),
      { name: 'Obroża na kleszcze', type: 'ticks', intervalMonths: 6, mandatory: false, active: true, ...data },
      { merge: true },
    );

  test('member overrides a default and adds a custom template', async () => {
    await assertSucceeds(tpl(ALICE, {}));
    await assertSucceeds(tpl(ALICE, { intervalMonths: 8 }));
    await assertSucceeds(tpl(ALICE, { name: 'Lepto', type: 'vaccination', intervalMonths: 12, createdAt: serverTimestamp() }, 'c1'));
    await assertSucceeds(tpl(ALICE, { intervalMonths: deleteField() }, 'c2'));
  });

  test('non-member cannot read or write templates', async () => {
    await assertFails(getDocs(collection(db(EVE), templates)));
    await assertFails(tpl(EVE, {}));
  });

  test('invalid templates are rejected; no hard delete', async () => {
    await assertFails(tpl(ALICE, { type: 'spa' }));
    await assertFails(tpl(ALICE, { intervalMonths: 0 }));
    await assertFails(tpl(ALICE, { intervalMonths: 2.5 }));
    await assertFails(tpl(ALICE, { mandatory: 'yes' }));
    await assertFails(tpl(ALICE, { name: '' }));
    await assertFails(tpl(ALICE, { price: 10 }));
    await assertFails(tpl(ALICE, { createdAt: Timestamp.now() }, 'c3'));
    await assertSucceeds(tpl(ALICE, {}));
    await assertFails(deleteDoc(doc(db(ALICE), `${templates}/tick_collar`)));
  });
});
