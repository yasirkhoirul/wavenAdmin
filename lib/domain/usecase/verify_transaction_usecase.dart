import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/repository/booking_repository.dart';

class VerifyTransactionUsecase {
  final BookingRepository repository;

  const VerifyTransactionUsecase(this.repository);

  Future<String> execute(String idTransaction, VerifyStatus status, {String? remarks}) async {
    try {
      final response = await repository.verifyTransaction(idTransaction, status, remarks: remarks);
      return response.message ?? 'Transaksi berhasil diverifikasi';
    } catch (e) {
      rethrow;
    }
  }
}
