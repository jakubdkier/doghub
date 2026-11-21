import 'dart:async';

import 'package:dog_app/core/notifications/local_notifications.dart';

typedef ScheduledNotification = ({
  int id,
  String title,
  String body,
  DateTime at,
  String route,
});

class FakeLocalNotifications implements LocalNotifications {
  final scheduled = <ScheduledNotification>[];
  final _taps = StreamController<String>.broadcast();
  int permissionRequests = 0;
  String? launch;

  void tap(String route) => _taps.add(route);

  @override
  Future<bool> requestPermission() async {
    permissionRequests++;
    return true;
  }

  @override
  Future<void> cancelAll() async => scheduled.clear();

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime at,
    required String route,
  }) async =>
      scheduled.add((id: id, title: title, body: body, at: at, route: route));

  @override
  Future<String?> launchRoute() async => launch;

  @override
  Stream<String> get taps => _taps.stream;
}
