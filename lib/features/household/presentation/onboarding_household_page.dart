import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../l10n/app_localizations.dart';
import '../../auth/application/auth_providers.dart';
import '../application/household_providers.dart';
import '../domain/household_exceptions.dart';
import '../domain/invite.dart';
import 'join_failure_text.dart';

class OnboardingHouseholdPage extends ConsumerStatefulWidget {
  const OnboardingHouseholdPage({super.key});

  @override
  ConsumerState<OnboardingHouseholdPage> createState() =>
      _OnboardingHouseholdPageState();
}

class _OnboardingHouseholdPageState
    extends ConsumerState<OnboardingHouseholdPage> {
  final _name = TextEditingController();
  final _code = TextEditingController();
  bool _nameInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_nameInitialized) {
      _name.text = AppLocalizations.of(context).householdNameDefault;
      _nameInitialized = true;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _code.dispose();
    super.dispose();
  }

  void _create() {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    ref.read(householdControllerProvider.notifier).create(name);
  }

  void _join() =>
      ref.read(householdControllerProvider.notifier).join(_code.text);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    ref.listen(householdControllerProvider, (_, state) {
      if (state case AsyncError(:final error)) {
        final message = error is JoinHouseholdException
            ? l10n.joinFailure(error.reason)
            : l10n.genericError;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      }
    });
    final busy = ref.watch(householdControllerProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.onboardingHouseholdTitle),
        actions: [
          IconButton(
            tooltip: l10n.signOut,
            icon: const Icon(Icons.logout),
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(l10n.onboardingHouseholdIntro),
          const SizedBox(height: 24),
          Text(l10n.createHouseholdHeader, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            key: const Key('householdName'),
            controller: _name,
            maxLength: 50,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(labelText: l10n.householdNameLabel),
          ),
          FilledButton(
            onPressed: busy ? null : _create,
            child: Text(l10n.createHouseholdButton),
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),
          Text(l10n.joinHouseholdHeader, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            key: const Key('inviteCode'),
            controller: _code,
            textCapitalization: TextCapitalization.characters,
            autocorrect: false,
            enableSuggestions: false,
            maxLength: InviteCode.length,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
            ],
            decoration: InputDecoration(labelText: l10n.inviteCodeLabel),
            onSubmitted: (_) => busy ? null : _join(),
          ),
          OutlinedButton(
            onPressed: busy ? null : _join,
            child: busy
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.joinButton),
          ),
        ],
      ),
    );
  }
}
