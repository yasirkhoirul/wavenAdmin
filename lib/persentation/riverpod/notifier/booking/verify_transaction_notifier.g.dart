// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_transaction_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VerifyTransaction)
const verifyTransactionProvider = VerifyTransactionProvider._();

final class VerifyTransactionProvider
    extends $AsyncNotifierProvider<VerifyTransaction, String> {
  const VerifyTransactionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyTransactionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyTransactionHash();

  @$internal
  @override
  VerifyTransaction create() => VerifyTransaction();
}

String _$verifyTransactionHash() => r'774e03f2223c1ec20b73007cd46ab1f6eef38638';

abstract class _$VerifyTransaction extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
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
