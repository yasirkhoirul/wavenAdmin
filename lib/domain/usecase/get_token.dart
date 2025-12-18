import 'package:wavenadmin/domain/repository/auth_repository.dart';

class GetToken {
  final AuthRepository authRepository;
  const GetToken(this.authRepository);


  Future<String?> executeAcces()async{
    return authRepository.getTokenAcces();
  }

  Future<String?> executeRefresh()async{
    return authRepository.getTokenRefresh();
  }
}