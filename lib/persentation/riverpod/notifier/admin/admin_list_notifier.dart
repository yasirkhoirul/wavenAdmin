import 'package:flutter_riverpod/legacy.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/usecase/get_list_admin.dart';
import 'package:wavenadmin/injection.dart';
import 'package:wavenadmin/persentation/riverpod/state/admin_list_state.dart';

final userAdminGetListProvider =
    StateNotifierProvider<AdminListNotifier, AdminListState>(
      (ref) => locator<AdminListNotifier>(),
    );




class AdminListNotifier extends StateNotifier<AdminListState> {
  final GetListAdmin getListAdmin;
  AdminListNotifier( {required this.getListAdmin}) : super(AdminListState());

  void getListAdminData( int limit, {String? search, Sort? sort,SortAdmin? sortAdmin}) async {
    state = state.copyWith(requestState: RequestState.loading);
    try {
      
      final responseData = await getListAdmin.execute(
        1,
        limit,
        search: search,
        sort: sort,
        sortAdmin: sortAdmin
      );
      state = state.copyWith(requestState: RequestState.succes,listAdmin: responseData.users,isReachedLastPage: responseData.users.length<limit,metadaa: responseData.metadata,currentPage: 0,heighestPage: 0);
    } catch (e) {
      Logger().e(e);
      state = state.copyWith(
        requestState:  RequestState.error
      );
    }
  }
  void back(){
    if(state.currentpage! <= 0 )return;
    state = state.copyWith(
      currentPage: state.currentpage! -1
    );
  }

  void appendAdminData( int limit, {String? search, Sort? sort,SortAdmin? sortAdmin})async{
    if(state.requestState == RequestState.loading)return;
    if(state.highestPage<state.currentpage!)return;
    state = state.copyWith(currentPage: state.currentpage!+1);
    if(state.currentpage!<=state.highestPage)return;
    if(state.isReachedLastpage)return;
    state = state.copyWith(requestState:  RequestState.loading);
    try {
      
      state = state.copyWith(heighestPage: state.currentpage);
      final responseAppendData = await getListAdmin.execute(state.highestPage+1, limit,search: search,sort: sort,sortAdmin: sortAdmin);
      state = state.appendData(responseAppendData.users,responseAppendData.users.length<limit);
    } catch (e) {
      state = state.copyWith(requestState: RequestState.error,);
    }
  }
}
