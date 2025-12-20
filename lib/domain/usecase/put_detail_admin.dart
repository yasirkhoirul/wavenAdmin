import 'package:wavenadmin/domain/entity/detail_admin.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class PutDetailAdmin {
  final UserRepositoty userRepositoty;
  const PutDetailAdmin(this.userRepositoty);
  Future<String> execute(DetailAdmin payload,String idAdmin)async{
    return userRepositoty.putDetailAdmin(payload, idAdmin);
  }
}