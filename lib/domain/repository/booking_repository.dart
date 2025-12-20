import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/booking_list_data.dart';

abstract class BookingRepository {
  Future<BookingListData> getListBooking(int page, int limit, {String? search, Sort? sort});
}