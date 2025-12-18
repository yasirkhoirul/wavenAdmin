abstract class AuthRepository {
  Future<String> postLogin(String username,String password);
  Future<String?> getTokenAcces();
  Future<String?> getTokenRefresh();
  Future<void> postLogout();
}