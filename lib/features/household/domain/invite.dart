import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite.freezed.dart';

@freezed
abstract class Invite with _$Invite {
  const factory Invite({
    required String code,
    required String householdId,
    required String createdBy,
    required DateTime expiresAt,
  }) = _Invite;

  const Invite._();

  static const validity = Duration(hours: 24);

  bool isValidAt(DateTime now) => expiresAt.isAfter(now);
}

/// Six-character invite codes without easily confused characters
/// (no 0/O, 1/I/L). Must match the regex in firestore.rules.
abstract final class InviteCode {
  static const length = 6;
  static const alphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
  static final _pattern = RegExp('^[$alphabet]{$length}\$');

  static String generate([Random? random]) {
    final r = random ?? Random.secure();
    return List.generate(
      length,
      (_) => alphabet[r.nextInt(alphabet.length)],
    ).join();
  }

  /// Uppercases and strips spaces and dashes typed by the user.
  static String normalize(String input) =>
      input.toUpperCase().replaceAll(RegExp(r'[\s-]'), '');

  static bool isValid(String code) => _pattern.hasMatch(code);
}
