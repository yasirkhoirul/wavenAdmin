import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class DeleteFotografer {
  final UserRepositoty userRepositoty;
  const DeleteFotografer(this.userRepositoty);

  Future<String> execute(String idFotografer)async{
    return userRepositoty.deleteFotografer(idFotografer);
  }
}