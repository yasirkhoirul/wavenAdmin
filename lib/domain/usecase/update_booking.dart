import 'package:wavenadmin/data/model/update_booking_request_model.dart';
import 'package:wavenadmin/domain/repository/booking_repository.dart';

class UpdateBooking {
  final BookingRepository repository;

  UpdateBooking(this.repository);

  Future<UpdateBookingResponse> execute(String idBooking, UpdateBookingRequest request) async {
    return await repository.updateBooking(idBooking, request);
  }
}
