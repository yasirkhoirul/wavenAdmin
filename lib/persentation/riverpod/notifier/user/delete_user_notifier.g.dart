// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_user_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DeleteUserNotifier)
const deleteUserProvider = DeleteUserNotifierProvider._();

final class DeleteUserNotifierProvider
    extends $AsyncNotifierProvider<DeleteUserNotifier, String?> {
  const DeleteUserNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteUserNotifierHash();

  @$internal
  @override
  DeleteUserNotifier create() => DeleteUserNotifier();
}

String _$deleteUserNotifierHash() =>
    r'568bf78571794a3f3fc60771619acaa869a3af9d';

abstract class _$DeleteUserNotifier extends $AsyncNotifier<String?> {
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
