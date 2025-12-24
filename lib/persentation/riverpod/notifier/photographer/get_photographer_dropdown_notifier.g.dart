// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_photographer_dropdown_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GetPhotographerDropdownNotifier)
const getPhotographerDropdownProvider =
    GetPhotographerDropdownNotifierFamily._();

final class GetPhotographerDropdownNotifierProvider
    extends
        $AsyncNotifierProvider<
          GetPhotographerDropdownNotifier,
          PhotographerDropdown
        > {
  const GetPhotographerDropdownNotifierProvider._({
    required GetPhotographerDropdownNotifierFamily super.from,
    required (int, int, {String? search}) super.argument,
  }) : super(
         retry: null,
         name: r'getPhotographerDropdownProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getPhotographerDropdownNotifierHash();

  @override
  String toString() {
    return r'getPhotographerDropdownProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  GetPhotographerDropdownNotifier create() => GetPhotographerDropdownNotifier();

  @override
  bool operator ==(Object other) {
    return other is GetPhotographerDropdownNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getPhotographerDropdownNotifierHash() =>
    r'003c9efd1ea24d5d7790f3ac7703be48d9932a1c';

final class GetPhotographerDropdownNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GetPhotographerDropdownNotifier,
          AsyncValue<PhotographerDropdown>,
          PhotographerDropdown,
          FutureOr<PhotographerDropdown>,
          (int, int, {String? search})
        > {
  const GetPhotographerDropdownNotifierFamily._()
    : super(
        retry: null,
        name: r'getPhotographerDropdownProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetPhotographerDropdownNotifierProvider call(
    int page,
    int limit, {
    String? search,
  }) => GetPhotographerDropdownNotifierProvider._(
    argument: (page, limit, search: search),
    from: this,
  );

  @override
  String toString() => r'getPhotographerDropdownProvider';
}

abstract class _$GetPhotographerDropdownNotifier
    extends $AsyncNotifier<PhotographerDropdown> {
  late final _$args = ref.$arg as (int, int, {String? search});
  int get page => _$args.$1;
  int get limit => _$args.$2;
  String? get search => _$args.search;

  FutureOr<PhotographerDropdown> build(int page, int limit, {String? search});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args.$1, _$args.$2, search: _$args.search);
    final ref =
        this.ref
            as $Ref<AsyncValue<PhotographerDropdown>, PhotographerDropdown>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PhotographerDropdown>,
                PhotographerDropdown
              >,
              AsyncValue<PhotographerDropdown>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
