import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/detail_booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'verify_transaction_notifier.g.dart';

@Riverpod(keepAlive: true)
class VerifyTransaction extends _$VerifyTransaction {
  @override
  FutureOr<String> build() {
    return '';
  }

  Future<void> execute(String idBooking, String idTransaction, VerifyStatus status, {String? remarks}) async {
    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      final usecase = ref.read(verifyTransactionUsecase);
      final result = await usecase.execute(idTransaction, status, remarks: remarks);
      
      // Refresh detail booking setelah verifikasi transaksi
      await ref.read(detailBookingProvider(idBooking).notifier).onRefresh();
      
      return result;
    });
  }
}


