// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_package_detial_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GetPackageDetialNotifier)
const getPackageDetialProvider = GetPackageDetialNotifierFamily._();

final class GetPackageDetialNotifierProvider
    extends
        $AsyncNotifierProvider<
          GetPackageDetialNotifier,
          PackageDetailResponse
        > {
  const GetPackageDetialNotifierProvider._({
    required GetPackageDetialNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getPackageDetialProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getPackageDetialNotifierHash();

  @override
  String toString() {
    return r'getPackageDetialProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GetPackageDetialNotifier create() => GetPackageDetialNotifier();

  @override
  bool operator ==(Object other) {
    return other is GetPackageDetialNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getPackageDetialNotifierHash() =>
    r'55d616068f4ad5606956049e80e33c5e85be7579';

final class GetPackageDetialNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GetPackageDetialNotifier,
          AsyncValue<PackageDetailResponse>,
          PackageDetailResponse,
          FutureOr<PackageDetailResponse>,
          String
        > {
  const GetPackageDetialNotifierFamily._()
    : super(
        retry: null,
        name: r'getPackageDetialProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetPackageDetialNotifierProvider call(String idPackage) =>
      GetPackageDetialNotifierProvider._(argument: idPackage, from: this);

  @override
  String toString() => r'getPackageDetialProvider';
}

abstract class _$GetPackageDetialNotifier
    extends $AsyncNotifier<PackageDetailResponse> {
  late final _$args = ref.$arg as String;
  String get idPackage => _$args;

  FutureOr<PackageDetailResponse> build(String idPackage);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<PackageDetailResponse>, PackageDetailResponse>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PackageDetailResponse>,
                PackageDetailResponse
              >,
              AsyncValue<PackageDetailResponse>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
