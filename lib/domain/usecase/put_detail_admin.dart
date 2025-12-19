import 'package:wavenadmin/domain/entity/detailAdmin.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class PutDetailAdmin {
  final UserRepositoty userRepositoty;
  const PutDetailAdmin(this.userRepositoty);
  Future<String> execute(DetailAdmin payload,String idAdmin)async{
    return userRepositoty.putDetailAdmin(payload, idAdmin);
  }
}