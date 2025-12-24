// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_booking_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VerifyBookingNotifier)
const verifyBookingProvider = VerifyBookingNotifierProvider._();

final class VerifyBookingNotifierProvider
    extends $AsyncNotifierProvider<VerifyBookingNotifier, String> {
  const VerifyBookingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyBookingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyBookingNotifierHash();

  @$internal
  @override
  VerifyBookingNotifier create() => VerifyBookingNotifier();
}

String _$verifyBookingNotifierHash() =>
    r'34029a30361eb991c86fd8caf9dd38db7228e82b';

abstract class _$VerifyBookingNotifier extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>, String>,
              AsyncValue<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
