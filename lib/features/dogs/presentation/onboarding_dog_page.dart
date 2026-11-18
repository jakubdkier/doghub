import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../l10n/app_localizations.dart';
import '../../weight/domain/weight_entry.dart';
import '../application/dog_providers.dart';

class OnboardingDogPage extends ConsumerStatefulWidget {
  const OnboardingDogPage({super.key});

  @override
  ConsumerState<OnboardingDogPage> createState() => _OnboardingDogPageState();
}

class _OnboardingDogPageState extends ConsumerState<OnboardingDogPage> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _breed = TextEditingController();
  final _weight = TextEditingController();
  DateTime? _birthDate;

  @override
  void dispose() {
    _name.dispose();
    _breed.dispose();
    _weight.dispose();
    super.dispose();
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(now.year - 1, now.month, now.day),
      firstDate: DateTime(now.year - 30),
      lastDate: now,
    );
    if (picked != null) setState(() => _birthDate = picked);
  }

  void _save() {
    if (!_form.currentState!.validate()) return;
    final breed = _breed.text.trim();
    ref
        .read(dogControllerProvider.notifier)
        .add(
          name: _name.text.trim(),
          breed: breed.isEmpty ? null : breed,
          birthDate: _birthDate,
          startWeightKg: _weight.text.trim().isEmpty
              ? null
              : parseWeightKg(_weight.text),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.onboardingDogTitle)),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              key: const Key('dogName'),
              controller: _name,
              maxLength: 50,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(labelText: l10n.dogNameLabel),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.fieldRequired : null,
            ),
            TextFormField(
              key: const Key('dogBreed'),
              controller: _breed,
              maxLength: 50,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: l10n.dogBreedLabel),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.cake_outlined),
              title: Text(l10n.dogBirthDateLabel),
              subtitle: _birthDate == null
                  ? null
                  : Text(DateFormat.yMMMMd().format(_birthDate!)),
              onTap: _pickBirthDate,
            ),
            TextFormField(
              key: const Key('dogWeight'),
              controller: _weight,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(labelText: l10n.dogWeightLabel),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                return parseWeightKg(v) == null ? l10n.dogWeightInvalid : null;
              },
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _save, child: Text(l10n.save)),
          ],
        ),
      ),
    );
  }
}
