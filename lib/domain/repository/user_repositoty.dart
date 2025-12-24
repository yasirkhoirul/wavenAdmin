import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/detail_admin.dart';
import 'package:wavenadmin/domain/entity/detail_fotografer.dart';
import 'package:wavenadmin/domain/entity/detail_user.dart';
import 'package:wavenadmin/domain/entity/photographer_dropdown.dart';
import 'package:wavenadmin/domain/entity/user_admin.dart';
import 'package:wavenadmin/domain/entity/user_fotografer.dart';
import 'package:wavenadmin/domain/entity/user_list_data.dart';

abstract class UserRepositoty {
  Future<UserDataWrapperEntity> getListUser(int page, int limit, {String? search,Sort? sort,SortUser? sortBy});
  Future<PhotographerDropdown> getPhotographerDropdown(int page, int limit, {String? search});
  Future<UserFotograferWrap> getListPhotographer(int page, int limit, {String? search,Sort? sort,SortPhotographer? sortBy});
  Future<UserAdminWrapper> getListUserAdmin(int page, int limit, {String? search,Sort? sort,SortAdmin? sortAdmin});
  Future<DetailUser> getDetailUser(String idUser);
  Future<DetailFotografer> getDetailFotografer(String idFotografer);
  Future<DetailAdmin> getDetailAdmin(String idAdmin);
  Future<String> putDetailAdmin(DetailAdmin payload, String idAdmin);
  Future<String> putDetailFotografer(DetailFotografer payload, String idFotografer);
  Future<String> createAdmin(DetailAdmin payload);
  Future<void> deleteAdmin(String idAdmin);
  Future<String> deleteFotografer(String idFotografer);
}