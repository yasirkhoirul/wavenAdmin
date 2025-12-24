import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/data/model/update_booking_request_model.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/detail_booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'update_booking_notifier.g.dart';

@Riverpod(keepAlive: true)
class UpdateBookingNotifier extends _$UpdateBookingNotifier {
  @override
  FutureOr<String> build() {
    return '';
  }

  Future<void> execute(String idBooking, UpdateBookingRequest request) async {
    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      final usecase = ref.read(updateBooking);
      final result = await usecase.execute(idBooking, request);
      return result.message ?? 'Booking berhasil diupdate';
    });
    await ref.read(detailBookingProvider(idBooking).notifier).onRefresh();
  }
}
