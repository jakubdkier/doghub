import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_config.dart';

part 'app_config_provider.g.dart';

/// Overridden in `bootstrap()` with the flavor's [AppConfig].
@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) =>
    throw UnimplementedError('appConfigProvider must be overridden');
