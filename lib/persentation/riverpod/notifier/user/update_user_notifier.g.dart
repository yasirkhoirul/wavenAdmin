// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateUserNotifier)
const updateUserProvider = UpdateUserNotifierProvider._();

final class UpdateUserNotifierProvider
    extends $AsyncNotifierProvider<UpdateUserNotifier, String?> {
  const UpdateUserNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateUserNotifierHash();

  @$internal
  @override
  UpdateUserNotifier create() => UpdateUserNotifier();
}

String _$updateUserNotifierHash() =>
    r'4faca14f51a1098580efac1147321cb48884ab3a';

abstract class _$UpdateUserNotifier extends $AsyncNotifier<String?> {
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
