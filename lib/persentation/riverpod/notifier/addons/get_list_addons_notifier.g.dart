// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_addons_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GetListAddonsNotifier)
const getListAddonsProvider = GetListAddonsNotifierFamily._();

final class GetListAddonsNotifierProvider
    extends $AsyncNotifierProvider<GetListAddonsNotifier, ListAddons> {
  const GetListAddonsNotifierProvider._({
    required GetListAddonsNotifierFamily super.from,
    required (int, int, {String? search}) super.argument,
  }) : super(
         retry: null,
         name: r'getListAddonsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getListAddonsNotifierHash();

  @override
  String toString() {
    return r'getListAddonsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  GetListAddonsNotifier create() => GetListAddonsNotifier();

  @override
  bool operator ==(Object other) {
    return other is GetListAddonsNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getListAddonsNotifierHash() =>
    r'019eb5a3b0a9f17557b7a4128a5fd28c372e61ee';

final class GetListAddonsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GetListAddonsNotifier,
          AsyncValue<ListAddons>,
          ListAddons,
          FutureOr<ListAddons>,
          (int, int, {String? search})
        > {
  const GetListAddonsNotifierFamily._()
    : super(
        retry: null,
        name: r'getListAddonsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetListAddonsNotifierProvider call(int page, int limit, {String? search}) =>
      GetListAddonsNotifierProvider._(
        argument: (page, limit, search: search),
        from: this,
      );

  @override
  String toString() => r'getListAddonsProvider';
}

abstract class _$GetListAddonsNotifier extends $AsyncNotifier<ListAddons> {
  late final _$args = ref.$arg as (int, int, {String? search});
  int get page => _$args.$1;
  int get limit => _$args.$2;
  String? get search => _$args.search;

  FutureOr<ListAddons> build(int page, int limit, {String? search});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args.$1, _$args.$2, search: _$args.search);
    final ref = this.ref as $Ref<AsyncValue<ListAddons>, ListAddons>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ListAddons>, ListAddons>,
              AsyncValue<ListAddons>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
