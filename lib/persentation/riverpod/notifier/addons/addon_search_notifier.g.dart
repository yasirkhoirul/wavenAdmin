// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addon_search_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddonSearch)
const addonSearchProvider = AddonSearchProvider._();

final class AddonSearchProvider extends $NotifierProvider<AddonSearch, String> {
  const AddonSearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addonSearchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addonSearchHash();

  @$internal
  @override
  AddonSearch create() => AddonSearch();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$addonSearchHash() => r'e8c951afc4b1f1c1596ebc40c8045f955b1526fe';

abstract class _$AddonSearch extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
