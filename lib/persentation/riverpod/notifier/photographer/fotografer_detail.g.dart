// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fotografer_detail.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FotograferDetail)
const fotograferDetailProvider = FotograferDetailFamily._();

final class FotograferDetailProvider
    extends $AsyncNotifierProvider<FotograferDetail, DetailFotografer> {
  const FotograferDetailProvider._({
    required FotograferDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'fotograferDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fotograferDetailHash();

  @override
  String toString() {
    return r'fotograferDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FotograferDetail create() => FotograferDetail();

  @override
  bool operator ==(Object other) {
    return other is FotograferDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fotograferDetailHash() => r'460802ae038097697efc6b985a0f784639091d67';

final class FotograferDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          FotograferDetail,
          AsyncValue<DetailFotografer>,
          DetailFotografer,
          FutureOr<DetailFotografer>,
          String
        > {
  const FotograferDetailFamily._()
    : super(
        retry: null,
        name: r'fotograferDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FotograferDetailProvider call(String idFotografer) =>
      FotograferDetailProvider._(argument: idFotografer, from: this);

  @override
  String toString() => r'fotograferDetailProvider';
}

abstract class _$FotograferDetail extends $AsyncNotifier<DetailFotografer> {
  late final _$args = ref.$arg as String;
  String get idFotografer => _$args;

  FutureOr<DetailFotografer> build(String idFotografer);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<DetailFotografer>, DetailFotografer>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DetailFotografer>, DetailFotografer>,
              AsyncValue<DetailFotografer>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
