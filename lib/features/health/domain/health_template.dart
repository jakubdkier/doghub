import 'package:freezed_annotation/freezed_annotation.dart';

import 'health_entry.dart';

part 'health_template.freezed.dart';

@freezed
abstract class HealthTemplate with _$HealthTemplate {
  static const maxIntervalMonths = 60;

  const factory HealthTemplate({
    required String id,
    required String name,
    required HealthType type,

    /// Months until the next one; null when there's no fixed schedule.
    int? intervalMonths,
    @Default(false) bool mandatory,
    @Default(true) bool active,
  }) = _HealthTemplate;

  const HealthTemplate._();

  bool get isBuiltIn => defaultHealthTemplates.any((t) => t.id == id);
}

/// Built-in templates; a stored template with the same id overrides one.
const defaultHealthTemplates = [
  HealthTemplate(
    id: 'rabies',
    name: 'Wścieklizna',
    type: HealthType.vaccination,
    intervalMonths: 12,
    mandatory: true,
  ),
  HealthTemplate(
    id: 'dhppi',
    name: 'Szczepienie zakaźne (DHPPi+L)',
    type: HealthType.vaccination,
    intervalMonths: 12,
  ),
  HealthTemplate(
    id: 'deworming',
    name: 'Odrobaczanie',
    type: HealthType.deworming,
    intervalMonths: 3,
  ),
  HealthTemplate(
    id: 'tick_collar',
    name: 'Obroża na kleszcze',
    type: HealthType.ticks,
    intervalMonths: 6,
  ),
  HealthTemplate(
    id: 'vet_checkup',
    name: 'Kontrola u weta',
    type: HealthType.vet,
    intervalMonths: 12,
  ),
];

/// Defaults overridden by stored templates, plus custom ones; defaults
/// first in their fixed order, then custom ones by name.
List<HealthTemplate> mergeTemplates(Iterable<HealthTemplate> stored) {
  final byId = {for (final t in stored) t.id: t};
  final custom = byId.values.where((t) => !t.isBuiltIn).toList()
    ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  return [for (final d in defaultHealthTemplates) byId[d.id] ?? d, ...custom];
}
