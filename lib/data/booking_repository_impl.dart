import 'package:image_picker/image_picker.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/booking_remote_data_source.dart';
import 'package:wavenadmin/data/model/create_booking_request_model.dart';
import 'package:wavenadmin/data/model/create_transaction_request_model.dart';
import 'package:wavenadmin/data/model/update_booking_request_model.dart';
import 'package:wavenadmin/data/model/upload_photo_request_model.dart';
import 'package:wavenadmin/data/model/verify_batch_booking_model.dart';
import 'package:wavenadmin/data/model/verify_booking_request_model.dart';
import 'package:wavenadmin/domain/entity/booking_list_data.dart';
import 'package:wavenadmin/domain/entity/detail_booking.dart';
import 'package:wavenadmin/domain/entity/schedule_entity.dart';
import 'package:wavenadmin/domain/repository/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteData;

  const BookingRepositoryImpl(this.remoteData);

  @override
  Future<BookingListData> getListBooking(int page, int limit, {String? search, Sort? sort, SortBooking? sortBy}) async {
    final response = await remoteData.getListBooking(page, limit, search: search, sort: sort, sortBy: sortBy);
    return response.toBookingListData();
  }

  @override
  Future<DetailBooking> getDetailBooking(String idBooking) async{
    final response = await remoteData.getDetailBooking(idBooking);
    return response.toEntity();
  }

  @override
  Future<UpdateBookingResponse> updateBooking(String idBooking, UpdateBookingRequest request) async {
    try {
      final response = await remoteData.updateBooking(idBooking, request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyBookingResponse> verifyBooking(String idBooking, VerifyStatus status, {String? remarks}) async {
    final response = await remoteData.verifyBooking(idBooking, status, remarks: remarks);
    return response;
  }

  @override
  Future<VerifyBookingResponse> verifyTransaction(String idTransaction, VerifyStatus status, {String? remarks}) async {
    final response = await remoteData.verifyTransaction(idTransaction, status, remarks: remarks);
    return response;
  }

  @override
  Future<VerifyBatchBookingResponse> verifyBatchBooking(List<String> bookingIds) async {
    final response = await remoteData.verifyBatchBooking(bookingIds);
    return response;
  }

  @override
  Future<CreateTransactionResponse> createTransaction(String idBooking, CreateTransactionRequest request, XFile? imageFile) async {
    final response = await remoteData.createTransaction(idBooking, request, imageFile);
    return response;
  }

  @override
  Future<List<int>> getQrisImage(String gatewayTransactionId) async {
    final response = await remoteData.getQrisImage(gatewayTransactionId);
    return response;
  }

  @override
  Future<QrisPaymentStatusResponse> checkQrisPaymentStatus(String bookingId, String gatewayTransactionId) async {
    final response = await remoteData.checkQrisPaymentStatus(bookingId, gatewayTransactionId);
    return response;
  }

  @override
  Future<UploadPhotoResponse> uploadPhotoResult(String idBooking, String photoUrl) async{
    final response = await remoteData.uploadPhotoResult(idBooking, photoUrl);
    return response;
  }

  @override
  Future<UploadPhotoResponse> uploadEditedPhoto(String idBooking, String photoUrl) async {
    final response = await remoteData.uploadEditedPhoto(idBooking, photoUrl);
    return response;
  }

  @override
  Future<CheckAvailabilityResponse> checkBookingAvailability(String date, String startTime, String endTime) async {
    final response = await remoteData.checkBookingAvailability(date, startTime, endTime);
    return response;
  }

  @override
  Future<CreateBookingResponse> createBooking(CreateBookingRequest request, XFile? imageFile) async {
    final response = await remoteData.createBooking(request, imageFile);
    return response;
  }

  @override
  Future<List<ScheduleEntity>> getListSchedule(int month, int year, {VerificationStatus? status}) async{
    final data = await remoteData.getListSchedule(month, year,status: status);
    return data.data.map((e) => e.toEntity(),).toList();
  }
}