import 'package:wavenadmin/domain/entity/detail_admin.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class CreateAdmin {
  final UserRepositoty userRepositoty;
  const CreateAdmin(this.userRepositoty);

  Future<String> execute(DetailAdmin payload)async{
    return userRepositoty.createAdmin(payload);
  }
}