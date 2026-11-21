import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/routes.dart';
import '../../../core/utils/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../application/med_providers.dart';
import '../domain/med.dart';
import '../domain/med_dose.dart';
import '../domain/med_schedule.dart';
import 'med_labels.dart';

/// `/health/meds`: active and ended meds with 7-day adherence.
class MedsPage extends ConsumerWidget {
  const MedsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final meds = ref.watch(medsProvider).value ?? const <Med>[];
    final doses = ref.watch(medDosesProvider).value ?? const <MedDose>[];
    final now = ref.watch(clockProvider)();
    final active = meds.where((m) => m.active);
    final ended = meds.where((m) => !m.active);

    Widget tile(Med m) {
      final a = adherence(m, doses, now);
      return ListTile(
        key: Key('med-${m.id}'),
        leading: const Icon(Icons.medication_outlined),
        title: Text(medTitle(m)),
        subtitle: Text(
          [
            scheduleText(l10n, m),
            if (m.active && a.expected > 0)
              l10n.medAdherence(a.given, a.expected),
          ].join('\n'),
        ),
        isThreeLine: m.active && a.expected > 0,
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(Routes.med(m.id)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.medsTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.medNew),
        icon: const Icon(Icons.add),
        label: Text(l10n.medAdd),
      ),
      body: meds.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.medsEmpty, textAlign: TextAlign.center),
              ),
            )
          : ListView(
              padding: const EdgeInsets.only(bottom: 88),
              children: [
                ...active.map(tile),
                if (ended.isNotEmpty) ...[
                  ListTile(
                    title: Text(
                      l10n.medsEnded,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  ...ended.map(tile),
                ],
              ],
            ),
    );
  }
}
