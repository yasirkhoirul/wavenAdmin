import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wavenadmin/common/environment_config.dart';
import 'package:wavenadmin/data/datasource/base/base_remote_data_source.dart';
import 'package:wavenadmin/data/model/tokenmode.dart';

abstract class AuthRemoteDataSource {
  Future<Token> login(String email, String password);
  Future<bool> logout(String refreshToken);
}

class AuthRemoteDataSourceImpl extends BaseRemoteDataSource 
    implements AuthRemoteDataSource {
  final http.Client client;
  
  AuthRemoteDataSourceImpl(super.dio, this.client);

  @override
  Future<Token> login(String email, String password) async {
    try {
      final uri = Uri.parse('${EnvironmentConfig.apiBaseUrl}v1/admin/auth/login');
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
  Future<bool> logout(String refreshToken) async {
    final uri = Uri.parse("${EnvironmentConfig.apiBaseUrl}v1/auth/logout");
    try {
      final response = await client.post(uri,
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'refresh_token': refreshToken
        }));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
