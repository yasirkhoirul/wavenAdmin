import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/dio.dart';
import 'package:wavenadmin/data/model/admin_detail_model.dart';
import 'package:wavenadmin/data/model/booking_model.dart';
import 'package:wavenadmin/data/model/create_booking_request_model.dart';
import 'package:wavenadmin/data/model/detail_booking_model.dart';
import 'package:wavenadmin/data/model/list_addons_model.dart';
import 'package:wavenadmin/data/model/package_detail_model.dart';
import 'package:wavenadmin/data/model/package_dropdown_model.dart';
import 'package:wavenadmin/data/model/university_dropdown_model.dart';
import 'package:wavenadmin/data/model/create_transaction_request_model.dart';
import 'package:wavenadmin/data/model/update_booking_request_model.dart';
import 'package:wavenadmin/data/model/upload_photo_request_model.dart';
import 'package:wavenadmin/data/model/verify_booking_request_model.dart';
import 'package:wavenadmin/data/model/user_photographer_dropdown.dart';
import 'package:wavenadmin/data/model/tokenmode.dart';
import 'package:wavenadmin/data/model/user_admin_model.dart';
import 'package:wavenadmin/data/model/user_detial_fotografer_model.dart';
import 'package:wavenadmin/data/model/user_detial_model.dart';
import 'package:wavenadmin/data/model/user_photographer_model.dart';
import 'package:wavenadmin/data/model/usermodel.dart';

class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

String _friendlyErrorMessage(Object error) {
  if (error is DioException) {
    final status = error.response?.statusCode;
    final data = error.response?.data;

    // If backend returns JSON with message
    if (data is Map && data['message'] is String) {
      return data['message'] as String;
    }

    // If backend returns String body (often HTML error page)
    if (data is String) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map && decoded['message'] is String) {
          return decoded['message'] as String;
        }
      } catch (_) {
        // ignore json parse errors
      }

      final lower = data.toLowerCase();
      if (lower.contains('<html') || lower.contains('<!doctype html')) {
        return status == null
            ? 'Terjadi kesalahan pada server.'
            : 'Terjadi kesalahan pada server (HTTP $status).';
      }

      final trimmed = data.trim();
      if (trimmed.isNotEmpty) {
        return trimmed.length > 200 ? trimmed.substring(0, 200) : trimmed;
      }
    }

    if (error.message != null && error.message!.trim().isNotEmpty) {
      return status == null
          ? error.message!
          : '${error.message!} (HTTP $status)';
    }

    return status == null
        ? 'Request gagal.'
        : 'Request gagal (HTTP $status).';
  }

  return error.toString();
}

abstract class RemoteData {
  Future<Token> login(String email, String password);
  Future<bool> logout(String refreshToken);
  Future<UserListResponse> getListUser(int page, int limit, {String? search,Sort? sort,SortUser? sortBy});
  Future<UserListResponseAdmin> getListUserAdmin(int page, int limit, {String? search,Sort? sort,SortAdmin? sortAdmin});
  Future<UserFotograferListResponse> getListPhotographer(int page, int limit, {String? search,Sort? sort,SortPhotographer?  sortBy});
  Future<BookingListResponse> getListBooking(int page, int limit, {String? search, Sort? sort});
  Future<ListAddonsResponse> getListAddons(int page, int limit, {String? search});
  Future<PackageDropdownResponse> getPackageDropdown(int page, int limit, {String? search});
  Future<PackageDetailResponse> getPackageDetail(String packageId);
  Future<UniversityDropdownResponse> getUniversityDropdown(int page, int limit, {String? search});
  Future<PhotographerDropdownResponse> getPhotographerDropdown(int page, int limit, {String? search});
  Future<UserDetailResponse> getDetailUser(String idUser);
  Future<DetailBookingResponse> getDetailBooking(String idBooking);
  Future<UpdateBookingResponse> updateBooking(String idBooking, UpdateBookingRequest request);
  Future<VerifyBookingResponse> verifyBooking(String idBooking, VerifyStatus status, {String? remarks});
  Future<VerifyBookingResponse> verifyTransaction(String idTransaction, VerifyStatus status, {String? remarks});
  Future<CreateTransactionResponse> createTransaction(String idBooking, CreateTransactionRequest request, XFile? imageFile);
  Future<List<int>> getQrisImage(String gatewayTransactionId);
  Future<QrisPaymentStatusResponse> checkQrisPaymentStatus(String bookingId, String gatewayTransactionId);
  Future<CreateBookingResponse> createBooking(CreateBookingRequest request, XFile? imageFile);
  Future<CheckAvailabilityResponse> checkBookingAvailability(String date, String startTime, String endTime);
  Future<UploadPhotoResponse> uploadPhotoResult(String idBooking, String photoUrl);
  Future<UploadPhotoResponse> uploadEditedPhoto(String idBooking, String photoUrl);
  Future<UserDetailFotograferResponse> getDetailUserFotografer(String idUser);
  Future<AdminDetailResponse> getUserAdminDetail(String id);
  Future<String> putDetailAdmin(AdminDetailModel payload,String idAdmin);
  Future<String> putDetailFotografer(UserDetailFotograferModel payload,String idFotografer);
  Future<String> createAdmin(AdminDetailModel payload);
  Future<void> deleteAdmin(String idAdmin);
  Future<String> deleteFotografer(String idFotografer);
}

class RemoteDataImpl implements RemoteData {
  final http.Client client;
  final DioClient dio;
  const RemoteDataImpl(this.client,this.dio);
  final baseurl = "https://waven-development.site/";
  final baseuri = "waven-development.site";
  @override
  Future<Token> login(String email, String password) async {
    try {
      final uri = Uri.parse('${baseurl}v1/auth/login');
      final String basicAuth =
          'Basic ${base64Encode(utf8.encode('$email:$password'))}';
      final response = await client.post(
        uri,
        headers: {
          'Authorization': basicAuth,
          'content-type': 'application/json',
        },
      );
      if (response.statusCode != 200) {
        throw jsonDecode(response.body)['message'];
      }
      if (response.headers['x-access-token'] != null &&
          response.headers['x-refresh-token'] != null) {
        return Token(
          response.headers['x-access-token']!,
          response.headers['x-refresh-token']!,
        );
      } else {
        throw "gagal mendapatkan token";
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<UserListResponse> getListUser(int page, int limit, {String? search,Sort? sort,SortUser? sortBy}) async{
    try {
      final response = await dio.dio.get('v1/admin/users',queryParameters: {
        'page':page,
        'limit':limit,
        if(search!=null)'search':search,
        if(sort!=null)'sort':sort.name,
        if(sortBy!= null)'sort_by':sortBy.name
      });
      if (response.statusCode != 200) {
        throw AppException('Request gagal (HTTP ${response.statusCode}).');
      }
      return UserListResponse.fromJson(response.data);
    } catch (e) {
      Logger().d("reponse nya adalah $e");
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<bool> logout(String refreshToken) async{
    final uri = Uri.parse("${baseurl}v1/auth/logout");
    try {
      final response = await client.post(uri,
      headers: {
        'Content-Type':'application/json'
      },
      body: jsonEncode({
        'refresh_token':refreshToken
      }));
      if (response.statusCode == 200) {
        return true;
      }else{
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<UserListResponseAdmin> getListUserAdmin(int page, int limit, {String? search, Sort? sort,SortAdmin? sortAdmin}) async{
    try {
      final response = await dio.dio.get('v1/admin/admins',
      queryParameters: {
        'page':page,
        'limit':limit,
        if(search!=null)'search':search,
        if(sort!=null)'sort':sort.name,
        if(sortAdmin!=null)'sort_by':sortAdmin.name
      });
      if (response.statusCode != 200) {
        throw AppException('Request gagal (HTTP ${response.statusCode}).');
      }
      return UserListResponseAdmin.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<AdminDetailResponse> getUserAdminDetail(String id) async{
    try {
      final response = await dio.dio.get('v1/admin/admins/$id');
      if (response.statusCode == 200) {
        return AdminDetailResponse.fromJson(response.data);
      }else{
        final data = response.data;
        if (data is Map && data['message'] is String) {
          throw AppException(data['message'] as String);
        }
        throw AppException('Request gagal (HTTP ${response.statusCode}).');
      }
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<String> putDetailAdmin(AdminDetailModel payload,String idAdmin) async{
    try {
      final response = await dio.dio.put(
        'v1/admin/admins/$idAdmin',
        data: payload.toUpdateJson(),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map && data['message'] is String) {
          return data['message'] as String;
        }
        return "sukses";
      }else{
        throw AppException('Request gagal (HTTP ${response.statusCode}).');
      }
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<String> createAdmin(AdminDetailModel payload) async{
    try {
      final response = await dio.dio.post(
        'v1/admin/admins',
        data: {
          'username':payload.username,
          'password':payload.pw,
          'email':payload.email,
          'name':payload.name,
          'phone_number':payload.phoneNumber
        },
      );
      if (response.statusCode == 201) {
        final data = response.data;
        if (data is Map && data['message'] is String) {
          return data['message'] as String;
        }
        return "sukses";
      }else{
        throw AppException('Request gagal (HTTP ${response.statusCode}).');
      }
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<void> deleteAdmin(String idAdmin) async{
    try {
      final responseData = await dio.dio.delete('v1/admin/admins/$idAdmin');
      if (responseData.statusCode!=200){
        throw AppException('Request gagal (HTTP ${responseData.statusCode}).');
      }
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<UserDetailResponse> getDetailUser(String idUser) async{
    try {
      final responseData = await dio.dio.get('v1/admin/users/$idUser');
      if (responseData.statusCode == 200) {
        return UserDetailResponse.fromJson(responseData.data);
      }else{
        throw AppException("request gagal error code ${responseData.statusCode}");
      }
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<UserFotograferListResponse> getListPhotographer(int page, int limit, {String? search, Sort? sort, SortPhotographer? sortBy}) async{
     try {
      final response = await dio.dio.get('v1/admin/photographers',
      queryParameters: {
        'page':page,
        'limit':limit,
        if(search!=null)'search':search,
        if(sort!=null)'sort':sort.name,
        if(sortBy!=null)'sort_by':sortBy.name
      });
      if (response.statusCode != 200) {
        throw AppException('Request gagal (HTTP ${response.statusCode}).');
      }
      return UserFotograferListResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<UserDetailFotograferResponse> getDetailUserFotografer(String idUser) async{
    try {
      final response = await dio.dio.get('v1/admin/photographers/$idUser');
      if (response.statusCode == 200) {
        
      return UserDetailFotograferResponse.fromJson(response.data);
      }else{
        throw AppException("${response.statusCode}");
      }
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<String> putDetailFotografer(UserDetailFotograferModel payload, String idFotografer)async {
    try {
      final response = await dio.dio.put('v1/admin/photographers/$idFotografer',data: payload.toJson());
      if (response.statusCode == 200) {
        return response.data['message'];
      }else{
        throw AppException("${response.statusCode}");
      }
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<String> deleteFotografer(String idFotografer) async{
    try {
      final response = await dio.dio.delete('v1/admin/photographers/$idFotografer');
      if (response.statusCode == 200) {
        return "Foto Grafer Berhasil Di Hapus";
      }
      else{
        throw AppException(response.statusCode.toString());
      }
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<BookingListResponse> getListBooking(int page, int limit, {String? search, Sort? sort}) async {
    try {
      final response = await dio.dio.get(
        'v1/admin/bookings',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
          if (sort != null) 'sort': sort.name,
        },
      );
      if (response.statusCode != 200) {
        throw AppException('Request gagal (HTTP ${response.statusCode}).');
      }
      return BookingListResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<DetailBookingResponse> getDetailBooking(String idBooking) async{
    Logger().d("$idBooking ini adalah id booking");
    try {
      final response = await dio.dio.get(
        'v1/admin/bookings/$idBooking',
      );
      Logger().i(response.data);
      if (response.statusCode != 200) {
        throw AppException('Request gagal (HTTP ${response.statusCode}).');
      }
      return DetailBookingResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }

  @override
  Future<UpdateBookingResponse> updateBooking(String idBooking, UpdateBookingRequest request) async{
    Logger().d("Updating booking: $idBooking");
    try {
      final response = await dio.dio.put(
        'v1/admin/bookings/$idBooking',
        data: request.toJson(),
      );
      Logger().i(response.data);
      if (response.statusCode != 200) {
        throw AppException('Request gagal (HTTP ${response.statusCode}).');
      }
      return UpdateBookingResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<VerifyBookingResponse> verifyBooking(String idBooking, VerifyStatus status, {String? remarks}) async {
    Logger().d("Verifying booking: $idBooking with status: ${status.name}");
    try {
      final request = VerifyBookingRequest.fromEnum(status, remarks: remarks??'');
      final response = await dio.dio.patch(
        'v1/admin/bookings/$idBooking/verify',
        data: request.toJson(),
      );
      if (response.statusCode != 200) {
        throw AppException('Failed to verify booking');
      }
      return VerifyBookingResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }

  @override
  Future<VerifyBookingResponse> verifyTransaction(String idTransaction, VerifyStatus status, {String? remarks}) async {
    Logger().d("Verifying transaction: $idTransaction with status: ${status.name}");
    try {
      final request = VerifyBookingRequest.fromEnum(status, remarks: remarks??'');
      final response = await dio.dio.patch(
        'v1/admin/transactions/$idTransaction/verify',
        data: request.toJson(),
      );
      if (response.statusCode != 200) {
        throw AppException('Failed to verify transaction');
      }
      return VerifyBookingResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }

  @override
  Future<CreateTransactionResponse> createTransaction(String idBooking, CreateTransactionRequest request, XFile? imageFile) async {
    Logger().d("Creating transaction for booking: $idBooking");
    try {
      final formData = FormData();
      
      // Add JSON data as string
      formData.fields.add(MapEntry('data', json.encode(request.toJson())));
      
      // Add image file if exists
      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        formData.files.add(
          MapEntry(
            'image',
            MultipartFile.fromBytes(
              bytes,
              filename: imageFile.name,
            ),
          ),
        );
      }
      
      final response = await dio.dio.post(
        'v1/admin/bookings/$idBooking/transactions',
        data: formData,
      );
      
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw AppException('Failed to create transaction');
      }
      
      return CreateTransactionResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
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
      throw AppException(_friendlyErrorMessage(e));
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
      throw AppException(_friendlyErrorMessage(e));
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
      throw AppException(_friendlyErrorMessage(e));
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
      throw AppException(_friendlyErrorMessage(e));
    }
  }

  @override
  Future<ListAddonsResponse> getListAddons(int page, int limit, {String? search}) async{
    try {
      final response = await dio.dio.get("v1/admin/addons",
      queryParameters: {
        'page':page,
        'limit': limit,
        if(search!=null)'search':search
      }
      );
      if (response.statusCode != 200) {
        throw AppException(response.statusCode.toString());
      }
      return ListAddonsResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<PackageDropdownResponse> getPackageDropdown(int page, int limit, {String? search}) async {
    try {
      final response = await dio.dio.get('v1/admin/packages/dropdown',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
        });
      if (response.statusCode != 200) {
        throw AppException(response.statusCode.toString());
      }
      return PackageDropdownResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  @override
  Future<PackageDetailResponse> getPackageDetail(String packageId) async {
    try {
      final response = await dio.dio.get('v1/admin/packages/$packageId');
      if (response.statusCode != 200) {
        throw AppException(response.statusCode.toString());
      }
      return PackageDetailResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }  
  @override
  Future<UniversityDropdownResponse> getUniversityDropdown(int page, int limit, {String? search}) async {
    try {
      final response = await dio.dio.get('v1/admin/master/universities',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
        });
      if (response.statusCode != 200) {
        throw AppException(response.statusCode.toString());
      }
      return UniversityDropdownResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<PhotographerDropdownResponse> getPhotographerDropdown(int page, int limit, {String? search}) async {
    try {
      final response = await dio.dio.get('v1/admin/photographers/dropdown',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
        });
      if (response.statusCode != 200) {
        throw AppException(response.statusCode.toString());
      }
      return PhotographerDropdownResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }

  @override
  Future<CreateBookingResponse> createBooking(CreateBookingRequest request, XFile? imageFile) async {
    try {
      final formData = FormData();
      
      // Add JSON data as string
      formData.fields.add(MapEntry('data', json.encode(request.toJson())));
      
      // Add image file if provided
      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        formData.files.add(MapEntry(
          'image',
          MultipartFile.fromBytes(bytes, filename: imageFile.name),
        ));
      }
      
      final response = await dio.dio.post(
        'v1/admin/bookings',
        data: formData,
      );
      
      if (response.statusCode != 201) {
        throw AppException(response.statusCode.toString());
      }
      
      return CreateBookingResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
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
      if (response.statusCode != 200) {
        throw AppException(response.statusCode.toString());
      }
      
      return CheckAvailabilityResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
}
