import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/user_list_data.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class GetListUser {
  final UserRepositoty userRepositoty;
  const GetListUser(this.userRepositoty);

  Future<UserDataWrapperEntity> execute(int page, int limit, {String? search,Sort? sort,SortUser? sortBy})async{
    return userRepositoty.getListUser(page, limit,search: search,sort: sort,sortBy: sortBy);
  }
}