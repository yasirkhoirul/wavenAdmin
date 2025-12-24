import 'package:wavenadmin/domain/entity/detail_booking.dart';
import 'package:wavenadmin/domain/repository/booking_repository.dart';

class GetDetailBooking {
  final BookingRepository bookingRepository;
  const GetDetailBooking(this.bookingRepository);
  
  Future<DetailBooking> execute(String idBooking)async{
    return bookingRepository.getDetailBooking(idBooking);
  }
}