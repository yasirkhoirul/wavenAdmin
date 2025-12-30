// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_fotografer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateFotograferNotifier)
const createFotograferProvider = CreateFotograferNotifierProvider._();

final class CreateFotograferNotifierProvider
    extends
        $NotifierProvider<CreateFotograferNotifier, PhotographerCreateState> {
  const CreateFotograferNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createFotograferProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createFotograferNotifierHash();

  @$internal
  @override
  CreateFotograferNotifier create() => CreateFotograferNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotographerCreateState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotographerCreateState>(value),
    );
  }
}

String _$createFotograferNotifierHash() =>
    r'f301800cc44d602d5863271fdcb10d19d9911a16';

abstract class _$CreateFotograferNotifier
    extends $Notifier<PhotographerCreateState> {
  PhotographerCreateState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<PhotographerCreateState, PhotographerCreateState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PhotographerCreateState, PhotographerCreateState>,
              PhotographerCreateState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
