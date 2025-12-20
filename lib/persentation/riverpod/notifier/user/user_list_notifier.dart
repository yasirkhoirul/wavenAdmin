import 'package:flutter_riverpod/legacy.dart';
import 'package:wavenadmin/common/constant.dart'; 
import 'package:wavenadmin/domain/usecase/get_list_user.dart';
import 'package:wavenadmin/injection.dart';
import 'package:wavenadmin/persentation/riverpod/state/user_list_state.dart';

final userGetListProvider =
    StateNotifierProvider<UserListNotifier, UserListState>(
      (ref) => locator<UserListNotifier>(),
    );

class UserListNotifier extends StateNotifier<UserListState> {
  final GetListUser getListUser;
  UserListNotifier(this.getListUser) : super(UserListState());

  Future<void> getListUsers(int limit, {String? search,Sort? sort,SortUser? sortBy})async{
    state = state.copyWith(isloading: true);
    try {
      final response = await getListUser.execute(1, limit,search: search,sort: sort,sortBy: sortBy);
      state = state.copyWith(
        highestPage: 0,
        currentPage: 0,
        isloading: false,
        userData: response.dataUser.users,
        totaldata: response.dataUser.totalUser,
        metadata: response.metadata,
        error: null
      );
    } catch (e) {
      state = state.copyWith(
        isloading: false,
        error: e.toString()
      );
    }
  }
  
  void back(){
    if(state.currentpage<=0)return;
    state = state.copyWith(currentPage: state.currentpage-1);
  }

  Future<void> appendData( int limit, {String? search,Sort? sort,SortUser? sortBy})async{
    if(state.isloading == true||state.currentpage>state.highestpage)return;
    state = state.copyWith(currentPage: state.currentpage+1);
    if(state.currentpage<=state.highestpage)return;
    if(state.isreached == true)return;
    state = state.copyWith(isloading: true);
    try {
      state = state.copyWith(highestPage: state.currentpage);
      final response = await getListUser.execute(state.highestpage+1, limit,search: search,sort: sort,sortBy: sortBy);
      if (response.dataUser.users.length<limit) {
        state = state.copyWith(
          isloading: false,
          isreached: true
        );
      }
      state = state.appendData(
        userData: response.dataUser.users,
      );
    } catch (e) {
      state = state.copyWith(
        isloading: false,
        error: e.toString()
      );
    }
  }
 

}