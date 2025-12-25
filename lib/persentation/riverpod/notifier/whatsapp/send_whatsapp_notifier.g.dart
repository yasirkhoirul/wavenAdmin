// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_whatsapp_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SendWhatsappNotifier)
const sendWhatsappProvider = SendWhatsappNotifierProvider._();

final class SendWhatsappNotifierProvider
    extends $AsyncNotifierProvider<SendWhatsappNotifier, String?> {
  const SendWhatsappNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendWhatsappProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendWhatsappNotifierHash();

  @$internal
  @override
  SendWhatsappNotifier create() => SendWhatsappNotifier();
}

String _$sendWhatsappNotifierHash() =>
    r'7abda18a1ed5f847481d16a45af3bdf7090532a3';

abstract class _$SendWhatsappNotifier extends $AsyncNotifier<String?> {
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
