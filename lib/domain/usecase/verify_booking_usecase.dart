import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/repository/booking_repository.dart';

class VerifyBookingUsecase {
  final BookingRepository repository;

  const VerifyBookingUsecase(this.repository);

  Future<String> execute(String idBooking, VerifyStatus status, {String? remarks}) async {
    try {
      final response = await repository.verifyBooking(idBooking, status, remarks: remarks);
      return response.message ?? 'Booking berhasil diverifikasi';
    } catch (e) {
      rethrow;
    }
  }
}
