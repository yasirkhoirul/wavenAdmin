import 'package:flutter_riverpod/legacy.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/usecase/get_list_user.dart';
import 'package:wavenadmin/persentation/riverpod/state/user_list_state.dart';

class UserListNotifier extends StateNotifier<UserListState> {
  final GetListUser getListUser;
  UserListNotifier(this.getListUser) : super(UserListState());

  Future<void> getListUsers(int page, int limit, {String? search,Sort? sort})async{
    state = state.copyWith(isloading: true);
    try {
      final response = await getListUser.execute(page, limit,search: search,sort: sort);
      state = state.copyWith(
        isloading: false,
        userData: response,
        error: null
      );
    } catch (e) {
      state = state.copyWith(
        isloading: false,
        error: e.toString()
      );
    }
  }
 

  Future<void> appendData(int page, int limit, {String? search,Sort? sort})async{
    if(state.isloading == true)return;
    if(state.isreached == true)return;
    state = state.copyWith(isloading: true);
    try {
      final response = await getListUser.execute(page, limit,search: search,sort: sort);
      if (response.length<limit) {
        state = state.copyWith(
          isloading: false,
          isreached: true
        );
      }
      state = state.appendData(
        userData: response,
      );
    } catch (e) {
      state = state.copyWith(
        isloading: false,
        error: e.toString()
      );
    }
  }
 

}