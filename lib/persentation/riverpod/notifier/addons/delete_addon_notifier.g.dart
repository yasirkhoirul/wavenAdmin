// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_addon_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DeleteAddonNotifier)
const deleteAddonProvider = DeleteAddonNotifierProvider._();

final class DeleteAddonNotifierProvider
    extends $NotifierProvider<DeleteAddonNotifier, AsyncValue<String?>> {
  const DeleteAddonNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteAddonProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteAddonNotifierHash();

  @$internal
  @override
  DeleteAddonNotifier create() => DeleteAddonNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<String?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<String?>>(value),
    );
  }
}

String _$deleteAddonNotifierHash() =>
    r'b7351d14c718b27839610e3fecdf5cfcc2b9659a';

abstract class _$DeleteAddonNotifier extends $Notifier<AsyncValue<String?>> {
  AsyncValue<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String?>, AsyncValue<String?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, AsyncValue<String?>>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
