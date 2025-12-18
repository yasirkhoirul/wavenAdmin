import 'package:wavenadmin/data/datasource/local_data.dart';
import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/domain/repository/auth_repository.dart';

class AuthRepositoryimpl implements AuthRepository{
    final RemoteData remoteData;
    final LocalData localData;
    const AuthRepositoryimpl(this.remoteData, {required this.localData});
  @override
  Future<String> postLogin(String username, String password) async{
    try {
      final response = await remoteData.login(username, password);
      final simpantoken = await localData.saveToken(response.accesToken, response.refreshToken);
      if (simpantoken) {
        return "berhasil";
      }else{
        throw Exception("gagal simpan");
      }
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<String?> getTokenAcces() async{
    try {
      final tokenacces = await localData.getAccesToken();
      return tokenacces;
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<String?> getTokenRefresh()async {
   try {
      final tokenRefresh = await localData.getRefreshToken();
      return tokenRefresh;
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<void> postLogout() async{
    try {
      final refreshtoken = await localData.getRefreshToken();
      final response = await remoteData.logout(refreshtoken??'');
      if(response == false){
        throw "gagal logout";
      }
      await localData.deleteToken();
    } catch (e) {
      rethrow;
    }
  }

}