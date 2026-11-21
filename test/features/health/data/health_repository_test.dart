import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/features/health/data/health_repository.dart';
import 'package:dog_app/features/health/data/health_template_repository.dart';
import 'package:dog_app/features/health/domain/health_entry.dart';
import 'package:dog_app/features/health/domain/health_template.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const path = 'households/h1/dogs/d1/health';
  late FakeFirebaseFirestore db;
  late HealthRepository repo;

  setUp(() {
    db = FakeFirebaseFirestore();
    repo = HealthRepository(db);
  });

  test(
    'add writes rule-compliant keys at noon; update clears optionals',
    () async {
      final id = repo.add(
        'h1',
        'd1',
        HealthEntry(
          type: HealthType.ticks,
          templateId: 'tick_collar',
          name: ' Obroża na kleszcze ',
          date: DateTime(2026, 11, 20, 8),
          nextDue: DateTime(2027, 5, 20, 8),
          note: '  ',
          by: 'u1',
        ),
      );
      await pumpEventQueue();
      var raw = (await db.doc('$path/$id').get()).data()!;
      expect(raw.keys.toSet(), {
        'type',
        'templateId',
        'name',
        'date',
        'nextDue',
        'by',
        'createdAt',
        'deleted',
      });
      expect(raw['name'], 'Obroża na kleszcze');
      expect((raw['date'] as Timestamp).toDate(), DateTime(2026, 11, 20, 12));
      expect((raw['nextDue'] as Timestamp).toDate(), DateTime(2027, 5, 20, 12));

      final entry = (await repo.watchAll('h1', 'd1').first).single;
      repo.update(
        'h1',
        'd1',
        entry.copyWith(nextDue: null, note: 'Seresto', by: 'x'),
      );
      await pumpEventQueue();
      raw = (await db.doc('$path/$id').get()).data()!;
      expect(raw.containsKey('nextDue'), isFalse);
      expect(raw['note'], 'Seresto');
      expect(raw['by'], 'u1');

      repo.setDeleted('h1', 'd1', id, deleted: true);
      await pumpEventQueue();
      expect(await repo.watchAll('h1', 'd1').first, isEmpty);
    },
  );

  test('templates: override a default by id and add a custom one', () async {
    final templates = HealthTemplateRepository(db);
    templates.save(
      'h1',
      const HealthTemplate(
        id: 'tick_collar',
        name: 'Seresto',
        type: HealthType.ticks,
        intervalMonths: 8,
      ),
    );
    final id = templates.newId('h1');
    templates.save(
      'h1',
      HealthTemplate(id: id, name: 'Zęby', type: HealthType.vet),
    );
    await pumpEventQueue();

    final merged = mergeTemplates(await templates.watchStored('h1').first);
    expect(merged.firstWhere((t) => t.id == 'tick_collar').intervalMonths, 8);
    expect(merged.last.name, 'Zęby');
    expect(merged.last.intervalMonths, isNull);
    final raw = (await db.doc('households/h1/healthTemplates/$id').get())
        .data()!;
    expect(raw.keys.toSet(), {'name', 'type', 'mandatory', 'active'});
  });
}
