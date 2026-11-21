import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/routes.dart';
import '../../../core/utils/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../household/application/household_providers.dart';
import '../application/health_providers.dart';
import '../domain/health_entry.dart';
import '../domain/health_schedule.dart';
import 'health_labels.dart';

/// `/health/type/:type`: series status and full history of one type.
class HealthSectionPage extends ConsumerWidget {
  const HealthSectionPage({super.key, required this.type});

  final HealthType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final now = ref.watch(clockProvider)();
    final series = [
      for (final s
          in ref.watch(healthSeriesListProvider) ?? const <HealthSeries>[])
        if (s.type == type) s,
    ];
    final entries = [
      for (final e
          in ref.watch(healthEntriesProvider).value ?? const <HealthEntry>[])
        if (e.type == type) e,
    ];

    return Scaffold(
      appBar: AppBar(title: Text(type.label(l10n))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.healthNewFor(type.name)),
        icon: const Icon(Icons.add),
        label: Text(l10n.healthAdd),
      ),
      body: entries.isEmpty
          ? Center(child: Text(l10n.healthNoEntries))
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
              children: [
                for (final s in series)
                  Card(
                    child: ListTile(
                      leading: Icon(type.icon),
                      title: Text(s.latest.name),
                      subtitle: Text(dueText(l10n, s.nextDue, now)),
                      trailing: HealthStatusChip(status: s.status),
                      onTap: () =>
                          context.push(Routes.healthEntry(s.latest.id!)),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(l10n.healthHistory, style: textTheme.titleSmall),
                for (final e in entries) _EntryTile(entry: e),
              ],
            ),
    );
  }
}

class _EntryTile extends ConsumerWidget {
  const _EntryTile({required this.entry});

  final HealthEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final author =
        ref.watch(currentHouseholdProvider).value?.nameOf(entry.by) ?? '';
    final id = entry.id!;
    final note = entry.note;

    return Dismissible(
      key: ValueKey('health-$id'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: scheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Icon(Icons.delete_outline, color: scheme.onErrorContainer),
      ),
      // The list updates from the soft delete; don't remove the row twice.
      confirmDismiss: (_) async {
        deleteHealthWithUndo(context, ref, id);
        return false;
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(entry.name),
        subtitle: Text(
          [
            '${DateFormat.yMMMMd().format(entry.date)} · $author',
            if (note != null && note.isNotEmpty) note,
          ].join('\n'),
        ),
        isThreeLine: note != null && note.isNotEmpty,
        onTap: () => context.push(Routes.healthEntry(id)),
      ),
    );
  }
}

void deleteHealthWithUndo(BuildContext context, WidgetRef ref, String id) {
  final l10n = AppLocalizations.of(context);
  final controller = ref.read(healthControllerProvider.notifier);
  controller.delete(id);
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(l10n.healthEntryDeleted),
        persist: false,
        action: SnackBarAction(
          label: l10n.undo,
          onPressed: () => controller.restore(id),
        ),
      ),
    );
}
