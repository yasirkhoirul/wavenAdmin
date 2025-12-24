// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_booking_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DetailBookingNotifier)
const detailBookingProvider = DetailBookingNotifierFamily._();

final class DetailBookingNotifierProvider
    extends $AsyncNotifierProvider<DetailBookingNotifier, DetailBooking> {
  const DetailBookingNotifierProvider._({
    required DetailBookingNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'detailBookingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$detailBookingNotifierHash();

  @override
  String toString() {
    return r'detailBookingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DetailBookingNotifier create() => DetailBookingNotifier();

  @override
  bool operator ==(Object other) {
    return other is DetailBookingNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$detailBookingNotifierHash() =>
    r'cd66ee65c2f4bcb5aa8adb984081375ec065ecab';

final class DetailBookingNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          DetailBookingNotifier,
          AsyncValue<DetailBooking>,
          DetailBooking,
          FutureOr<DetailBooking>,
          String
        > {
  const DetailBookingNotifierFamily._()
    : super(
        retry: null,
        name: r'detailBookingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DetailBookingNotifierProvider call(String idDetail) =>
      DetailBookingNotifierProvider._(argument: idDetail, from: this);

  @override
  String toString() => r'detailBookingProvider';
}

abstract class _$DetailBookingNotifier extends $AsyncNotifier<DetailBooking> {
  late final _$args = ref.$arg as String;
  String get idDetail => _$args;

  FutureOr<DetailBooking> build(String idDetail);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<DetailBooking>, DetailBooking>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DetailBooking>, DetailBooking>,
              AsyncValue<DetailBooking>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
