import 'package:wavenadmin/data/model/verify_batch_booking_model.dart';
import 'package:wavenadmin/domain/repository/booking_repository.dart';

class VerifyBatchBooking {
  final BookingRepository repository;

  const VerifyBatchBooking(this.repository);

  Future<VerifyBatchBookingResponse> execute(List<String> bookingIds) async {
    return await repository.verifyBatchBooking(bookingIds);
  }
}
