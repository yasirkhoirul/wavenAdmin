// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_package_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GetPackageListNotifier)
const getPackageListProvider = GetPackageListNotifierFamily._();

final class GetPackageListNotifierProvider
    extends $AsyncNotifierProvider<GetPackageListNotifier, PackageListState> {
  const GetPackageListNotifierProvider._({
    required GetPackageListNotifierFamily super.from,
    required (int, int, {String? search, Sort? sort, bool? status})
    super.argument,
  }) : super(
         retry: null,
         name: r'getPackageListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getPackageListNotifierHash();

  @override
  String toString() {
    return r'getPackageListProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  GetPackageListNotifier create() => GetPackageListNotifier();

  @override
  bool operator ==(Object other) {
    return other is GetPackageListNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getPackageListNotifierHash() =>
    r'bedcb44a8a550cb85e0134c7f5f2f731bbc33f36';

final class GetPackageListNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GetPackageListNotifier,
          AsyncValue<PackageListState>,
          PackageListState,
          FutureOr<PackageListState>,
          (int, int, {String? search, Sort? sort, bool? status})
        > {
  const GetPackageListNotifierFamily._()
    : super(
        retry: null,
        name: r'getPackageListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetPackageListNotifierProvider call(
    int page,
    int limit, {
    String? search,
    Sort? sort,
    bool? status,
  }) => GetPackageListNotifierProvider._(
    argument: (page, limit, search: search, sort: sort, status: status),
    from: this,
  );

  @override
  String toString() => r'getPackageListProvider';
}

abstract class _$GetPackageListNotifier
    extends $AsyncNotifier<PackageListState> {
  late final _$args =
      ref.$arg as (int, int, {String? search, Sort? sort, bool? status});
  int get page => _$args.$1;
  int get limit => _$args.$2;
  String? get search => _$args.search;
  Sort? get sort => _$args.sort;
  bool? get status => _$args.status;

  FutureOr<PackageListState> build(
    int page,
    int limit, {
    String? search,
    Sort? sort,
    bool? status,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args.$1,
      _$args.$2,
      search: _$args.search,
      sort: _$args.sort,
      status: _$args.status,
    );
    final ref =
        this.ref as $Ref<AsyncValue<PackageListState>, PackageListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PackageListState>, PackageListState>,
              AsyncValue<PackageListState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
