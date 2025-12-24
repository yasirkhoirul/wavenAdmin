// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_university_dropdown_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GetUniversityDropdownNotifier)
const getUniversityDropdownProvider = GetUniversityDropdownNotifierFamily._();

final class GetUniversityDropdownNotifierProvider
    extends
        $AsyncNotifierProvider<
          GetUniversityDropdownNotifier,
          UniversityDropdown
        > {
  const GetUniversityDropdownNotifierProvider._({
    required GetUniversityDropdownNotifierFamily super.from,
    required (int, int, {String? search}) super.argument,
  }) : super(
         retry: null,
         name: r'getUniversityDropdownProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getUniversityDropdownNotifierHash();

  @override
  String toString() {
    return r'getUniversityDropdownProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  GetUniversityDropdownNotifier create() => GetUniversityDropdownNotifier();

  @override
  bool operator ==(Object other) {
    return other is GetUniversityDropdownNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getUniversityDropdownNotifierHash() =>
    r'0f458e3fa658c54e5678b6a6051d5db08aa0f87e';

final class GetUniversityDropdownNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GetUniversityDropdownNotifier,
          AsyncValue<UniversityDropdown>,
          UniversityDropdown,
          FutureOr<UniversityDropdown>,
          (int, int, {String? search})
        > {
  const GetUniversityDropdownNotifierFamily._()
    : super(
        retry: null,
        name: r'getUniversityDropdownProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetUniversityDropdownNotifierProvider call(
    int page,
    int limit, {
    String? search,
  }) => GetUniversityDropdownNotifierProvider._(
    argument: (page, limit, search: search),
    from: this,
  );

  @override
  String toString() => r'getUniversityDropdownProvider';
}

abstract class _$GetUniversityDropdownNotifier
    extends $AsyncNotifier<UniversityDropdown> {
  late final _$args = ref.$arg as (int, int, {String? search});
  int get page => _$args.$1;
  int get limit => _$args.$2;
  String? get search => _$args.search;

  FutureOr<UniversityDropdown> build(int page, int limit, {String? search});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args.$1, _$args.$2, search: _$args.search);
    final ref =
        this.ref as $Ref<AsyncValue<UniversityDropdown>, UniversityDropdown>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UniversityDropdown>, UniversityDropdown>,
              AsyncValue<UniversityDropdown>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
