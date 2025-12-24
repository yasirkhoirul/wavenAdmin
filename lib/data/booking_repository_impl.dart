import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/data/model/update_booking_request_model.dart';
import 'package:wavenadmin/data/model/upload_photo_request_model.dart';
import 'package:wavenadmin/data/model/verify_booking_request_model.dart';
import 'package:wavenadmin/domain/entity/booking_list_data.dart';
import 'package:wavenadmin/domain/entity/detail_booking.dart';
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

  @override
  Future<DetailBooking> getDetailBooking(String idBooking) async{
    try {
      final response = await remoteData.getDetailBooking(idBooking);
      return response.toEntity();
    } catch (e) {
      rethrow;
    }
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
    try {
      final response = await remoteData.verifyBooking(idBooking, status, remarks: remarks);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyBookingResponse> verifyTransaction(String idTransaction, VerifyStatus status, {String? remarks}) async {
    try {
      final response = await remoteData.verifyTransaction(idTransaction, status, remarks: remarks);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UploadPhotoResponse> uploadPhotoResult(String idBooking, String photoUrl) async {
    try {
      final response = await remoteData.uploadPhotoResult(idBooking, photoUrl);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UploadPhotoResponse> uploadEditedPhoto(String idBooking, String photoUrl) async {
    try {
      final response = await remoteData.uploadEditedPhoto(idBooking, photoUrl);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}