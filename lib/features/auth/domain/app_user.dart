import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// Signed-in user, independent of Firebase types.
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    String? displayName,
    String? email,
    String? photoUrl,
  }) = _AppUser;

  const AppUser._();

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  /// Short name shown to other household members: first name, else the
  /// e-mail local part.
  String get preferredName {
    final first = displayName?.trim().split(RegExp(r'\s+')).first ?? '';
    if (first.isNotEmpty) return first;
    final local = email?.split('@').first ?? '';
    return local.isNotEmpty ? local : 'Ja';
  }
}
