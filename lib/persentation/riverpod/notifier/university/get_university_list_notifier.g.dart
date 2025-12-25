// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_university_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GetUniversityListNotifier)
const getUniversityListProvider = GetUniversityListNotifierFamily._();

final class GetUniversityListNotifierProvider
    extends
        $AsyncNotifierProvider<
          GetUniversityListNotifier,
          UniversitasListState
        > {
  const GetUniversityListNotifierProvider._({
    required GetUniversityListNotifierFamily super.from,
    required (int, int, {String? search, Sort? sort}) super.argument,
  }) : super(
         retry: null,
         name: r'getUniversityListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getUniversityListNotifierHash();

  @override
  String toString() {
    return r'getUniversityListProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  GetUniversityListNotifier create() => GetUniversityListNotifier();

  @override
  bool operator ==(Object other) {
    return other is GetUniversityListNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getUniversityListNotifierHash() =>
    r'85544bb5a9f3362abe722710f7ae0212e9217a04';

final class GetUniversityListNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GetUniversityListNotifier,
          AsyncValue<UniversitasListState>,
          UniversitasListState,
          FutureOr<UniversitasListState>,
          (int, int, {String? search, Sort? sort})
        > {
  const GetUniversityListNotifierFamily._()
    : super(
        retry: null,
        name: r'getUniversityListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetUniversityListNotifierProvider call(
    int page,
    int limit, {
    String? search,
    Sort? sort,
  }) => GetUniversityListNotifierProvider._(
    argument: (page, limit, search: search, sort: sort),
    from: this,
  );

  @override
  String toString() => r'getUniversityListProvider';
}

abstract class _$GetUniversityListNotifier
    extends $AsyncNotifier<UniversitasListState> {
  late final _$args = ref.$arg as (int, int, {String? search, Sort? sort});
  int get page => _$args.$1;
  int get limit => _$args.$2;
  String? get search => _$args.search;
  Sort? get sort => _$args.sort;

  FutureOr<UniversitasListState> build(
    int page,
    int limit, {
    String? search,
    Sort? sort,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args.$1,
      _$args.$2,
      search: _$args.search,
      sort: _$args.sort,
    );
    final ref =
        this.ref
            as $Ref<AsyncValue<UniversitasListState>, UniversitasListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<UniversitasListState>,
                UniversitasListState
              >,
              AsyncValue<UniversitasListState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
