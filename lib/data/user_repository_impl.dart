import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/data/model/admin_detail_model.dart';
import 'package:wavenadmin/data/model/user_detial_fotografer_model.dart';
import 'package:wavenadmin/domain/entity/detail_admin.dart';
import 'package:wavenadmin/domain/entity/detail_fotografer.dart';
import 'package:wavenadmin/domain/entity/detail_user.dart';
import 'package:wavenadmin/domain/entity/user_admin.dart';
import 'package:wavenadmin/domain/entity/user_fotografer.dart';
import 'package:wavenadmin/domain/entity/user_list_data.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class UserRepositoryImpl implements UserRepositoty {
  final RemoteData remoteData;
  const UserRepositoryImpl(this.remoteData);

  @override
  Future<UserDataWrapperEntity> getListUser(int page, int limit, {String? search, Sort? sort,SortUser? sortBy}) async{
    try {
      final responsedata = await remoteData.getListUser(page, limit,search: search,sort: sort,sortBy: sortBy);
      final data =  responsedata.toEntity();
      return data;
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<UserAdminWrapper> getListUserAdmin(int page, int limit, {String? search, Sort? sort,SortAdmin? sortAdmin}) async{
    try {
      final responseData = await remoteData.getListUserAdmin(page, limit,search: search,sort: sort,sortAdmin: sortAdmin);
      return responseData.toWrapper();
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
  
  @override
  Future<UserFotograferWrap> getListPhotographer(int page, int limit, {String? search, Sort? sort,SortPhotographer? sortBy}) async{
    final reponse = await remoteData.getListPhotographer(page, limit,search: search,sort: sort,sortBy: sortBy);
    return reponse.toEntity();
  }

  @override
  Future<String> putDetailFotografer(DetailFotografer payload, String idFotografer) async{
    try {
      final response = await remoteData.putDetailFotografer(UserDetailFotograferModel.fromEntity(payload), idFotografer);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<DetailFotografer> getDetailFotografer(String idFotografer) async{
    try {
      final response = await remoteData.getDetailUserFotografer(idFotografer);
      return response.data.toEntity();
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<String> deleteFotografer(String idFotografer) async{
    final response = remoteData.deleteFotografer(idFotografer);
    return response;
  }
  


}