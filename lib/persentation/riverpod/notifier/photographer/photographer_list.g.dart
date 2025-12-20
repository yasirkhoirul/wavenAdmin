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

String _$photographerListHash() => r'293d996ec9ae750f07bbe4ef1a950df9531925fe';

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
