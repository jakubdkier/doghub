import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../l10n/app_localizations.dart';
import '../../household/application/household_providers.dart';
import '../application/event_providers.dart';
import 'event_form.dart';
import 'event_labels.dart';
import 'event_tile.dart';

/// `/event/:id`: edit or delete an existing entry.
class EventEditPage extends ConsumerWidget {
  const EventEditPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final async = ref.watch(eventProvider(id));
    final event = async.value;
    final household = ref.watch(currentHouseholdProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: Text(event?.type.label(l10n) ?? l10n.editEventTitle),
        actions: [
          if (event != null && !event.deleted)
            IconButton(
              tooltip: l10n.delete,
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                deleteEventWithUndo(context, ref, id);
                context.pop();
              },
            ),
        ],
      ),
      body: switch (async) {
        _ when event != null => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (household != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Icon(event.type.icon),
                      const SizedBox(width: 8),
                      Text(household.nameOf(event.by)),
                    ],
                  ),
                ),
              EventForm(
                key: ValueKey(id),
                type: event.type,
                initial: event,
                onSaved: () => context.pop(),
              ),
            ],
          ),
        ),
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        _ => Center(child: Text(l10n.eventNotFound)),
      },
    );
  }
}
