import 'package:wavenadmin/domain/entity/detailAdmin.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class GetDetailAdmin {
  final UserRepositoty userRepositoty;
  const GetDetailAdmin(this.userRepositoty);

  Future<DetailAdmin> execute(String idAdmin)async{
    return userRepositoty.getDetailAdmin(idAdmin);
  }
}