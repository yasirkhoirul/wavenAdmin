import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/schedule_entity.dart';
import 'package:wavenadmin/domain/repository/booking_repository.dart';

class GetListSchedule {
  final BookingRepository bookingRepository;
  const GetListSchedule(this.bookingRepository);

  Future<List<ScheduleEntity>> execute(int month,int year,{VerificationStatus? status})async{
    return bookingRepository.getListSchedule(month, year,status: status);
  }
}