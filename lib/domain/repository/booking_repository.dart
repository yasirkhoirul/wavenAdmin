import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/booking_list_data.dart';
import 'package:wavenadmin/domain/entity/detail_booking.dart';
import 'package:wavenadmin/data/model/update_booking_request_model.dart';
import 'package:wavenadmin/data/model/upload_photo_request_model.dart';
import 'package:wavenadmin/data/model/verify_booking_request_model.dart';

abstract class BookingRepository {
  Future<BookingListData> getListBooking(int page, int limit, {String? search, Sort? sort});
  Future<DetailBooking> getDetailBooking(String idBooking);
  Future<UpdateBookingResponse> updateBooking(String idBooking, UpdateBookingRequest request);
  Future<VerifyBookingResponse> verifyBooking(String idBooking, VerifyStatus status, {String? remarks});
  Future<VerifyBookingResponse> verifyTransaction(String idTransaction, VerifyStatus status, {String? remarks});
  Future<UploadPhotoResponse> uploadPhotoResult(String idBooking, String photoUrl);
  Future<UploadPhotoResponse> uploadEditedPhoto(String idBooking, String photoUrl);
}