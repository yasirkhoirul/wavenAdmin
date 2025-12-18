import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalData {
  Future<bool> saveToken(String accestoken, String refreshtoken);
  Future<String?> getAccesToken();
  Future<String?> getRefreshToken();
  Future<bool> deleteToken();
}

class LocalDataImpl implements LocalData {
  final FlutterSecureStorage storage;
  const LocalDataImpl(this.storage);
  @override
  Future<bool> saveToken(String accestoken, String refreshtoken) async {
    try {
      await storage.write(key: 'acces_token', value: accestoken);
      await storage.write(key: 'refresh_token', value: refreshtoken);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteToken() async {
    try {
      await storage.deleteAll();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String?> getAccesToken() async {
    try {
      final data = await storage.read(key: "acces_token");
      if (data != null) {
        return data;
      }else{
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      final  data = await storage.read(key: "refresh_token");
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
