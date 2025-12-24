// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_booking_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateBookingNotifier)
const updateBookingProvider = UpdateBookingNotifierProvider._();

final class UpdateBookingNotifierProvider
    extends $AsyncNotifierProvider<UpdateBookingNotifier, String> {
  const UpdateBookingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateBookingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateBookingNotifierHash();

  @$internal
  @override
  UpdateBookingNotifier create() => UpdateBookingNotifier();
}

String _$updateBookingNotifierHash() =>
    r'ac23a87d7572d6206f4312690e64391073e49395';

abstract class _$UpdateBookingNotifier extends $AsyncNotifier<String> {
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
