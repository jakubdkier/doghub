import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../food/application/food_providers.dart';
import '../../food/domain/food.dart';
import '../../household/application/household_providers.dart';
import '../application/event_providers.dart';
import '../application/hidden_events.dart';
import '../domain/dog_event.dart';
import 'event_labels.dart';

/// Soft-deletes [id] and offers undo in a snackbar.
void deleteEventWithUndo(BuildContext context, WidgetRef ref, String id) {
  final l10n = AppLocalizations.of(context);
  final controller = ref.read(eventControllerProvider.notifier);
  final hidden = ref.read(hiddenEventsProvider.notifier);
  hidden.hide(id);
  controller.delete(id);
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(l10n.eventDeleted),
        persist: false,
        action: SnackBarAction(
          label: l10n.undo,
          onPressed: () {
            controller.restore(id);
            hidden.show(id);
          },
        ),
      ),
    );
}

/// Timeline row: swipe to delete, tap to edit.
class EventTile extends ConsumerWidget {
  const EventTile({super.key, required this.event});

  final DogEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final foods = {
      for (final f in ref.watch(foodsProvider).value ?? const <Food>[]) f.id: f,
    };
    final author =
        ref.watch(currentHouseholdProvider).value?.nameOf(event.by) ?? '';
    final id = event.id!;
    final note = event.note;

    Widget background(Alignment alignment) => Container(
      color: scheme.errorContainer,
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Icon(Icons.delete_outline, color: scheme.onErrorContainer),
    );

    return Dismissible(
      key: ValueKey('event-$id'),
      background: background(Alignment.centerLeft),
      secondaryBackground: background(Alignment.centerRight),
      onDismissed: (_) => deleteEventWithUndo(context, ref, id),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: scheme.secondaryContainer,
          foregroundColor: scheme.onSecondaryContainer,
          child: Icon(event.type.icon),
        ),
        title: Text(eventSummary(l10n, event, foods: foods)),
        subtitle: Text(
          [
            l10n.eventAuthorTime(DateFormat.Hm().format(event.at), author),
            if (note != null && note.isNotEmpty) note,
          ].join('\n'),
        ),
        isThreeLine: note != null && note.isNotEmpty,
        onTap: () => context.push(Routes.event(id)),
      ),
    );
  }
}
