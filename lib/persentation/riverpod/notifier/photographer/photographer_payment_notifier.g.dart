// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photographer_payment_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PhotographerPaymentNotifier)
const photographerPaymentProvider = PhotographerPaymentNotifierFamily._();

final class PhotographerPaymentNotifierProvider
    extends
        $NotifierProvider<
          PhotographerPaymentNotifier,
          PhotographerPaymentState
        > {
  const PhotographerPaymentNotifierProvider._({
    required PhotographerPaymentNotifierFamily super.from,
    required (
      int,
      int, {
      String? search,
      DateTime? startTime,
      DateTime? endTime,
      SortPhotographerPayment? sortBy,
      Sort? sort,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'photographerPaymentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$photographerPaymentNotifierHash();

  @override
  String toString() {
    return r'photographerPaymentProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PhotographerPaymentNotifier create() => PhotographerPaymentNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotographerPaymentState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotographerPaymentState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PhotographerPaymentNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$photographerPaymentNotifierHash() =>
    r'd12ea61eaf3eeb05b95b130485d49c6e5347df53';

final class PhotographerPaymentNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          PhotographerPaymentNotifier,
          PhotographerPaymentState,
          PhotographerPaymentState,
          PhotographerPaymentState,
          (
            int,
            int, {
            String? search,
            DateTime? startTime,
            DateTime? endTime,
            SortPhotographerPayment? sortBy,
            Sort? sort,
          })
        > {
  const PhotographerPaymentNotifierFamily._()
    : super(
        retry: null,
        name: r'photographerPaymentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PhotographerPaymentNotifierProvider call(
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
    SortPhotographerPayment? sortBy,
    Sort? sort,
  }) => PhotographerPaymentNotifierProvider._(
    argument: (
      page,
      limit,
      search: search,
      startTime: startTime,
      endTime: endTime,
      sortBy: sortBy,
      sort: sort,
    ),
    from: this,
  );

  @override
  String toString() => r'photographerPaymentProvider';
}

abstract class _$PhotographerPaymentNotifier
    extends $Notifier<PhotographerPaymentState> {
  late final _$args =
      ref.$arg
          as (
            int,
            int, {
            String? search,
            DateTime? startTime,
            DateTime? endTime,
            SortPhotographerPayment? sortBy,
            Sort? sort,
          });
  int get page => _$args.$1;
  int get limit => _$args.$2;
  String? get search => _$args.search;
  DateTime? get startTime => _$args.startTime;
  DateTime? get endTime => _$args.endTime;
  SortPhotographerPayment? get sortBy => _$args.sortBy;
  Sort? get sort => _$args.sort;

  PhotographerPaymentState build(
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
    SortPhotographerPayment? sortBy,
    Sort? sort,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args.$1,
      _$args.$2,
      search: _$args.search,
      startTime: _$args.startTime,
      endTime: _$args.endTime,
      sortBy: _$args.sortBy,
      sort: _$args.sort,
    );
    final ref =
        this.ref as $Ref<PhotographerPaymentState, PhotographerPaymentState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PhotographerPaymentState, PhotographerPaymentState>,
              PhotographerPaymentState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
