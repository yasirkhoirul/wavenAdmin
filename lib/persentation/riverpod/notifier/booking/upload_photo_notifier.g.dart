// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_photo_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UploadPhotoResultNotifier)
const uploadPhotoResultProvider = UploadPhotoResultNotifierProvider._();

final class UploadPhotoResultNotifierProvider
    extends $AsyncNotifierProvider<UploadPhotoResultNotifier, String> {
  const UploadPhotoResultNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadPhotoResultProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadPhotoResultNotifierHash();

  @$internal
  @override
  UploadPhotoResultNotifier create() => UploadPhotoResultNotifier();
}

String _$uploadPhotoResultNotifierHash() =>
    r'bf3d44bf3c04b9632834b30694a7e8198a49bc87';

abstract class _$UploadPhotoResultNotifier extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>, String>,
              AsyncValue<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(UploadEditedPhotoNotifier)
const uploadEditedPhotoProvider = UploadEditedPhotoNotifierProvider._();

final class UploadEditedPhotoNotifierProvider
    extends $AsyncNotifierProvider<UploadEditedPhotoNotifier, String> {
  const UploadEditedPhotoNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadEditedPhotoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadEditedPhotoNotifierHash();

  @$internal
  @override
  UploadEditedPhotoNotifier create() => UploadEditedPhotoNotifier();
}

String _$uploadEditedPhotoNotifierHash() =>
    r'168f603148459fba33e04f8eac8ddcc73e9f66e7';

abstract class _$UploadEditedPhotoNotifier extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>, String>,
              AsyncValue<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
