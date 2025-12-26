// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_university_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateUniversityNotifier)
const createUniversityProvider = CreateUniversityNotifierFamily._();

final class CreateUniversityNotifierProvider
    extends $AsyncNotifierProvider<CreateUniversityNotifier, String> {
  const CreateUniversityNotifierProvider._({
    required CreateUniversityNotifierFamily super.from,
    required UniversityDetail super.argument,
  }) : super(
         retry: null,
         name: r'createUniversityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$createUniversityNotifierHash();

  @override
  String toString() {
    return r'createUniversityProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CreateUniversityNotifier create() => CreateUniversityNotifier();

  @override
  bool operator ==(Object other) {
    return other is CreateUniversityNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$createUniversityNotifierHash() =>
    r'4517746846e40802a42f26294ae91b7546f6d8dc';

final class CreateUniversityNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CreateUniversityNotifier,
          AsyncValue<String>,
          String,
          FutureOr<String>,
          UniversityDetail
        > {
  const CreateUniversityNotifierFamily._()
    : super(
        retry: null,
        name: r'createUniversityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CreateUniversityNotifierProvider call(UniversityDetail payload) =>
      CreateUniversityNotifierProvider._(argument: payload, from: this);

  @override
  String toString() => r'createUniversityProvider';
}

abstract class _$CreateUniversityNotifier extends $AsyncNotifier<String> {
  late final _$args = ref.$arg as UniversityDetail;
  UniversityDetail get payload => _$args;

  FutureOr<String> build(UniversityDetail payload);
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
