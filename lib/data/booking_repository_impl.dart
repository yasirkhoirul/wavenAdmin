import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/domain/entity/booking_list_data.dart';
import 'package:wavenadmin/domain/repository/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final RemoteData remoteData;

  const BookingRepositoryImpl(this.remoteData);

  @override
  Future<BookingListData> getListBooking(int page, int limit, {String? search, Sort? sort}) async {
    try {
      final response = await remoteData.getListBooking(page, limit, search: search, sort: sort);
      return response.toBookingListData();
    } catch (e) {
      rethrow;
    }
  }
}