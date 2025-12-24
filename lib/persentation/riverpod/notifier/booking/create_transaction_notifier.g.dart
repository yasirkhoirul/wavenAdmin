// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_transaction_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateTransaction)
const createTransactionProvider = CreateTransactionProvider._();

final class CreateTransactionProvider
    extends
        $AsyncNotifierProvider<CreateTransaction, CreateTransactionResponse?> {
  const CreateTransactionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createTransactionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createTransactionHash();

  @$internal
  @override
  CreateTransaction create() => CreateTransaction();
}

String _$createTransactionHash() => r'7e289680afdbcb7eaa5a3a95193bb22e9fd90440';

abstract class _$CreateTransaction
    extends $AsyncNotifier<CreateTransactionResponse?> {
  FutureOr<CreateTransactionResponse?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<CreateTransactionResponse?>,
              CreateTransactionResponse?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CreateTransactionResponse?>,
                CreateTransactionResponse?
              >,
              AsyncValue<CreateTransactionResponse?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
