import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/detail_booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'verify_booking_notifier.g.dart';

@Riverpod(keepAlive: true)
class VerifyBookingNotifier extends _$VerifyBookingNotifier {
  @override
  FutureOr<String> build() {
    return '';
  }

  Future<void> execute(String idBooking, VerifyStatus status, {String? remarks}) async {
    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      final usecase = ref.read(verifyBooking);
      final result = await usecase.execute(idBooking, status, remarks: remarks);
      // Refresh detail booking setelah verifikasi
      await ref.read(detailBookingProvider(idBooking).notifier).onRefresh();
      return result;
    });
  }
}
