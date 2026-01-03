import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/dio.dart';
import 'package:wavenadmin/data/model/admin_detail_model.dart';
import 'package:wavenadmin/data/model/addons_dropdown_model.dart';
import 'package:wavenadmin/data/model/addon_detail_model.dart';
import 'package:wavenadmin/data/model/booking_model.dart';
import 'package:wavenadmin/data/model/create_fotografer_request.dart';
import 'package:wavenadmin/data/model/create_package_model.dart';
import 'package:wavenadmin/data/model/create_booking_request_model.dart';
import 'package:wavenadmin/data/model/dashboard_model.dart';
import 'package:wavenadmin/data/model/delete_batch_user_model.dart';
import 'package:wavenadmin/data/model/detail_booking_model.dart';
import 'package:wavenadmin/data/model/list_addons_model.dart';
import 'package:wavenadmin/data/model/pengaturan_model.dart';
import 'package:wavenadmin/data/model/photographer_booking_model.dart';
import 'package:wavenadmin/data/model/photographer_detail_model.dart';
import 'package:wavenadmin/data/model/photographer_payment_model.dart';
import 'package:wavenadmin/data/model/package_detail_model.dart';
import 'package:wavenadmin/data/model/package_dropdown_model.dart';
import 'package:wavenadmin/data/model/package_list_model.dart';
import 'package:wavenadmin/data/model/porto_list_model.dart';
import 'package:wavenadmin/data/model/schedule_model.dart';
import 'package:wavenadmin/data/model/send_whatsapp_request_model.dart';
import 'package:wavenadmin/data/model/universitas_list_model.dart';
import 'package:wavenadmin/data/model/update_user_request_model.dart';
import 'package:wavenadmin/data/model/university_detail_model.dart';
import 'package:wavenadmin/data/model/university_dropdown_model.dart';
import 'package:wavenadmin/data/model/create_transaction_request_model.dart';
import 'package:wavenadmin/data/model/update_booking_request_model.dart';
import 'package:wavenadmin/data/model/upload_photo_request_model.dart';
import 'package:wavenadmin/data/model/verify_batch_booking_model.dart';
import 'package:wavenadmin/data/model/verify_booking_request_model.dart';
import 'package:wavenadmin/data/model/user_photographer_dropdown.dart';
import 'package:wavenadmin/data/model/tokenmode.dart';
import 'package:wavenadmin/data/model/user_admin_model.dart';
import 'package:wavenadmin/data/model/user_detial_fotografer_model.dart';
import 'package:wavenadmin/data/model/user_detial_model.dart';
import 'package:wavenadmin/data/model/user_photographer_model.dart';
import 'package:wavenadmin/data/model/usermodel.dart';
import 'package:wavenadmin/domain/entity/university_detail.dart';

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
  Future<UniversitasListModel> getListUniversitas(int page,int limit,{String? search,Sort? sort});
  Future<ScheduleModel> getListSchedule(int month,int year,{VerificationStatus? status});
  Future<UserFotograferListResponse> getListPhotographer(int page, int limit, {String? search,Sort? sort,SortPhotographer?  sortBy});
  Future<BookingListResponse> getListBooking(int page, int limit, {String? search, Sort? sort, SortBooking? sortBy});
  Future<ListAddonsResponse> getListAddons(int page, int limit, {String? search});
  Future<AddonDetailResponse> getAddonDetail(String addonId);
  Future<String> updateAddon(String addonId, UpdateAddonRequest request);
  Future<CreateAddonResponse> createAddon(CreateAddonRequest request);
  Future<DeleteAddonResponse> deleteAddon(String addonId);
  Future<AddonsDropdownResponse> getAddonsDropdown(int page, int limit, {String? search});
  Future<PackageDropdownResponse> getPackageDropdown(int page, int limit, {String? search});
  Future<PackageDetailResponse> getPackageDetail(String packageId);
  Future<PackageListModel> getPackageList(int page, int limit, {String? search, Sort? sort, bool? status});
  Future<UniversityDropdownResponse> getUniversityDropdown(int page, int limit, {String? search});
  Future<PhotographerDropdownResponse> getPhotographerDropdown(int page, int limit, {String? search});
  Future<UserDetailResponse> getDetailUser(String idUser);
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
  Future<UserDetailFotograferResponse> getDetailUserFotografer(String idUser);
  Future<AdminDetailResponse> getUserAdminDetail(String id);
  Future<String> putDetailAdmin(AdminDetailModel payload,String idAdmin);
  Future<String> putDetailFotografer(UserDetailFotograferModel payload,String idFotografer);
  Future<String> createAdmin(AdminDetailModel payload);
  Future<String> createUniv(UniversityDetail payload);
  Future<String> createFotografer(CreateFotograferRequest payload);
  Future<void> deleteAdmin(String idAdmin);
  Future<void> deleteUniv(String idUniv);
  Future<String> deleteFotografer(String idFotografer);
  Future<SendWhatsappResponse> sendWhatsappMessage(String target, String message);
  Future<UpdateUserResponse> updateUser(String userId, UpdateUserRequest request);
  Future<UniversityDetailResponse> getDetailUniversity(String universityId);
  Future<UpdateUniversityResponse> updateUniversity(String universityId, UpdateUniversityRequest request);
  Future<String>updatePackage(Uint8List gambar,PackageDetailData packageDetail,String idPackage);
  Future<CreatePackageResponse> createPackage(CreatePackageRequest request, Uint8List imageFile);
  Future<DeletePackageResponse> deletePackage(String packageId);
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
  Future<PengaturanModel> getPengaturan();
  Future<PengaturanModel> updatePengaturan(bool isActive);
  Future<DashboardResponse> getDashboard();
  Future<String> deleteUser(String userId);
  Future<DeleteBatchUserResponse> deleteBatchUser(List<String> userIds);
  Future<PortoListResponse> getListPorto(String packageId);
  Future<String> deletePorto(String portoId);
  Future<String> addPorto(XFile image,String packageId);
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
      final uri = Uri.parse('${baseurl}v1/admin/auth/login');
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
      throw AppException(_friendlyErrorMessage(e));
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
        if(search!=null)'search':search,
        'status':"all"
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
  Future<AddonDetailResponse> getAddonDetail(String addonId) async {
    try {
      final response = await dio.dio.get('v1/admin/addons/$addonId');
      if (response.statusCode != 200) {
        throw AppException(response.data['message']);
      }
      return AddonDetailResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }

  @override
  Future<String> updateAddon(String addonId, UpdateAddonRequest request) async {
    try {
      final response = await dio.dio.put(
        'v1/admin/addons/$addonId',
        data: request.toJson(),
      );
      if (response.statusCode != 200) {
        throw AppException(response.data['message']);
      }
      return response.data['message'];
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }

  @override
  Future<CreateAddonResponse> createAddon(CreateAddonRequest request) async {
    try {
      final response = await dio.dio.post(
        'v1/admin/addons',
        data: request.toJson(),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AppException(response.data['message']);
      }
      return CreateAddonResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }

  @override
  Future<DeleteAddonResponse> deleteAddon(String addonId) async {
    try {
      final response = await dio.dio.delete('v1/admin/addons/$addonId');
      if (response.statusCode != 200) {
        throw AppException(response.data['message']);
      }
      return DeleteAddonResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<AddonsDropdownResponse> getAddonsDropdown(int page, int limit, {String? search}) async {
    try {
      final response = await dio.dio.get('v1/admin/addons/dropdown',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
        });
      if (response.statusCode != 200) {
        throw AppException(response.statusCode.toString());
      }
      return AddonsDropdownResponse.fromJson(response.data);
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
  Future<PackageListModel> getPackageList(int page, int limit, {String? search, Sort? sort, bool? status}) async {
    try {
      final response = await dio.dio.get('v1/admin/packages',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null && search.isNotEmpty) 'search': search,
          if (sort != null) 'sort': sort.name,
          if (status != null) 'status': status,
        });
      if (response.statusCode != 200) {
        throw AppException(response.statusCode.toString());
      }
      return PackageListModel.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<UniversityDropdownResponse> getUniversityDropdown(int page, int limit, {String? search}) async {
    try {
      final response = await dio.dio.get('v1/admin/master/universities/dropdown',
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

  @override
  Future<SendWhatsappResponse> sendWhatsappMessage(String target, String message) async {
    try {
      final request = SendWhatsappRequest(target: target, message: message);
      final response = await dio.dio.post(
        'v1/admin/whatsapp/send-message',
        data: request.toJson(),
      );
      
      return SendWhatsappResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }

  @override
  Future<UpdateUserResponse> updateUser(String userId, UpdateUserRequest request) async {
    try {
      final response = await dio.dio.put(
        'v1/admin/users/$userId',
        data: request.toJson(),
      );
      
      return UpdateUserResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<UniversityDetailResponse> getDetailUniversity(String universityId) async {
    try {
      final response = await dio.dio.get('v1/admin/master/universities/$universityId');
      return UniversityDetailResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }

  @override
  Future<UpdateUniversityResponse> updateUniversity(String universityId, UpdateUniversityRequest request) async {
    try {
      final response = await dio.dio.put(
        'v1/admin/master/universities/$universityId',
        data: request.toJson(),
      );
      return UpdateUniversityResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<UniversitasListModel> getListUniversitas(int page, int limit, {String? search, Sort? sort})async {
    try {
      final  response = await dio.dio.get("v1/admin/master/universities",queryParameters: {
        'page':page,
        'limit':limit,
        if(search!=null)'search':search,
        if(sort!=null)'sort':sort
      });
      if(response.statusCode!=200){
        throw AppException(response.statusCode.toString());
      }
      return UniversitasListModel.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<String> createUniv(UniversityDetail payload) async{
    try {
      final response = await dio.dio.post('v1/admin/master/universities',data: {
        'name':payload.name,
        'brief_name':payload.briefName,
        'address':payload.address
      });
      if(response.statusCode!=201){
        throw AppException(response.statusCode.toString());
      }
      return response.data['message'];
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<void> deleteUniv(String idUniv) async{
    try {
      final response = await dio.dio.delete('v1/admin/master/universities/$idUniv');
      if(response.statusCode!=200){
        throw AppException(response.statusCode.toString());
      }
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<ScheduleModel> getListSchedule(int month,int year,{VerificationStatus? status}) async{
    try {
      final response = await dio.dio.get("v1/admin/bookings/calendar",queryParameters: {
        'month':month,
        'year':year,
        if(status!=null)'status':status.name
      });
      return ScheduleModel.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<String> updatePackage(Uint8List gambar,PackageDetailData payload,String idPackage) async{
    try {
      final formMap = FormData();

    formMap.fields.add(MapEntry("data", jsonEncode({
      'title':payload.title,
      'description':payload.description,
      'price':payload.price,
      'is_active':payload.isActive,
      'benefits':payload.benefits
    })));
    formMap.files.add(
      MapEntry('image', MultipartFile.fromBytes(gambar, filename: "image.png")),
    );

    final response = await dio.dio.put('v1/admin/packages/$idPackage',data: formMap);
    if(response.statusCode!=200){
      throw AppException(response.data['message']);
    }
    return response.data['message'];
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<CreatePackageResponse> createPackage(CreatePackageRequest request, Uint8List imageFile) async {
    try {
      final formMap = FormData();
      
      formMap.fields.add(MapEntry("data", jsonEncode(request.toJson())));
      formMap.files.add(
        MapEntry('image', MultipartFile.fromBytes(imageFile, filename: "image.png")),
      );
      
      final response = await dio.dio.post('v1/admin/packages', data: formMap);
      if (response.statusCode != 201) {
        throw AppException(response.data['message']);
      }
      return CreatePackageResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<DeletePackageResponse> deletePackage(String packageId) async {
    try {
      final response = await dio.dio.delete('v1/admin/packages/$packageId');
      if (response.statusCode != 200) {
        throw AppException(response.statusCode.toString());
      }
      return DeletePackageResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }

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
    try {
      final Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      if (startTime != null) {
        queryParams['start_time'] = startTime.toIso8601String().split('T')[0];
      }

      if (endTime != null) {
        queryParams['end_time'] = endTime.toIso8601String().split('T')[0];
      }

      if (sortBy != null) {
        queryParams['sort_by'] = sortBy;
      }

      if (sort != null) {
        queryParams['sort'] = sort == Sort.asc ? 'asc' : 'desc';
      }

      final response = await dio.dio.get(
        'v1/admin/photographers/payment-info',
        queryParameters: queryParams,
      );

      if (response.statusCode != 200) {
        throw AppException(response.statusCode.toString());
      }

      return PhotographerPaymentResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }

  @override
  Future<PhotographerDetailResponse> getPhotographerDetail(String id) async {
    try {
      final response = await dio.dio.get(
        'v1/admin/photographers/$id/payment-info',
      );

      if (response.statusCode != 200) {
        throw AppException(response.statusCode.toString());
      }

      return PhotographerDetailResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
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
    try {
      final Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      if (startTime != null) {
        queryParams['start_time'] = startTime.toIso8601String().split('T')[0];
      }

      if (endTime != null) {
        queryParams['end_time'] = endTime.toIso8601String().split('T')[0];
      }

      final response = await dio.dio.get(
        'v1/admin/photographers/$photographerId/bookings',
        queryParameters: queryParams,
      );

      if (response.statusCode != 200) {
        throw AppException(response.statusCode.toString());
      }

      return PhotographerBookingResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<PengaturanModel> getPengaturan() async{
    
    try {
      final response = await dio.dio.get('v1/admin/master/payment-gateway/status');
      if(response.statusCode != 200){
        throw AppException(response.data['message']);
      }
      return PengaturanModel.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }

  @override
  Future<PengaturanModel> updatePengaturan(bool isActive) async {
    try {
      final response = await dio.dio.patch(
        'v1/admin/master/payment-gateway/status',
        data: {'is_active': isActive},
      );
      Logger().d(response.data);
      if (response.statusCode != 200) {
        throw AppException(response.data['message']);
      }
      return PengaturanModel.fromJson(response.data);
    } catch (e) {
      Logger().e(e);
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<String> createFotografer(CreateFotograferRequest payload) async{
    try {
      final response = await dio.dio.post("v1/admin/photographers",data: payload.toJson());
      return response.data['message'];
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<DashboardResponse> getDashboard() async{
    try {
      final response = await dio.dio.get('v1/admin/dashboard');
      if(response.statusCode!=200){
        throw AppException(response.data['message']);
      }
      return DashboardResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
    
  }

  @override
  Future<String> deleteUser(String userId) async {
    try {
      final response = await dio.dio.delete('v1/admin/users/$userId');
      if (response.statusCode != 200) {
        throw AppException('Failed to delete user');
      }
      final data = response.data;
      if (data is Map && data['message'] is String) {
        return data['message'] as String;
      }
      return 'User deleted successfully';
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }

  @override
  Future<DeleteBatchUserResponse> deleteBatchUser(List<String> userIds) async {
    try {
      final request = DeleteBatchUserRequest(ids: userIds);
      final response = await dio.dio.delete(
        'v1/admin/users/delete-batch',
        data: request.toJson(),
      );
      if (response.statusCode != 200) {
        throw AppException('Failed to delete batch users');
      }
      return DeleteBatchUserResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<String> addPorto(XFile image,String packageId) async{
    try {
      final formData = FormData();
      final List<int> imageData = await image.readAsBytes();
      formData.files.add(MapEntry(
        "image", MultipartFile.fromBytes(imageData, filename: "image.png")));

      formData.fields.add(MapEntry("data", jsonEncode({
        'package_id':packageId
      })));
      final response = await dio.dio.post("v1/admin/master/portfolios",data: formData);
      if(response.statusCode!=201){
        throw AppException(response.data['message']);
      }
      return response.data['message'];
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<String> deletePorto(String portoId) async{
    try {
      final response = await dio.dio.delete("v1/admin/master/portfolios/$portoId");
      if(response.statusCode!=200){
        throw AppException(response.data['message']);
      }
      return response.data['message'];
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<PortoListResponse> getListPorto(String packageId) async{
    try {
      final response = await dio.dio.get("v1/admin/master/portfolios",queryParameters: {
        'package':packageId
      });
      if(response.statusCode!=200){
        throw AppException(response.data['message']);
      }
      return PortoListResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(_friendlyErrorMessage(e));
    }
  }
}
