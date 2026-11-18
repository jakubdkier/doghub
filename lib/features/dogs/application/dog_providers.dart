import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ProviderListenableSelect;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/firebase/firebase_providers.dart';
import '../../household/application/household_providers.dart';
import '../data/dog_repository.dart';
import '../domain/dog.dart';

part 'dog_providers.g.dart';

@Riverpod(keepAlive: true)
DogRepository dogRepository(Ref ref) =>
    DogRepository(ref.watch(firestoreProvider));

@Riverpod(keepAlive: true)
Stream<List<Dog>> dogs(Ref ref) {
  final householdId = ref.watch(
    currentHouseholdProvider.select((h) => h.value?.id),
  );
  if (householdId == null) return Stream.value(const []);
  return ref.watch(dogRepositoryProvider).watchAll(householdId);
}

/// Dog shown in the app. The dog switcher (stage 3) will make this selectable.
@Riverpod(keepAlive: true)
Dog? currentDog(Ref ref) {
  final dogs = ref.watch(dogsProvider).value;
  return (dogs == null || dogs.isEmpty) ? null : dogs.first;
}

@riverpod
class DogController extends _$DogController {
  @override
  FutureOr<void> build() {}

  void add({
    required String name,
    String? breed,
    DateTime? birthDate,
    double? startWeightKg,
  }) {
    final user = ref.read(currentUserProvider);
    final household = ref.read(currentHouseholdProvider).value;
    if (user == null || household == null) {
      throw StateError('No user or household');
    }
    ref
        .read(dogRepositoryProvider)
        .add(
          householdId: household.id,
          uid: user.uid,
          name: name,
          breed: breed,
          birthDate: birthDate,
          startWeightKg: startWeightKg,
        );
  }
}
