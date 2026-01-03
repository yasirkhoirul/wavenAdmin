import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/base/base_remote_data_source.dart';
import 'package:wavenadmin/data/model/booking_model.dart';
import 'package:wavenadmin/data/model/create_booking_request_model.dart';
import 'package:wavenadmin/data/model/create_transaction_request_model.dart';
import 'package:wavenadmin/data/model/detail_booking_model.dart';
import 'package:wavenadmin/data/model/schedule_model.dart';
import 'package:wavenadmin/data/model/update_booking_request_model.dart';
import 'package:wavenadmin/data/model/upload_photo_request_model.dart';
import 'package:wavenadmin/data/model/verify_batch_booking_model.dart';
import 'package:wavenadmin/data/model/verify_booking_request_model.dart';

abstract class BookingRemoteDataSource {
  Future<BookingListResponse> getListBooking(int page, int limit, {String? search, Sort? sort, SortBooking? sortBy});
  Future<ScheduleModel> getListSchedule(int month, int year, {VerificationStatus? status});
  Future<DetailBookingResponse> getDetailBooking(String idBooking);
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

class BookingRemoteDataSourceImpl extends BaseRemoteDataSource
    implements BookingRemoteDataSource {
  
  BookingRemoteDataSourceImpl(super.dio);

  @override
  Future<BookingListResponse> getListBooking(int page, int limit, {String? search, Sort? sort, SortBooking? sortBy}) async {
    try {
      final response = await dio.dio.get(
        'v1/admin/bookings',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
          if (sort != null) 'sort': sort.name,
          if (sortBy != null) 'sort_by': sortBy.name,
        },
      );
      return handleResponse(response, (data) => BookingListResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<ScheduleModel> getListSchedule(int month, int year, {VerificationStatus? status}) async {
    try {
      final response = await dio.dio.get(
        "v1/admin/bookings/calendar",
        queryParameters: {
          'month': month,
          'year': year,
          if (status != null) 'status': status.name
        }
      );
      return handleResponse(response, (data) => ScheduleModel.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<DetailBookingResponse> getDetailBooking(String idBooking) async {
    Logger().d("$idBooking ini adalah id booking");
    try {
      final response = await dio.dio.get(
        'v1/admin/bookings/$idBooking',
      );
      Logger().i(response.data);
      return handleResponse(response, (data) => DetailBookingResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<UpdateBookingResponse> updateBooking(String idBooking, UpdateBookingRequest request) async {
    Logger().d("Updating booking: $idBooking");
    try {
      final response = await dio.dio.put(
        'v1/admin/bookings/$idBooking',
        data: request.toJson(),
      );
      Logger().i(response.data);
      return handleResponse(response, (data) => UpdateBookingResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<VerifyBookingResponse> verifyBooking(String idBooking, VerifyStatus status, {String? remarks}) async {
    Logger().d("Verifying booking: $idBooking with status: ${status.name}");
    try {
      final request = VerifyBookingRequest.fromEnum(status, remarks: remarks ?? '');
      final response = await dio.dio.patch(
        'v1/admin/bookings/$idBooking/verify',
        data: request.toJson(),
      );
      if (response.statusCode != 200) {
        throw AppException('Failed to verify booking');
      }
      return VerifyBookingResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<VerifyBookingResponse> verifyTransaction(String idTransaction, VerifyStatus status, {String? remarks}) async {
    Logger().d("Verifying transaction: $idTransaction with status: ${status.name}");
    try {
      final request = VerifyBookingRequest.fromEnum(status, remarks: remarks ?? '');
      final response = await dio.dio.patch(
        'v1/admin/transactions/$idTransaction/verify',
        data: request.toJson(),
      );
      if (response.statusCode != 200) {
        throw AppException('Failed to verify transaction');
      }
      return VerifyBookingResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<VerifyBatchBookingResponse> verifyBatchBooking(List<String> bookingIds) async {
    Logger().d("Verifying batch bookings: $bookingIds");
    try {
      final request = VerifyBatchBookingRequest(ids: bookingIds);
      final response = await dio.dio.patch(
        'v1/admin/bookings/verify-batch',
        data: request.toJson(),
      );
      if (response.statusCode != 200) {
        throw AppException('Failed to verify batch bookings');
      }
      return VerifyBatchBookingResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<CreateTransactionResponse> createTransaction(String idBooking, CreateTransactionRequest request, XFile? imageFile) async {
    try {
      // Use same pattern as updatePackage/createPackage that works
      final formData = FormData();
      
      formData.fields.add(MapEntry("data", jsonEncode(request.toJson())));
      
      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        formData.files.add(
          MapEntry('image', MultipartFile.fromBytes(bytes, filename: "image.png")),
        );
      }
      
      final response = await dio.dio.post('v1/admin/bookings/$idBooking/transactions', data: formData);
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw AppException(response.data['message'] ?? 'Failed to create transaction');
      }
      return CreateTransactionResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<List<int>> getQrisImage(String gatewayTransactionId) async {
    Logger().d("Getting QRIS image for: $gatewayTransactionId");
    try {
      final response = await dio.dio.get(
        'v1/bookings/$gatewayTransactionId/qris',
        options: Options(responseType: ResponseType.bytes),
      );
      
      if (response.statusCode != 200) {
        throw AppException('Failed to get QRIS image');
      }
      
      return response.data as List<int>;
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<QrisPaymentStatusResponse> checkQrisPaymentStatus(String bookingId, String gatewayTransactionId) async {
    Logger().d("Checking QRIS payment status for booking: $bookingId, gateway: $gatewayTransactionId");
    try {
      final response = await dio.dio.get(
        'v1/bookings/$bookingId/qris/$gatewayTransactionId',
      );
      
      if (response.statusCode != 200) {
        throw AppException('Failed to check payment status');
      }
      
      return QrisPaymentStatusResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<CreateBookingResponse> createBooking(CreateBookingRequest request, XFile? imageFile) async {
    try {
      // Use same pattern as updatePackage/createPackage that works
      final formData = FormData();
      
      final jsonData = jsonEncode(request.toJson());
      Logger().d("=== CREATE BOOKING ===");
      Logger().d("JSON data: $jsonData");
      Logger().d("JSON length: ${jsonData.length}");
      Logger().d("Has image: ${imageFile != null}");
      
      formData.fields.add(MapEntry("data", jsonData));
      
      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        Logger().d("Image bytes length: ${bytes.length}");
        formData.files.add(
          MapEntry('image', MultipartFile.fromBytes(bytes, filename: "image.png")),
        );
      }
      
      Logger().d("FormData fields: ${formData.fields.length}");
      Logger().d("FormData files: ${formData.files.length}");
      Logger().d("====================");
      
      final response = await dio.dio.post('v1/admin/bookings', data: formData);
      Logger().d("Response status: ${response.statusCode}");
      
      if (response.statusCode != 201) {
        throw AppException(response.data['message'] ?? response.statusCode.toString());
      }
      return CreateBookingResponse.fromJson(response.data);
    } catch (e) {
      Logger().e("Create booking error: $e");
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<CheckAvailabilityResponse> checkBookingAvailability(
    String date, 
    String startTime, 
    String endTime
  ) async {
    try {
      final response = await dio.dio.get(
        'v1/bookings/availibility',
        queryParameters: {
          'date': date,
          'start_time': startTime,
          'end_time': endTime,
        },
      );
      return handleResponse(response, (data) => CheckAvailabilityResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<UploadPhotoResponse> uploadPhotoResult(String idBooking, String photoUrl) async {
    Logger().d("Uploading photo result for booking: $idBooking");
    try {
      final request = UploadPhotoResultRequest(photoResultUrl: photoUrl);
      final response = await dio.dio.patch(
        'v1/admin/bookings/$idBooking/photo-result',
        data: request.toJson(),
      );
      if (response.statusCode != 200) {
        throw AppException('Failed to upload photo result');
      }
      return UploadPhotoResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<UploadPhotoResponse> uploadEditedPhoto(String idBooking, String photoUrl) async {
    Logger().d("Uploading edited photo for booking: $idBooking");
    try {
      final request = UploadEditedPhotoRequest(editedPhotoUrl: photoUrl);
      final response = await dio.dio.patch(
        'v1/admin/bookings/$idBooking/photo-edited',
        data: request.toJson(),
      );
      if (response.statusCode != 200) {
        throw AppException('Failed to upload edited photo');
      }
      return UploadPhotoResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }
}
