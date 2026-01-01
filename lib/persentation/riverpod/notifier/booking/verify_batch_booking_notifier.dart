import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/data/model/verify_batch_booking_model.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'verify_batch_booking_notifier.g.dart';

@riverpod
class VerifyBatchBookingNotifier extends _$VerifyBatchBookingNotifier {
  @override
  FutureOr<VerifyBatchBookingResponse?> build() {
    return null;
  }

  Future<void> verifyBatch(List<String> bookingIds) async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      final usecase = ref.read(verifyBatchBookingUsecase);
      final response = await usecase.execute(bookingIds);
      Logger().i('Batch verify successful: ${response.verifiedCount} bookings verified');
      return response;
    });
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
