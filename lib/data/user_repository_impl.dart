import 'package:logger/web.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/data/model/admin_detail_model.dart';
import 'package:wavenadmin/domain/entity/detailAdmin.dart';
import 'package:wavenadmin/domain/entity/detailUser.dart';
import 'package:wavenadmin/domain/entity/user.dart';
import 'package:wavenadmin/domain/entity/user_list_data.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class UserRepositoryImpl implements UserRepositoty {
  final RemoteData remoteData;
  const UserRepositoryImpl(this.remoteData);

  @override
  Future<UserListData> getListUser(int page, int limit, {String? search, Sort? sort}) async{
    try {
      final responsedata = await remoteData.getListUser(page, limit,search: search,sort: sort);
      final data =  responsedata.data?.toEntityData()??UserListData(0, 0, []);
      return data;
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
  
  @override
  Future<String> putDetailAdmin(DetailAdmin payload, String idAdmin) async{
    final responseData = await remoteData.putDetailAdmin(AdminDetailModel.fromEntity(payload), idAdmin);
    return responseData;
  }
  
  @override
  Future<String> createAdmin(DetailAdmin payload) async{
    final responseData = await remoteData.createAdmin(AdminDetailModel.fromEntity(payload));
    return responseData;
  }
  @override
  Future<void> deleteAdmin(String idAdmin) async{
    await remoteData.deleteAdmin(idAdmin);
    
  }

  @override
  Future<DetailUser> getDetailUser(String idUser) async{
    final data = await remoteData.getDetailUser(idUser);
    return data.data.toEntity();
  }


}