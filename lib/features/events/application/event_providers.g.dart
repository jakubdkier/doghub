// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eventRepository)
final eventRepositoryProvider = EventRepositoryProvider._();

final class EventRepositoryProvider
    extends
        $FunctionalProvider<EventRepository, EventRepository, EventRepository>
    with $Provider<EventRepository> {
  EventRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventRepositoryHash();

  @$internal
  @override
  $ProviderElement<EventRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventRepository create(Ref ref) {
    return eventRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventRepository>(value),
    );
  }
}

String _$eventRepositoryHash() => r'44626641f753d3773060a9aec303ac219dc7b4cd';

/// Non-deleted events of the current dog from the last [recentWindowDays]
/// days, newest first. Feeds the Today screen and quick-add defaults.

@ProviderFor(recentEvents)
final recentEventsProvider = RecentEventsProvider._();

/// Non-deleted events of the current dog from the last [recentWindowDays]
/// days, newest first. Feeds the Today screen and quick-add defaults.

final class RecentEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DogEvent>>,
          List<DogEvent>,
          Stream<List<DogEvent>>
        >
    with $FutureModifier<List<DogEvent>>, $StreamProvider<List<DogEvent>> {
  /// Non-deleted events of the current dog from the last [recentWindowDays]
  /// days, newest first. Feeds the Today screen and quick-add defaults.
  RecentEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentEventsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentEventsHash();

  @$internal
  @override
  $StreamProviderElement<List<DogEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<DogEvent>> create(Ref ref) {
    return recentEvents(ref);
  }
}

String _$recentEventsHash() => r'060e09fed4b4d27b8ff3cca0734970989038feba';

/// History filter and page size.

@ProviderFor(HistoryQuery)
final historyQueryProvider = HistoryQueryProvider._();

/// History filter and page size.
final class HistoryQueryProvider
    extends $NotifierProvider<HistoryQuery, EventQuery> {
  /// History filter and page size.
  HistoryQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyQueryHash();

  @$internal
  @override
  HistoryQuery create() => HistoryQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventQuery value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventQuery>(value),
    );
  }
}

String _$historyQueryHash() => r'45966972f94e9d07d419569e2b336619a0459f9b';

/// History filter and page size.

abstract class _$HistoryQuery extends $Notifier<EventQuery> {
  EventQuery build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<EventQuery, EventQuery>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EventQuery, EventQuery>,
              EventQuery,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(history)
final historyProvider = HistoryProvider._();

final class HistoryProvider
    extends
        $FunctionalProvider<AsyncValue<EventPage>, EventPage, Stream<EventPage>>
    with $FutureModifier<EventPage>, $StreamProvider<EventPage> {
  HistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyHash();

  @$internal
  @override
  $StreamProviderElement<EventPage> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<EventPage> create(Ref ref) {
    return history(ref);
  }
}

String _$historyHash() => r'412e6325153762b5c52d0e41798ea6f838f5178d';

@ProviderFor(event)
final eventProvider = EventFamily._();

final class EventProvider
    extends
        $FunctionalProvider<AsyncValue<DogEvent?>, DogEvent?, Stream<DogEvent?>>
    with $FutureModifier<DogEvent?>, $StreamProvider<DogEvent?> {
  EventProvider._({
    required EventFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventHash();

  @override
  String toString() {
    return r'eventProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<DogEvent?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DogEvent?> create(Ref ref) {
    final argument = this.argument as String;
    return event(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventHash() => r'00fe1695e4ae25d348bf0691db8a9e41dacf3eca';

final class EventFamily extends $Family
    with $FunctionalFamilyOverride<Stream<DogEvent?>, String> {
  EventFamily._()
    : super(
        retry: null,
        name: r'eventProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventProvider call(String id) => EventProvider._(argument: id, from: this);

  @override
  String toString() => r'eventProvider';
}

/// Writes for the current dog. All work offline.

@ProviderFor(EventController)
final eventControllerProvider = EventControllerProvider._();

/// Writes for the current dog. All work offline.
final class EventControllerProvider
    extends $NotifierProvider<EventController, void> {
  /// Writes for the current dog. All work offline.
  EventControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventControllerHash();

  @$internal
  @override
  EventController create() => EventController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$eventControllerHash() => r'217f4e6cf0d849f790c7a521713c11cea2c1b232';

/// Writes for the current dog. All work offline.

abstract class _$EventController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
