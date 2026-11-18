import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../l10n/app_localizations.dart';
import '../application/household_providers.dart';
import '../domain/household_exceptions.dart';
import '../domain/invite.dart';

class HouseholdSettingsPage extends ConsumerWidget {
  const HouseholdSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final household = ref.watch(currentHouseholdProvider).value;
    final me = ref.watch(currentUserProvider)?.uid;

    ref.listen(householdControllerProvider, (_, state) {
      if (state case AsyncError(:final error)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                error is InviteOfflineException
                    ? l10n.inviteErrorOffline
                    : l10n.genericError,
              ),
            ),
          );
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(household?.name ?? l10n.settingsHousehold)),
      body: household == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _SectionHeader(l10n.householdMembers),
                for (final uid in household.members)
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: Text(
                      uid == me
                          ? l10n.memberYou(household.nameOf(uid))
                          : household.nameOf(uid),
                    ),
                  ),
                const Divider(),
                _SectionHeader(l10n.inviteHeader),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    l10n.inviteDescription,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 12),
                const _InviteSection(),
              ],
            ),
    );
  }
}

class _InviteSection extends ConsumerWidget {
  const _InviteSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final invite = ref.watch(activeInviteProvider).value;
    final busy = ref.watch(householdControllerProvider).isLoading;
    final controller = ref.read(householdControllerProvider.notifier);
    final valid = invite != null && invite.isValidAt(DateTime.now());

    if (!valid) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FilledButton.icon(
          onPressed: busy ? null : controller.createInvite,
          icon: busy
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.person_add_alt),
          label: Text(l10n.inviteGenerate),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SelectableText(
            _spaced(invite.code),
            key: const Key('inviteCodeValue'),
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall?.copyWith(
              fontFeatures: const [FontFeature.tabularFigures()],
              letterSpacing: 4,
            ),
          ),
          Text(
            l10n.inviteValidUntil(
              DateFormat.MMMd().add_Hm().format(invite.expiresAt),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children: [
              FilledButton.tonalIcon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: invite.code));
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(l10n.inviteCopied)));
                },
                icon: const Icon(Icons.copy),
                label: Text(l10n.inviteCopy),
              ),
              TextButton(
                onPressed: controller.revokeInvite,
                child: Text(l10n.inviteRevoke),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _spaced(String code) => code.length == InviteCode.length
      ? '${code.substring(0, 3)} ${code.substring(3)}'
      : code;
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    child: Text(
      text,
      style: Theme.of(context).textTheme.titleSmall
          ?.copyWith(color: Theme.of(context).colorScheme.primary),
    ),
  );
}
