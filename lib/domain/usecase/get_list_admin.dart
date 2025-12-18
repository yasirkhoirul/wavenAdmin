import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/user.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class GetListAdmin {
  final UserRepositoty userRepositoty;
  const GetListAdmin(this.userRepositoty);

  Future<List<User>> execute(int page , int limit , {String? search,Sort? sort})async{
    return userRepositoty.getListUserAdmin(page, limit,search: search,sort: sort);
  }
}