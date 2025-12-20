import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/user_admin.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class GetListAdmin {
  final UserRepositoty userRepositoty;
  const GetListAdmin(this.userRepositoty);

  Future<UserAdminWrapper> execute(int page , int limit , {String? search,Sort? sort,SortAdmin? sortAdmin})async{
    return userRepositoty.getListUserAdmin(page, limit,search: search,sort: sort,sortAdmin: sortAdmin);
  }
}