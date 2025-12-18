import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/dio.dart';
import 'package:wavenadmin/data/model/admin_detail_model.dart';
import 'package:wavenadmin/data/model/tokenmode.dart';
import 'package:wavenadmin/data/model/usermodel.dart';

abstract class RemoteData {
  Future<Token> login(String email, String password);
  Future<bool> logout(String refreshToken);
  Future<UserListResponse> getListUser(int page, int limit, {String? search,Sort? sort});
  Future<UserListResponse> getListUserAdmin(int page, int limit, {String? search,Sort? sort});
  Future<AdminDetailResponse> getUserAdminDetail(String id);
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
        throw response;
      }
      return UserListResponse.fromJson(response.data);
    } catch (e) {
      Logger().d("reponse nya adalah $e");
      throw Exception(e);
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
        throw response;
      }
      return UserListResponse.fromJson(response.data);
    } catch (e) {
      
      throw Exception(e);
    }
  }
  
  @override
  Future<AdminDetailResponse> getUserAdminDetail(String id) async{
    try {
      final response = await dio.dio.get('v1/admin/admins/$id');
      if (response.statusCode == 200) {
        return AdminDetailResponse.fromJson(response.data);
      }else{
        throw AdminDetailResponse.fromJson(response.data).message;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
