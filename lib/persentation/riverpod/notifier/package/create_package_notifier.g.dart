// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_package_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreatePackageNotifier)
const createPackageProvider = CreatePackageNotifierProvider._();

final class CreatePackageNotifierProvider
    extends $AsyncNotifierProvider<CreatePackageNotifier, String?> {
  const CreatePackageNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createPackageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createPackageNotifierHash();

  @$internal
  @override
  CreatePackageNotifier create() => CreatePackageNotifier();
}

String _$createPackageNotifierHash() =>
    r'9a0aeda32f26415114726fab394c624ff130bd6d';

abstract class _$CreatePackageNotifier extends $AsyncNotifier<String?> {
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
