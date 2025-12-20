import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/booking_list_data.dart';
import 'package:wavenadmin/domain/repository/booking_repository.dart';

class GetListBooking {
  final BookingRepository repository;

  const GetListBooking(this.repository);

  Future<BookingListData> execute(int page, int limit, {String? search, Sort? sort}) async {
    return await repository.getListBooking(page, limit, search: search, sort: sort);
  }
}