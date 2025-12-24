// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_package_dropdown_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GetPackageDropdownNotifier)
const getPackageDropdownProvider = GetPackageDropdownNotifierFamily._();

final class GetPackageDropdownNotifierProvider
    extends
        $AsyncNotifierProvider<GetPackageDropdownNotifier, PackageDropdown> {
  const GetPackageDropdownNotifierProvider._({
    required GetPackageDropdownNotifierFamily super.from,
    required (int, int, {String? search}) super.argument,
  }) : super(
         retry: null,
         name: r'getPackageDropdownProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getPackageDropdownNotifierHash();

  @override
  String toString() {
    return r'getPackageDropdownProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  GetPackageDropdownNotifier create() => GetPackageDropdownNotifier();

  @override
  bool operator ==(Object other) {
    return other is GetPackageDropdownNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getPackageDropdownNotifierHash() =>
    r'60dc5a69d717fbf021f3a82c43ae2921c9313d47';

final class GetPackageDropdownNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GetPackageDropdownNotifier,
          AsyncValue<PackageDropdown>,
          PackageDropdown,
          FutureOr<PackageDropdown>,
          (int, int, {String? search})
        > {
  const GetPackageDropdownNotifierFamily._()
    : super(
        retry: null,
        name: r'getPackageDropdownProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetPackageDropdownNotifierProvider call(
    int page,
    int limit, {
    String? search,
  }) => GetPackageDropdownNotifierProvider._(
    argument: (page, limit, search: search),
    from: this,
  );

  @override
  String toString() => r'getPackageDropdownProvider';
}

abstract class _$GetPackageDropdownNotifier
    extends $AsyncNotifier<PackageDropdown> {
  late final _$args = ref.$arg as (int, int, {String? search});
  int get page => _$args.$1;
  int get limit => _$args.$2;
  String? get search => _$args.search;

  FutureOr<PackageDropdown> build(int page, int limit, {String? search});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args.$1, _$args.$2, search: _$args.search);
    final ref = this.ref as $Ref<AsyncValue<PackageDropdown>, PackageDropdown>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PackageDropdown>, PackageDropdown>,
              AsyncValue<PackageDropdown>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
