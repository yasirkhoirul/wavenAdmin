// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photographer_list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PhotographerList)
const photographerListProvider = PhotographerListProvider._();

final class PhotographerListProvider
    extends $NotifierProvider<PhotographerList, PhotographerPagedState> {
  const PhotographerListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photographerListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photographerListHash();

  @$internal
  @override
  PhotographerList create() => PhotographerList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotographerPagedState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotographerPagedState>(value),
    );
  }
}

String _$photographerListHash() => r'5d2e0dd7e5935e040a864776e64db3f6a75e2007';

abstract class _$PhotographerList extends $Notifier<PhotographerPagedState> {
  PhotographerPagedState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<PhotographerPagedState, PhotographerPagedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PhotographerPagedState, PhotographerPagedState>,
              PhotographerPagedState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
