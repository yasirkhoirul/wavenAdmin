// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photographer_booking_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PhotographerBookingNotifier)
const photographerBookingProvider = PhotographerBookingNotifierFamily._();

final class PhotographerBookingNotifierProvider
    extends
        $NotifierProvider<
          PhotographerBookingNotifier,
          PhotographerBookingState
        > {
  const PhotographerBookingNotifierProvider._({
    required PhotographerBookingNotifierFamily super.from,
    required (
      String,
      int,
      int, {
      String? search,
      DateTime? startTime,
      DateTime? endTime,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'photographerBookingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$photographerBookingNotifierHash();

  @override
  String toString() {
    return r'photographerBookingProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PhotographerBookingNotifier create() => PhotographerBookingNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotographerBookingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotographerBookingState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PhotographerBookingNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$photographerBookingNotifierHash() =>
    r'7b0a50e44a58453f5fbb3889c25ab0120706e5a9';

final class PhotographerBookingNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          PhotographerBookingNotifier,
          PhotographerBookingState,
          PhotographerBookingState,
          PhotographerBookingState,
          (
            String,
            int,
            int, {
            String? search,
            DateTime? startTime,
            DateTime? endTime,
          })
        > {
  const PhotographerBookingNotifierFamily._()
    : super(
        retry: null,
        name: r'photographerBookingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PhotographerBookingNotifierProvider call(
    String photographerId,
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
  }) => PhotographerBookingNotifierProvider._(
    argument: (
      photographerId,
      page,
      limit,
      search: search,
      startTime: startTime,
      endTime: endTime,
    ),
    from: this,
  );

  @override
  String toString() => r'photographerBookingProvider';
}

abstract class _$PhotographerBookingNotifier
    extends $Notifier<PhotographerBookingState> {
  late final _$args =
      ref.$arg
          as (
            String,
            int,
            int, {
            String? search,
            DateTime? startTime,
            DateTime? endTime,
          });
  String get photographerId => _$args.$1;
  int get page => _$args.$2;
  int get limit => _$args.$3;
  String? get search => _$args.search;
  DateTime? get startTime => _$args.startTime;
  DateTime? get endTime => _$args.endTime;

  PhotographerBookingState build(
    String photographerId,
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args.$1,
      _$args.$2,
      _$args.$3,
      search: _$args.search,
      startTime: _$args.startTime,
      endTime: _$args.endTime,
    );
    final ref =
        this.ref as $Ref<PhotographerBookingState, PhotographerBookingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PhotographerBookingState, PhotographerBookingState>,
              PhotographerBookingState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
