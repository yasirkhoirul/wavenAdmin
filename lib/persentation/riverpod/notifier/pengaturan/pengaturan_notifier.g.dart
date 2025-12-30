// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pengaturan_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PengaturanNotifier)
const pengaturanProvider = PengaturanNotifierProvider._();

final class PengaturanNotifierProvider
    extends $AsyncNotifierProvider<PengaturanNotifier, PengaturanState> {
  const PengaturanNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pengaturanProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pengaturanNotifierHash();

  @$internal
  @override
  PengaturanNotifier create() => PengaturanNotifier();
}

String _$pengaturanNotifierHash() =>
    r'fdc3e91ff4e666c4ce75b92cf21da26910cfcf3b';

abstract class _$PengaturanNotifier extends $AsyncNotifier<PengaturanState> {
  FutureOr<PengaturanState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<PengaturanState>, PengaturanState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PengaturanState>, PengaturanState>,
              AsyncValue<PengaturanState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
