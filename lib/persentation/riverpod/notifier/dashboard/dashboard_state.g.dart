// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getDashboardState)
const getDashboardStateProvider = GetDashboardStateProvider._();

final class GetDashboardStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<DashboardEntity>,
          DashboardEntity,
          FutureOr<DashboardEntity>
        >
    with $FutureModifier<DashboardEntity>, $FutureProvider<DashboardEntity> {
  const GetDashboardStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getDashboardStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getDashboardStateHash();

  @$internal
  @override
  $FutureProviderElement<DashboardEntity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DashboardEntity> create(Ref ref) {
    return getDashboardState(ref);
  }
}

String _$getDashboardStateHash() => r'76796043672f0124c4dadbdc1b0685a00f365a6b';
