// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'porto_mutation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PortoMutation)
const portoMutationProvider = PortoMutationFamily._();

final class PortoMutationProvider
    extends $AsyncNotifierProvider<PortoMutation, PortoList> {
  const PortoMutationProvider._({
    required PortoMutationFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'portoMutationProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$portoMutationHash();

  @override
  String toString() {
    return r'portoMutationProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PortoMutation create() => PortoMutation();

  @override
  bool operator ==(Object other) {
    return other is PortoMutationProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$portoMutationHash() => r'1ea863e4c563f724e8926f43a72b14ce6c1fb21b';

final class PortoMutationFamily extends $Family
    with
        $ClassFamilyOverride<
          PortoMutation,
          AsyncValue<PortoList>,
          PortoList,
          FutureOr<PortoList>,
          String
        > {
  const PortoMutationFamily._()
    : super(
        retry: null,
        name: r'portoMutationProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PortoMutationProvider call(String packageId) =>
      PortoMutationProvider._(argument: packageId, from: this);

  @override
  String toString() => r'portoMutationProvider';
}

abstract class _$PortoMutation extends $AsyncNotifier<PortoList> {
  late final _$args = ref.$arg as String;
  String get packageId => _$args;

  FutureOr<PortoList> build(String packageId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<PortoList>, PortoList>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PortoList>, PortoList>,
              AsyncValue<PortoList>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
