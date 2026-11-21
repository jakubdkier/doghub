import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart' as tz;

part 'local_notifications.g.dart';

/// Device notifications. Payloads are app routes opened on tap.
abstract interface class LocalNotifications {
  /// Asks for the Android 13+ permission; true if granted.
  Future<bool> requestPermission();

  Future<void> cancelAll();

  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime at,
    required String route,
  });

  /// Route of the notification that cold-started the app, if any.
  Future<String?> launchRoute();

  /// Routes of notifications tapped while the app is running.
  Stream<String> get taps;
}

/// Overridden in bootstrap with [PluginLocalNotifications] and in tests.
@Riverpod(keepAlive: true)
LocalNotifications localNotifications(Ref ref) => NoopLocalNotifications();

class NoopLocalNotifications implements LocalNotifications {
  @override
  Future<bool> requestPermission() async => false;
  @override
  Future<void> cancelAll() async {}
  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime at,
    required String route,
  }) async {}
  @override
  Future<String?> launchRoute() async => null;
  @override
  Stream<String> get taps => const Stream.empty();
}

class PluginLocalNotifications implements LocalNotifications {
  PluginLocalNotifications._(this._plugin);

  static const _channel = AndroidNotificationDetails(
    'reminders',
    'Przypomnienia',
    channelDescription: 'Kończąca się karma i terminy zdrowotne',
    importance: Importance.high,
    priority: Priority.high,
  );

  final FlutterLocalNotificationsPlugin _plugin;
  final _taps = StreamController<String>.broadcast();

  /// Requires the timezone database and local location to be set.
  static Future<PluginLocalNotifications> init() async {
    final self = PluginLocalNotifications._(FlutterLocalNotificationsPlugin());
    await self._plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: (r) {
        final route = r.payload;
        if (route != null && route.isNotEmpty) self._taps.add(route);
      },
    );
    return self;
  }

  AndroidFlutterLocalNotificationsPlugin? get _android => _plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  @override
  Future<bool> requestPermission() async =>
      await _android?.requestNotificationsPermission() ?? false;

  @override
  Future<void> cancelAll() => _plugin.cancelAll();

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime at,
    required String route,
  }) async {
    try {
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: tz.TZDateTime.from(at, tz.local),
        notificationDetails: const NotificationDetails(android: _channel),
        // Inexact: no exact-alarm permission needed; may arrive a bit late.
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: route,
      );
    } catch (e, st) {
      debugPrint('Scheduling notification $id failed: $e\n$st');
    }
  }

  @override
  Future<String?> launchRoute() async {
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details == null || !details.didNotificationLaunchApp) return null;
    final route = details.notificationResponse?.payload;
    return (route == null || route.isEmpty) ? null : route;
  }

  @override
  Stream<String> get taps => _taps.stream;
}
