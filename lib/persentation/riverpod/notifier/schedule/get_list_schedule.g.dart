// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_schedule.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GetListSchedule)
const getListScheduleProvider = GetListScheduleFamily._();

final class GetListScheduleProvider
    extends $AsyncNotifierProvider<GetListSchedule, List<ScheduleEntity>> {
  const GetListScheduleProvider._({
    required GetListScheduleFamily super.from,
    required (int, int, VerificationStatus?) super.argument,
  }) : super(
         retry: null,
         name: r'getListScheduleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getListScheduleHash();

  @override
  String toString() {
    return r'getListScheduleProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  GetListSchedule create() => GetListSchedule();

  @override
  bool operator ==(Object other) {
    return other is GetListScheduleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getListScheduleHash() => r'1075f6ac09a30ed74b3cb3e81d2b9b7af8e05c38';

final class GetListScheduleFamily extends $Family
    with
        $ClassFamilyOverride<
          GetListSchedule,
          AsyncValue<List<ScheduleEntity>>,
          List<ScheduleEntity>,
          FutureOr<List<ScheduleEntity>>,
          (int, int, VerificationStatus?)
        > {
  const GetListScheduleFamily._()
    : super(
        retry: null,
        name: r'getListScheduleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetListScheduleProvider call(
    int month,
    int year,
    VerificationStatus? status,
  ) => GetListScheduleProvider._(argument: (month, year, status), from: this);

  @override
  String toString() => r'getListScheduleProvider';
}

abstract class _$GetListSchedule extends $AsyncNotifier<List<ScheduleEntity>> {
  late final _$args = ref.$arg as (int, int, VerificationStatus?);
  int get month => _$args.$1;
  int get year => _$args.$2;
  VerificationStatus? get status => _$args.$3;

  FutureOr<List<ScheduleEntity>> build(
    int month,
    int year,
    VerificationStatus? status,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args.$1, _$args.$2, _$args.$3);
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ScheduleEntity>>, List<ScheduleEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ScheduleEntity>>,
                List<ScheduleEntity>
              >,
              AsyncValue<List<ScheduleEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
