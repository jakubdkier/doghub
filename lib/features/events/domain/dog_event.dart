import 'package:freezed_annotation/freezed_annotation.dart';

part 'dog_event.freezed.dart';

/// Stored as [name]; must match `validEvent()` in firestore.rules.
enum EventType { meal, poop, pee, walk, note }

/// Stored as [name]; must match `validEvent()` in firestore.rules.
enum PoopColor { brown, dark, yellow, green, grey, bloody }

/// Validation bounds shared with firestore.rules.
abstract final class EventLimits {
  static const maxGrams = 5000;
  static const minPoopScore = 1;
  static const maxPoopScore = 7;
  static const maxDurationMin = 1440;
  static const maxNoteLength = 500;
  static const walkPresetsMin = [15, 30, 45, 60];
}

@freezed
abstract class DogEvent with _$DogEvent {
  const factory DogEvent({
    /// Null until assigned by the repository.
    String? id,
    required EventType type,

    /// When it happened (device time, user-editable). Used for sorting.
    required DateTime at,

    /// Uid of the creator; never changes.
    required String by,

    /// Server time of creation; null until synced.
    DateTime? createdAt,
    String? foodId,
    int? grams,
    int? poopScore,
    PoopColor? poopColor,
    int? durationMin,
    String? note,
    @Default(false) bool deleted,
  }) = _DogEvent;

  const DogEvent._();

  /// Whether the type-specific required values are present and in range
  /// (mirrors firestore.rules so invalid writes never leave the device).
  bool get isValid {
    bool inRange(int? v, int min, int max) => v != null && v >= min && v <= max;
    final noteOk = note == null || note!.length <= EventLimits.maxNoteLength;
    return noteOk &&
        switch (type) {
          EventType.meal => inRange(grams, 1, EventLimits.maxGrams),
          EventType.poop => inRange(
            poopScore,
            EventLimits.minPoopScore,
            EventLimits.maxPoopScore,
          ),
          EventType.walk => inRange(durationMin, 1, EventLimits.maxDurationMin),
          EventType.pee => true,
          EventType.note => note != null && note!.trim().isNotEmpty,
        };
  }

  /// Newest first; ties broken by id for a stable order.
  static int newestFirst(DogEvent a, DogEvent b) {
    final c = b.at.compareTo(a.at);
    return c != 0 ? c : (a.id ?? '').compareTo(b.id ?? '');
  }
}
