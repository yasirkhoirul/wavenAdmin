import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/model/photographer_booking_model.dart';
import 'package:wavenadmin/data/model/photographer_detail_model.dart';
import 'package:wavenadmin/data/model/photographer_payment_model.dart';

abstract class PhotographerPaymentRepository {
  Future<PhotographerPaymentResponse> getPhotographerPaymentList(
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
    String? sortBy,
    Sort? sort,
  });

  Future<PhotographerDetailResponse> getPhotographerDetail(String id);

  Future<PhotographerBookingResponse> getPhotographerBookings(
    String photographerId,
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
  });
}
