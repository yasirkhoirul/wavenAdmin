// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userDetail.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserDetail)
const userDetailProvider = UserDetailFamily._();

final class UserDetailProvider
    extends $AsyncNotifierProvider<UserDetail, DetailUser> {
  const UserDetailProvider._({
    required UserDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userDetailHash();

  @override
  String toString() {
    return r'userDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserDetail create() => UserDetail();

  @override
  bool operator ==(Object other) {
    return other is UserDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userDetailHash() => r'636bcf21fb01913b23470de56a91979912f37a23';

final class UserDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          UserDetail,
          AsyncValue<DetailUser>,
          DetailUser,
          FutureOr<DetailUser>,
          String
        > {
  const UserDetailFamily._()
    : super(
        retry: null,
        name: r'userDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserDetailProvider call(String idUser) =>
      UserDetailProvider._(argument: idUser, from: this);

  @override
  String toString() => r'userDetailProvider';
}

abstract class _$UserDetail extends $AsyncNotifier<DetailUser> {
  late final _$args = ref.$arg as String;
  String get idUser => _$args;

  FutureOr<DetailUser> build(String idUser);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<DetailUser>, DetailUser>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DetailUser>, DetailUser>,
              AsyncValue<DetailUser>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
