import 'package:dog_app/features/auth/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppUser JSON round trip omits nulls', () {
    const user = AppUser(uid: 'u1', email: 'a@b.pl');
    final json = user.toJson();

    expect(json, {'uid': 'u1', 'email': 'a@b.pl'});
    expect(AppUser.fromJson(json), user);
  });

  group('preferredName', () {
    test('uses the first name', () {
      expect(
        const AppUser(uid: 'u', displayName: 'Jakub Kier').preferredName,
        'Jakub',
      );
    });

    test('falls back to e-mail local part, then to Ja', () {
      expect(const AppUser(uid: 'u', email: 'kuba@x.pl').preferredName, 'kuba');
      expect(const AppUser(uid: 'u', displayName: '  ').preferredName, 'Ja');
    });
  });
}
