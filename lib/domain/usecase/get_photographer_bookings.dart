import 'package:wavenadmin/data/model/photographer_booking_model.dart';
import 'package:wavenadmin/domain/repository/photographer_payment_repository.dart';

class GetPhotographerBookings {
  final PhotographerPaymentRepository repository;

  GetPhotographerBookings(this.repository);

  Future<PhotographerBookingResponse> execute(
    String photographerId,
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return repository.getPhotographerBookings(
      photographerId,
      page,
      limit,
      search: search,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
