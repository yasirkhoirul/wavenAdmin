// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_dropdown_addons_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GetDropdownAddonsNotifier)
const getDropdownAddonsProvider = GetDropdownAddonsNotifierProvider._();

final class GetDropdownAddonsNotifierProvider
    extends
        $AsyncNotifierProvider<
          GetDropdownAddonsNotifier,
          List<AddonDropdownItem>
        > {
  const GetDropdownAddonsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getDropdownAddonsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getDropdownAddonsNotifierHash();

  @$internal
  @override
  GetDropdownAddonsNotifier create() => GetDropdownAddonsNotifier();
}

String _$getDropdownAddonsNotifierHash() =>
    r'f9481c0f12f6519ff61e783574411b918be42c3e';

abstract class _$GetDropdownAddonsNotifier
    extends $AsyncNotifier<List<AddonDropdownItem>> {
  FutureOr<List<AddonDropdownItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<AddonDropdownItem>>,
              List<AddonDropdownItem>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AddonDropdownItem>>,
                List<AddonDropdownItem>
              >,
              AsyncValue<List<AddonDropdownItem>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
