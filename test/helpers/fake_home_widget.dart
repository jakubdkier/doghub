import 'dart:async';

import 'package:dog_app/features/home_widget/data/home_widget_service.dart';
import 'package:dog_app/features/home_widget/domain/widget_snapshot.dart';

class FakeHomeWidgetService implements HomeWidgetService {
  final updates = <WidgetSnapshot>[];
  final _taps = StreamController<String>.broadcast();
  String? launch;

  WidgetSnapshot? get last => updates.isEmpty ? null : updates.last;

  void tap(String route) => _taps.add(route);

  @override
  Future<void> update(WidgetSnapshot snapshot) async => updates.add(snapshot);

  @override
  Future<String?> launchRoute() async => launch;

  @override
  Stream<String> get taps => _taps.stream;
}
