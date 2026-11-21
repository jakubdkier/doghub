import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/widget_snapshot.dart';

part 'home_widget_service.g.dart';

/// Home screen widgets: push data, receive taps as app routes.
abstract interface class HomeWidgetService {
  Future<void> update(WidgetSnapshot snapshot);

  /// Route of the widget tap that cold-started the app, if any.
  Future<String?> launchRoute();

  /// Routes of widget taps while the app is running.
  Stream<String> get taps;
}

/// Overridden in bootstrap with [PluginHomeWidgetService] and in tests.
@Riverpod(keepAlive: true)
HomeWidgetService homeWidgetService(Ref ref) => NoopHomeWidgetService();

class NoopHomeWidgetService implements HomeWidgetService {
  @override
  Future<void> update(WidgetSnapshot snapshot) async {}
  @override
  Future<String?> launchRoute() async => null;
  @override
  Stream<String> get taps => const Stream.empty();
}

class PluginHomeWidgetService implements HomeWidgetService {
  /// Must match the receivers in AndroidManifest.xml.
  static const _providers = [
    'pl.jakubdkier.doghub.DogHubWidgetProvider',
    'pl.jakubdkier.doghub.DogHubSmallWidgetProvider',
  ];

  @override
  Future<void> update(WidgetSnapshot snapshot) async {
    try {
      for (final MapEntry(:key, :value) in snapshot.toWidgetData().entries) {
        await HomeWidget.saveWidgetData<String>(key, value);
      }
      for (final name in _providers) {
        await HomeWidget.updateWidget(qualifiedAndroidName: name);
      }
    } catch (e, st) {
      debugPrint('Home widget update failed: $e\n$st');
    }
  }

  @override
  Future<String?> launchRoute() async {
    try {
      return routeForWidgetUri(
        await HomeWidget.initiallyLaunchedFromHomeWidget(),
      );
    } catch (e) {
      debugPrint('Home widget launch check failed: $e');
      return null;
    }
  }

  @override
  Stream<String> get taps => HomeWidget.widgetClicked
      .map(routeForWidgetUri)
      .where((r) => r != null)
      .cast<String>();
}
