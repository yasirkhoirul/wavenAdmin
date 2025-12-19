import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/dio.dart';
import 'package:wavenadmin/data/model/admin_detail_model.dart';
import 'package:wavenadmin/data/model/tokenmode.dart';
import 'package:wavenadmin/data/model/user_detial_model.dart';
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
  Future<UserListResponse> getListUser(int page, int limit, {String? search,Sort? sort});
  Future<UserDetailResponse> getDetailUser(String idUser);
  Future<UserListResponse> getListUserAdmin(int page, int limit, {String? search,Sort? sort});
  Future<AdminDetailResponse> getUserAdminDetail(String id);
  Future<String> putDetailAdmin(AdminDetailModel payload,String idAdmin);
  Future<String> createAdmin(AdminDetailModel payload);
  Future<void> deleteAdmin(String idAdmin);
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
  Future<UserListResponse> getListUser(int page, int limit, {String? search,Sort? sort}) async{
    try {
      final response = await dio.dio.get('v1/admin/users',queryParameters: {
        'page':page,
        'limit':limit,
        if(search!=null)'search':search,
        if(sort!=null)'sort':sort.name
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
  Future<UserListResponse> getListUserAdmin(int page, int limit, {String? search, Sort? sort}) async{
    try {
      final response = await dio.dio.get('v1/admin/admins',
      queryParameters: {
        'page':page,
        'limit':limit,
        if(search!=null)'search':search,
        if(sort!=null)'sort':sort.name
      });
      if (response.statusCode != 200) {
        throw AppException('Request gagal (HTTP ${response.statusCode}).');
      }
      return UserListResponse.fromJson(response.data);
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
}
