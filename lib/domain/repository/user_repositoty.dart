import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/detailAdmin.dart';
import 'package:wavenadmin/domain/entity/detailUser.dart';
import 'package:wavenadmin/domain/entity/user.dart';
import 'package:wavenadmin/domain/entity/user_list_data.dart';

abstract class UserRepositoty {
  Future<UserListData> getListUser(int page, int limit, {String? search,Sort? sort});
  Future<DetailUser> getDetailUser(String idUser);
  Future<List<User>> getListUserAdmin(int page, int limit, {String? search,Sort? sort});
  Future<DetailAdmin> getDetailAdmin(String idAdmin);
  Future<String> putDetailAdmin(DetailAdmin payload, String idAdmin);
  Future<String> createAdmin(DetailAdmin payload);
  Future<void> deleteAdmin(String idAdmin);
}