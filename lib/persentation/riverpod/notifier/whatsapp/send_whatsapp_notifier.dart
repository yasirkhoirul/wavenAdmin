import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/injection.dart';
import 'package:wavenadmin/data/datasource/remote_data.dart';

part 'send_whatsapp_notifier.g.dart';

@riverpod
class SendWhatsappNotifier extends _$SendWhatsappNotifier {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> sendMessage(String target, String message) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final remoteData = locator<RemoteData>();
      final response = await remoteData.sendWhatsappMessage(target, message);
      return response.message;
    });
  }

  void reset() {
    state = const AsyncData(null);
  }
}
