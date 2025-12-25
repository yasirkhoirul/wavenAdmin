import 'package:image_picker/image_picker.dart';
import 'package:wavenadmin/data/model/create_booking_request_model.dart';
import 'package:wavenadmin/domain/repository/booking_repository.dart';

class CreateBookingUsecase {
  final BookingRepository repository;

  CreateBookingUsecase(this.repository);

  Future<CreateBookingResponse> execute(CreateBookingRequest request, XFile? imageFile) async {
    return await repository.createBooking(request, imageFile);
  }

  Future<CheckAvailabilityResponse> checkAvailability(String date, String startTime, String endTime) async {
    return await repository.checkBookingAvailability(date, startTime, endTime);
  }
}