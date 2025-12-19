import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class DeleteAdmin {
  final UserRepositoty userRepositoty;
  const DeleteAdmin(this.userRepositoty);

  Future<void> execute(String idAdmin)async{
    return userRepositoty.deleteAdmin(idAdmin);
  }
}