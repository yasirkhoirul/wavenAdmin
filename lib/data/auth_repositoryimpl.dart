import 'package:wavenadmin/data/datasource/local_data.dart';
import 'package:wavenadmin/data/datasource/auth_remote_data_source.dart';
import 'package:wavenadmin/domain/repository/auth_repository.dart';

class AuthRepositoryimpl implements AuthRepository{
    final AuthRemoteDataSource remoteData;
    final LocalData localData;
    const AuthRepositoryimpl(this.remoteData, {required this.localData});
  @override
  Future<String> postLogin(String username, String password) async{
    final response = await remoteData.login(username, password);
    final simpantoken = await localData.saveToken(response.accesToken, response.refreshToken);
    if (simpantoken) {
      return "berhasil";
    }else{
      throw Exception("gagal simpan");
    }
  }
  
  @override
  Future<String?> getTokenAcces() async{
    final tokenacces = await localData.getAccesToken();
    return tokenacces;
  }
  
  @override
  Future<String?> getTokenRefresh()async {
    final tokenRefresh = await localData.getRefreshToken();
    return tokenRefresh;
  }
  
  @override
  Future<void> postLogout() async{
    final refreshtoken = await localData.getRefreshToken();
    final response = await remoteData.logout(refreshtoken??'');
    if(response == false){
      throw "gagal logout";
    }
    await localData.deleteToken();
  }

}