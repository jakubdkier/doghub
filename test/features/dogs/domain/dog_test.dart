import 'package:dog_app/features/dogs/domain/dog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('byCreation sorts oldest first and pending (null) last', () {
    final dogs = [
      const Dog(id: 'p', name: 'Pending'),
      Dog(id: 'b', name: 'B', createdAt: DateTime(2025, 2)),
      Dog(id: 'a', name: 'A', createdAt: DateTime(2025, 1)),
    ]..sort(Dog.byCreation);
    expect(dogs.map((d) => d.id), ['a', 'b', 'p']);
  });
}
