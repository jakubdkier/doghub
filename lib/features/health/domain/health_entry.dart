import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_entry.freezed.dart';

/// Stored as [name]; must match firestore.rules.
enum HealthType { vaccination, deworming, ticks, vet }

/// Bounds shared with `validHealth()` in firestore.rules.
abstract final class HealthLimits {
  static const maxNameLength = 50;
  static const maxNoteLength = 500;
}

@freezed
abstract class HealthEntry with _$HealthEntry {
  const factory HealthEntry({
    String? id,
    required HealthType type,

    /// Template it was created from; null for one-off entries.
    String? templateId,

    /// Shown name, copied from the template so renames don't rewrite history.
    required String name,

    /// Day it was done (stored at noon).
    required DateTime date,

    /// When the next one is due; null when nothing follows.
    DateTime? nextDue,
    String? note,
    required String by,
    DateTime? createdAt,
    @Default(false) bool deleted,
  }) = _HealthEntry;

  const HealthEntry._();

  /// Entries with the same key form a series (e.g. all rabies shots).
  String get seriesKey =>
      templateId ?? 'custom:${type.name}:${name.trim().toLowerCase()}';

  static int newestFirst(HealthEntry a, HealthEntry b) {
    final c = b.date.compareTo(a.date);
    if (c != 0) return c;
    return (b.createdAt ?? b.date).compareTo(a.createdAt ?? a.date);
  }
}
