import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/detailAdmin.dart';
import 'package:wavenadmin/domain/entity/user.dart';

abstract class UserRepositoty {
  Future<List<User>> getListUser(int page, int limit, {String? search,Sort? sort});
  Future<List<User>> getListUserAdmin(int page, int limit, {String? search,Sort? sort});
  Future<DetailAdmin> getDetailAdmin(String idAdmin);
}