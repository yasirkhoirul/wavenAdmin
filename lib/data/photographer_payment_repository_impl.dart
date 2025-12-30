import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/data/model/photographer_booking_model.dart';
import 'package:wavenadmin/data/model/photographer_detail_model.dart';
import 'package:wavenadmin/data/model/photographer_payment_model.dart';
import 'package:wavenadmin/domain/repository/photographer_payment_repository.dart';

class PhotographerPaymentRepositoryImpl implements PhotographerPaymentRepository {
  final RemoteData remoteData;

  PhotographerPaymentRepositoryImpl({required this.remoteData});

  @override
  Future<PhotographerPaymentResponse> getPhotographerPaymentList(
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
    String? sortBy,
    Sort? sort,
  }) async {
    return await remoteData.getPhotographerPaymentList(
      page,
      limit,
      search: search,
      startTime: startTime,
      endTime: endTime,
      sortBy: sortBy,
      sort: sort,
    );
  }

  @override
  Future<PhotographerDetailResponse> getPhotographerDetail(String id) async {
    return await remoteData.getPhotographerDetail(id);
  }

  @override
  Future<PhotographerBookingResponse> getPhotographerBookings(
    String photographerId,
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    return await remoteData.getPhotographerBookings(
      photographerId,
      page,
      limit,
      search: search,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
