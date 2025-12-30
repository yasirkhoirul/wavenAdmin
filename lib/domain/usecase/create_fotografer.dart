import 'package:wavenadmin/domain/entity/user_fotografer.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class CreateFotografer {
  final UserRepositoty userRepositoty;
  const CreateFotografer(this.userRepositoty);

  Future<String> execute(UserFotografer data,String username,String password,String email)async{
    return userRepositoty.createFotografer(data, username, password, email);
  }
}