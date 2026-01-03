// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addon_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddonDetailNotifier)
const addonDetailProvider = AddonDetailNotifierFamily._();

final class AddonDetailNotifierProvider
    extends $AsyncNotifierProvider<AddonDetailNotifier, AddonDetail> {
  const AddonDetailNotifierProvider._({
    required AddonDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'addonDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$addonDetailNotifierHash();

  @override
  String toString() {
    return r'addonDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AddonDetailNotifier create() => AddonDetailNotifier();

  @override
  bool operator ==(Object other) {
    return other is AddonDetailNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$addonDetailNotifierHash() =>
    r'a759b7790011d0e2ac9a3e50ce33e05afee8a2bd';

final class AddonDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          AddonDetailNotifier,
          AsyncValue<AddonDetail>,
          AddonDetail,
          FutureOr<AddonDetail>,
          String
        > {
  const AddonDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'addonDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AddonDetailNotifierProvider call(String addonId) =>
      AddonDetailNotifierProvider._(argument: addonId, from: this);

  @override
  String toString() => r'addonDetailProvider';
}

abstract class _$AddonDetailNotifier extends $AsyncNotifier<AddonDetail> {
  late final _$args = ref.$arg as String;
  String get addonId => _$args;

  FutureOr<AddonDetail> build(String addonId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<AddonDetail>, AddonDetail>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AddonDetail>, AddonDetail>,
              AsyncValue<AddonDetail>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
