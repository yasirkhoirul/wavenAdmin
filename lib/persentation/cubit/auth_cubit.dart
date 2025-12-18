import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wavenadmin/domain/usecase/get_token.dart';
import 'package:wavenadmin/domain/usecase/post_login.dart';
import 'package:wavenadmin/domain/usecase/post_logout.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final PostLogin postLogin;
  final PostLogout postLogout;
  final GetToken getToken;
  AuthCubit(this.postLogin, {required this.getToken, required this.postLogout}) : super(AuthInitial());

  void onLogin(String username,String password)async{
    emit(AuthLoading());
    try {
      await postLogin.execute(username, password);
      emit(AuthSucces());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  void checkToken()async{
    final refresh = await getToken.executeRefresh();
    if (refresh!=null) {
      emit(AuthSucces());
    }else{
      emit(AuthLogout());
    }
  }

  void logOut()async{
    try {
      await postLogout.execute();
      emit(AuthLogout());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void onInit(){
    emit(AuthInitial());
  }
}
