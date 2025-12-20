import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/user_fotografer.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class GetListPhotographer {
  final UserRepositoty userRepositoty;
  const GetListPhotographer(this.userRepositoty);

  Future<UserFotograferWrap> execute(int page, int limit ,{String? search , Sort? sort,SortPhotographer? sortBy})async{
    return userRepositoty.getListPhotographer(page, limit,search: search,sort: sort,sortBy: sortBy);
  }
}