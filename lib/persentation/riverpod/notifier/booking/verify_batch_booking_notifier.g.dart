// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_batch_booking_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VerifyBatchBookingNotifier)
const verifyBatchBookingProvider = VerifyBatchBookingNotifierProvider._();

final class VerifyBatchBookingNotifierProvider
    extends
        $AsyncNotifierProvider<
          VerifyBatchBookingNotifier,
          VerifyBatchBookingResponse?
        > {
  const VerifyBatchBookingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyBatchBookingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyBatchBookingNotifierHash();

  @$internal
  @override
  VerifyBatchBookingNotifier create() => VerifyBatchBookingNotifier();
}

String _$verifyBatchBookingNotifierHash() =>
    r'd770ff7de95a665608fc2e55f12b95f34aa158b8';

abstract class _$VerifyBatchBookingNotifier
    extends $AsyncNotifier<VerifyBatchBookingResponse?> {
  FutureOr<VerifyBatchBookingResponse?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<VerifyBatchBookingResponse?>,
              VerifyBatchBookingResponse?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<VerifyBatchBookingResponse?>,
                VerifyBatchBookingResponse?
              >,
              AsyncValue<VerifyBatchBookingResponse?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
