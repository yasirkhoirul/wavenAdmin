// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photographer_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PhotographerDetailNotifier)
const photographerDetailProvider = PhotographerDetailNotifierFamily._();

final class PhotographerDetailNotifierProvider
    extends
        $NotifierProvider<PhotographerDetailNotifier, PhotographerDetailState> {
  const PhotographerDetailNotifierProvider._({
    required PhotographerDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'photographerDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$photographerDetailNotifierHash();

  @override
  String toString() {
    return r'photographerDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PhotographerDetailNotifier create() => PhotographerDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotographerDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotographerDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PhotographerDetailNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$photographerDetailNotifierHash() =>
    r'7082f9b084c3662db790414efd62aba7fd3869c4';

final class PhotographerDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          PhotographerDetailNotifier,
          PhotographerDetailState,
          PhotographerDetailState,
          PhotographerDetailState,
          String
        > {
  const PhotographerDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'photographerDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PhotographerDetailNotifierProvider call(String photographerId) =>
      PhotographerDetailNotifierProvider._(
        argument: photographerId,
        from: this,
      );

  @override
  String toString() => r'photographerDetailProvider';
}

abstract class _$PhotographerDetailNotifier
    extends $Notifier<PhotographerDetailState> {
  late final _$args = ref.$arg as String;
  String get photographerId => _$args;

  PhotographerDetailState build(String photographerId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<PhotographerDetailState, PhotographerDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PhotographerDetailState, PhotographerDetailState>,
              PhotographerDetailState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
