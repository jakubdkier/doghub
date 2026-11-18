import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hidden_events.g.dart';

/// Ids swiped away in this session. Hides them at once, before the
/// Firestore snapshot reflects the soft delete (Dismissible requires it).
@Riverpod(keepAlive: true)
class HiddenEvents extends _$HiddenEvents {
  @override
  Set<String> build() => const {};

  void hide(String id) => state = {...state, id};

  void show(String id) => state = {...state}..remove(id);
}
