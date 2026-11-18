import 'dart:math';

import 'package:dog_app/features/household/domain/invite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InviteCode', () {
    test('generates valid codes without confusable characters', () {
      final random = Random(42);
      for (var i = 0; i < 500; i++) {
        final code = InviteCode.generate(random);
        expect(InviteCode.isValid(code), isTrue, reason: code);
        expect(code, isNot(matches(RegExp('[01ILO]'))));
      }
    });

    test('alphabet matches the firestore.rules regex', () {
      final rulesRegex = RegExp(r'^[A-HJ-KMNP-Z2-9]$');
      for (final c in InviteCode.alphabet.split('')) {
        expect(rulesRegex.hasMatch(c), isTrue, reason: c);
      }
      expect(InviteCode.alphabet.length, 31);
    });

    test('normalize uppercases and strips spaces and dashes', () {
      expect(InviteCode.normalize(' abc-234 '), 'ABC234');
      expect(InviteCode.normalize('abc 234'), 'ABC234');
    });

    test('rejects wrong length and forbidden characters', () {
      expect(InviteCode.isValid('ABC23'), isFalse);
      expect(InviteCode.isValid('ABC2345'), isFalse);
      expect(InviteCode.isValid('ABCDE0'), isFalse);
      expect(InviteCode.isValid('abc234'), isFalse);
    });
  });

  test('Invite is valid until expiresAt', () {
    final invite = Invite(
      code: 'ABC234',
      householdId: 'h',
      createdBy: 'u',
      expiresAt: DateTime(2026, 1, 2, 12),
    );
    expect(invite.isValidAt(DateTime(2026, 1, 2, 11, 59)), isTrue);
    expect(invite.isValidAt(DateTime(2026, 1, 2, 12)), isFalse);
  });
}
