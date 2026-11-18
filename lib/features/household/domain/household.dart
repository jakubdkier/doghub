import 'package:freezed_annotation/freezed_annotation.dart';

part 'household.freezed.dart';

@freezed
abstract class Household with _$Household {
  const factory Household({
    required String id,
    required String name,
    required List<String> members,
    @Default({}) Map<String, String> memberNames,
    String? inviteCode,
  }) = _Household;

  const Household._();

  /// Display name of a member, falling back to a neutral label.
  String nameOf(String uid, {String fallback = '?'}) =>
      memberNames[uid] ?? fallback;
}
