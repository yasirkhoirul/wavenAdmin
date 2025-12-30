// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_package_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DeletePackageNotifier)
const deletePackageProvider = DeletePackageNotifierProvider._();

final class DeletePackageNotifierProvider
    extends $AsyncNotifierProvider<DeletePackageNotifier, String?> {
  const DeletePackageNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deletePackageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deletePackageNotifierHash();

  @$internal
  @override
  DeletePackageNotifier create() => DeletePackageNotifier();
}

String _$deletePackageNotifierHash() =>
    r'1339c5121053b248782162d20ac04d3e6d2176d1';

abstract class _$DeletePackageNotifier extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
