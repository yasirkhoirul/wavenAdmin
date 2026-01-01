import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class DeleteUser {
  final UserRepositoty repository;

  const DeleteUser(this.repository);

  Future<String> execute(String userId) async {
    return await repository.deleteUser(userId);
  }
}
