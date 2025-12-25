// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UniversityDetailNotifier)
const universityDetailProvider = UniversityDetailNotifierFamily._();

final class UniversityDetailNotifierProvider
    extends $AsyncNotifierProvider<UniversityDetailNotifier, UniversityDetail> {
  const UniversityDetailNotifierProvider._({
    required UniversityDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'universityDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$universityDetailNotifierHash();

  @override
  String toString() {
    return r'universityDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UniversityDetailNotifier create() => UniversityDetailNotifier();

  @override
  bool operator ==(Object other) {
    return other is UniversityDetailNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$universityDetailNotifierHash() =>
    r'a20a43b4041229cf9daee5b83704cf73cfd1d8d1';

final class UniversityDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          UniversityDetailNotifier,
          AsyncValue<UniversityDetail>,
          UniversityDetail,
          FutureOr<UniversityDetail>,
          String
        > {
  const UniversityDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'universityDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UniversityDetailNotifierProvider call(String universityId) =>
      UniversityDetailNotifierProvider._(argument: universityId, from: this);

  @override
  String toString() => r'universityDetailProvider';
}

abstract class _$UniversityDetailNotifier
    extends $AsyncNotifier<UniversityDetail> {
  late final _$args = ref.$arg as String;
  String get universityId => _$args;

  FutureOr<UniversityDetail> build(String universityId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<UniversityDetail>, UniversityDetail>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UniversityDetail>, UniversityDetail>,
              AsyncValue<UniversityDetail>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
