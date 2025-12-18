import 'package:logger/web.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/domain/entity/detailAdmin.dart';
import 'package:wavenadmin/domain/entity/user.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class UserRepositoryImpl implements UserRepositoty {
  final RemoteData remoteData;
  const UserRepositoryImpl(this.remoteData);

  @override
  Future<List<User>> getListUser(int page, int limit, {String? search, Sort? sort}) async{
    try {
      final responsedata = await remoteData.getListUser(page, limit,search: search,sort: sort);
      Logger().d("ini adalah data model $responsedata");
      return responsedata.data?.listUser.map((e) => e.toEntity(),).toList()??[];
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<List<User>> getListUserAdmin(int page, int limit, {String? search, Sort? sort}) async{
    try {
      final responseData = await remoteData.getListUserAdmin(page, limit,search: search,sort: sort);
      return responseData.data?.listUser.map((e) => e.toEntity(),).toList()??[];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DetailAdmin> getDetailAdmin(String idAdmin) async{
    try {
      final response = await remoteData.getUserAdminDetail(idAdmin);
      return response.data.toEntity();
    } catch (e) {
      rethrow;
    }
  }


}