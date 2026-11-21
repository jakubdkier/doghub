import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ProviderListenableSelect;
import 'package:material_ui/material_ui.dart' show Locale;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../l10n/app_localizations.dart';
import '../../dogs/application/dog_providers.dart';
import '../../events/application/event_providers.dart';
import '../../events/domain/dog_event.dart';
import '../../events/domain/event_timeline.dart';
import '../../food/application/food_providers.dart';
import '../../food/application/purchase_providers.dart';
import '../../food/domain/food.dart';
import '../../food/presentation/stock_labels.dart';
import '../../health/application/health_providers.dart';
import '../../health/domain/health_schedule.dart';
import '../../meds/application/med_providers.dart';
import '../../meds/domain/med.dart';
import '../../meds/domain/med_dose.dart';
import '../../meds/domain/med_schedule.dart';
import '../../../core/utils/clock.dart';
import '../../settings/application/reminder_settings_provider.dart';
import '../data/home_widget_service.dart';
import '../domain/widget_snapshot.dart';

part 'home_widget_sync.g.dart';

final _l10n = lookupAppLocalizations(const Locale('pl'));

/// Current widget content; [WidgetSnapshot.empty] without a dog.
@Riverpod(keepAlive: true)
WidgetSnapshot widgetSnapshot(Ref ref) {
  final dogName = ref.watch(currentDogProvider.select((d) => d?.name));
  if (dogName == null) return WidgetSnapshot.empty;

  final recent = ref.watch(recentEventsProvider).value ?? const <DogEvent>[];
  final foods = ref.watch(foodsProvider).value ?? const <Food>[];
  final food = currentFood(foods, latestOfType(recent, EventType.meal)?.foodId);
  final stock = food == null ? null : ref.watch(stockProvider)?[food.id];
  final threshold = ref.watch(
    reminderSettingsControllerProvider.select((s) => s.foodThresholdKg),
  );

  final attention = attentionNeeded(
    ref.watch(healthSeriesListProvider) ?? const <HealthSeries>[],
  );
  final overdue = attention.where((s) => s.status == HealthStatus.overdue);

  final now = ref.read(clockProvider)();
  final doses = dosesOn(
    ref.watch(medsProvider).value ?? const <Med>[],
    ref.watch(medDosesProvider).value ?? const <MedDose>[],
    now,
  );
  final givenCount = doses.where((d) => d.given).length;

  return WidgetSnapshot(
    ready: true,
    dogName: dogName,
    lastMealAt: latestOfType(recent, EventType.meal)?.at,
    lastPoopAt: latestOfType(recent, EventType.poop)?.at,
    lastWalkAt: latestOfType(recent, EventType.walk)?.at,
    foodText: (stock == null || !stock.hasPurchases)
        ? null
        : _l10n.widgetFood(stockSummary(_l10n, stock)),
    foodLow:
        stock != null && stock.hasPurchases && stock.remainingKg <= threshold,
    healthText: attention.isEmpty
        ? null
        : overdue.isNotEmpty
        ? _l10n.widgetHealthOverdue(overdue.length)
        : _l10n.widgetHealthSoon(attention.length),
    healthOverdue: overdue.isNotEmpty,
    medsText: doses.isEmpty ? null : _l10n.widgetMeds(givenCount, doses.length),
    medsMissed: doses.any((d) => !d.given && d.slot.isBefore(now)),
  );
}

/// Pushes the snapshot to the home screen widgets when it changes.
/// Watched by the app root.
@Riverpod(keepAlive: true)
void homeWidgetSync(Ref ref) {
  final snapshot = ref.watch(widgetSnapshotProvider);
  unawaited(ref.read(homeWidgetServiceProvider).update(snapshot));
}
