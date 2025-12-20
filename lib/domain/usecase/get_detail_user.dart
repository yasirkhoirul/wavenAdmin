import 'package:wavenadmin/domain/entity/detail_user.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class GetDetailUser {
  final UserRepositoty userRepositoty;
  const GetDetailUser(this.userRepositoty);

  Future<DetailUser> execute(String idUser)async{
    return userRepositoty.getDetailUser(idUser);
  }
}