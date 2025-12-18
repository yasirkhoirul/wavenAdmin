// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminDetail)
const adminDetailProvider = AdminDetailFamily._();

final class AdminDetailProvider
    extends $AsyncNotifierProvider<AdminDetail, DetailAdmin> {
  const AdminDetailProvider._({
    required AdminDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'adminDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminDetailHash();

  @override
  String toString() {
    return r'adminDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AdminDetail create() => AdminDetail();

  @override
  bool operator ==(Object other) {
    return other is AdminDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminDetailHash() => r'abb14e9001d3858f588ba63fdb872cc2488e0cba';

final class AdminDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          AdminDetail,
          AsyncValue<DetailAdmin>,
          DetailAdmin,
          FutureOr<DetailAdmin>,
          String
        > {
  const AdminDetailFamily._()
    : super(
        retry: null,
        name: r'adminDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminDetailProvider call(String adminId) =>
      AdminDetailProvider._(argument: adminId, from: this);

  @override
  String toString() => r'adminDetailProvider';
}

abstract class _$AdminDetail extends $AsyncNotifier<DetailAdmin> {
  late final _$args = ref.$arg as String;
  String get adminId => _$args;

  FutureOr<DetailAdmin> build(String adminId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<DetailAdmin>, DetailAdmin>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DetailAdmin>, DetailAdmin>,
              AsyncValue<DetailAdmin>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
