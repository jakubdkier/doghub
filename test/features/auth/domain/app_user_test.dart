import 'package:dog_app/features/auth/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppUser JSON round trip omits nulls', () {
    const user = AppUser(uid: 'u1', email: 'a@b.pl');
    final json = user.toJson();

    expect(json, {'uid': 'u1', 'email': 'a@b.pl'});
    expect(AppUser.fromJson(json), user);
  });
}
