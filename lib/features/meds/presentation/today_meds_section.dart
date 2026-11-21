import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/utils/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../household/application/household_providers.dart';
import '../application/med_providers.dart';
import '../domain/med.dart';
import '../domain/med_dose.dart';
import '../domain/med_schedule.dart';
import 'med_labels.dart';

/// "Leki na dziś" on Today: tap a dose to tick or untick it.
/// Hidden when nothing is due today.
class TodayMedsSection extends ConsumerWidget {
  const TodayMedsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final now = ref.watch(clockProvider)();
    final slots = dosesOn(
      ref.watch(medsProvider).value ?? const <Med>[],
      ref.watch(medDosesProvider).value ?? const <MedDose>[],
      now,
    );
    if (slots.isEmpty) return const SizedBox.shrink();
    final household = ref.watch(currentHouseholdProvider).value;
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
          child: Text(l10n.medsToday, style: textTheme.titleMedium),
        ),
        for (final s in slots)
          CheckboxListTile(
            key: Key('dose-${doseId(s.med.id, s.slot)}'),
            value: s.given,
            onChanged: (v) => ref
                .read(medControllerProvider.notifier)
                .setGiven(s.med.id, s.slot, given: v ?? false),
            secondary: Icon(
              Icons.medication_outlined,
              color: !s.given && s.slot.isBefore(now) ? scheme.error : null,
            ),
            title: Text(medTitle(s.med)),
            subtitle: Text(
              [
                DateFormat.Hm().format(s.slot),
                if (s.dose case final dose?)
                  l10n.medGivenBy(
                    household?.nameOf(dose.by) ?? '',
                    DateFormat.Hm().format(dose.givenAt),
                  ),
              ].join(' · '),
            ),
          ),
      ],
    );
  }
}
