// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_university_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DeleteUniversityNotifier)
const deleteUniversityProvider = DeleteUniversityNotifierFamily._();

final class DeleteUniversityNotifierProvider
    extends $AsyncNotifierProvider<DeleteUniversityNotifier, String> {
  const DeleteUniversityNotifierProvider._({
    required DeleteUniversityNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'deleteUniversityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$deleteUniversityNotifierHash();

  @override
  String toString() {
    return r'deleteUniversityProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DeleteUniversityNotifier create() => DeleteUniversityNotifier();

  @override
  bool operator ==(Object other) {
    return other is DeleteUniversityNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deleteUniversityNotifierHash() =>
    r'16fe883b579591e53239fbc67c06486aa9813574';

final class DeleteUniversityNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          DeleteUniversityNotifier,
          AsyncValue<String>,
          String,
          FutureOr<String>,
          String
        > {
  const DeleteUniversityNotifierFamily._()
    : super(
        retry: null,
        name: r'deleteUniversityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DeleteUniversityNotifierProvider call(String idUniv) =>
      DeleteUniversityNotifierProvider._(argument: idUniv, from: this);

  @override
  String toString() => r'deleteUniversityProvider';
}

abstract class _$DeleteUniversityNotifier extends $AsyncNotifier<String> {
  late final _$args = ref.$arg as String;
  String get idUniv => _$args;

  FutureOr<String> build(String idUniv);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
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
