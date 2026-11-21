import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../l10n/app_localizations.dart';
import '../../food/presentation/stock_labels.dart';
import '../application/reminder_settings_provider.dart';
import '../domain/reminder_settings.dart';

/// `/settings/reminders`: per-device reminder preferences.
class ReminderSettingsPage extends ConsumerWidget {
  const ReminderSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(reminderSettingsControllerProvider);
    final controller = ref.read(reminderSettingsControllerProvider.notifier);
    final time = TimeOfDay(hour: settings.hour, minute: settings.minute);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsReminders)),
      body: ListView(
        children: [
          SwitchListTile(
            key: const Key('foodRemindersEnabled'),
            secondary: const Icon(Icons.set_meal_outlined),
            title: Text(l10n.remindersFoodEnabled),
            value: settings.foodEnabled,
            onChanged: controller.setFoodEnabled,
          ),
          ListTile(
            enabled: settings.foodEnabled,
            title: Text(
              l10n.remindersThreshold(formatKg(settings.foodThresholdKg)),
            ),
            subtitle: Slider(
              key: const Key('foodThreshold'),
              min: ReminderSettings.minThresholdKg,
              max: ReminderSettings.maxThresholdKg,
              divisions:
                  ((ReminderSettings.maxThresholdKg -
                              ReminderSettings.minThresholdKg) *
                          2)
                      .round(),
              value: settings.foodThresholdKg,
              label: l10n.kgValue(formatKg(settings.foodThresholdKg)),
              onChanged: settings.foodEnabled
                  ? controller.setFoodThresholdKg
                  : null,
            ),
          ),
          SwitchListTile(
            key: const Key('weighRemindersEnabled'),
            secondary: const Icon(Icons.monitor_weight_outlined),
            title: Text(l10n.remindersWeighEnabled),
            subtitle: Text(l10n.remindersWeighInfo),
            value: settings.weighEnabled,
            onChanged: controller.setWeighEnabled,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: Text(l10n.remindersTime),
            trailing: Text(time.format(context)),
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: time,
              );
              if (picked != null) {
                controller.setTime(picked.hour, picked.minute);
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.remindersInfo,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
