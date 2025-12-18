import 'package:wavenadmin/domain/repository/auth_repository.dart';

class PostLogin {

  final AuthRepository authRepository;
  const PostLogin(this.authRepository);

  Future<String> execute(String username,String password)async{
    return authRepository.postLogin(username, password);
  }
}