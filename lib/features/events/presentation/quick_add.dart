import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/dog_event.dart';
import 'event_form.dart';
import 'event_labels.dart';

/// Quick-add bottom sheet used inside the app.
Future<void> showQuickAddSheet(BuildContext context, EventType type) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SheetTitle(type: type),
              const SizedBox(height: 16),
              EventForm(
                type: type,
                onSaved: () => Navigator.of(sheetContext).pop(),
              ),
            ],
          ),
        ),
      ),
    );

class _SheetTitle extends StatelessWidget {
  const _SheetTitle({required this.type});

  final EventType type;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(type.icon),
      const SizedBox(width: 12),
      Text(
        type.label(AppLocalizations.of(context)),
        style: Theme.of(context).textTheme.titleLarge,
      ),
    ],
  );
}

/// `/quick-add?type=…` deep link (home widget, notifications).
class QuickAddPage extends StatelessWidget {
  const QuickAddPage({super.key, required this.type});

  /// Unknown or missing types fall back to a note.
  static EventType parseType(String? raw) =>
      EventType.values.asNameMap()[raw] ?? EventType.note;

  final EventType type;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: _SheetTitle(type: type)),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: EventForm(
        type: type,
        onSaved: () =>
            context.canPop() ? context.pop() : context.go(Routes.today),
      ),
    ),
  );
}
