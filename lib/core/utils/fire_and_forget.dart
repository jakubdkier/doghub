import 'dart:async';

import 'package:flutter/foundation.dart';

/// Firestore writes resolve only after the server acknowledges them, which
/// never happens offline. The local cache updates immediately, so UI code
/// doesn't wait; failures (e.g. rules) are logged.
void fireAndForget(Future<void> write, String what) {
  unawaited(
    write.catchError((Object e, StackTrace st) {
      debugPrint('Firestore write failed ($what): $e\n$st');
    }),
  );
}
