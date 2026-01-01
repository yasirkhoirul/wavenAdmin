import 'package:image_picker/image_picker.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/model/create_booking_request_model.dart';
import 'package:wavenadmin/data/model/verify_batch_booking_model.dart';
import 'package:wavenadmin/domain/entity/booking_list_data.dart';
import 'package:wavenadmin/domain/entity/detail_booking.dart';
import 'package:wavenadmin/data/model/create_transaction_request_model.dart';
import 'package:wavenadmin/data/model/update_booking_request_model.dart';
import 'package:wavenadmin/data/model/upload_photo_request_model.dart';
import 'package:wavenadmin/data/model/verify_booking_request_model.dart';
import 'package:wavenadmin/domain/entity/schedule_entity.dart';

abstract class BookingRepository {
  Future<BookingListData> getListBooking(int page, int limit, {String? search, Sort? sort, SortBooking? sortBy});
  Future<List<ScheduleEntity>> getListSchedule(int month,int year,{VerificationStatus? status});
  Future<DetailBooking> getDetailBooking(String idBooking);
  Future<UpdateBookingResponse> updateBooking(String idBooking, UpdateBookingRequest request);
  Future<VerifyBookingResponse> verifyBooking(String idBooking, VerifyStatus status, {String? remarks});
  Future<VerifyBookingResponse> verifyTransaction(String idTransaction, VerifyStatus status, {String? remarks});
  Future<VerifyBatchBookingResponse> verifyBatchBooking(List<String> bookingIds);
  Future<CreateTransactionResponse> createTransaction(String idBooking, CreateTransactionRequest request, XFile? imageFile);
  Future<List<int>> getQrisImage(String gatewayTransactionId);
  Future<QrisPaymentStatusResponse> checkQrisPaymentStatus(String bookingId, String gatewayTransactionId);
  Future<CreateBookingResponse> createBooking(CreateBookingRequest request, XFile? imageFile);
  Future<CheckAvailabilityResponse> checkBookingAvailability(String date, String startTime, String endTime);
  Future<UploadPhotoResponse> uploadPhotoResult(String idBooking, String photoUrl);
  Future<UploadPhotoResponse> uploadEditedPhoto(String idBooking, String photoUrl);
}