import 'package:freezed_annotation/freezed_annotation.dart';

part 'dog.freezed.dart';

@freezed
abstract class Dog with _$Dog {
  const factory Dog({
    required String id,
    required String name,
    String? breed,
    DateTime? birthDate,

    /// Null until the server timestamp is synced.
    DateTime? createdAt,
  }) = _Dog;

  const Dog._();

  /// Oldest first; dogs still pending sync go last.
  static int byCreation(Dog a, Dog b) {
    final ca = a.createdAt, cb = b.createdAt;
    if (ca == null && cb == null) return a.name.compareTo(b.name);
    if (ca == null) return 1;
    if (cb == null) return -1;
    return ca.compareTo(cb);
  }
}
