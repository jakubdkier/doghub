import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock.g.dart';

/// Current time; overridden in tests.
@Riverpod(keepAlive: true)
DateTime Function() clock(Ref ref) => DateTime.now;
