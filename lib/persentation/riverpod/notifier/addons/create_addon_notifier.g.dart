// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_addon_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateAddonNotifier)
const createAddonProvider = CreateAddonNotifierProvider._();

final class CreateAddonNotifierProvider
    extends $NotifierProvider<CreateAddonNotifier, AsyncValue<String?>> {
  const CreateAddonNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createAddonProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createAddonNotifierHash();

  @$internal
  @override
  CreateAddonNotifier create() => CreateAddonNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<String?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<String?>>(value),
    );
  }
}

String _$createAddonNotifierHash() =>
    r'7ab1468eeb7c27a7d39380070148a3be84cb8a48';

abstract class _$CreateAddonNotifier extends $Notifier<AsyncValue<String?>> {
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
