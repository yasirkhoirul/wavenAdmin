import 'package:flutter_riverpod/legacy.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/usecase/get_list_admin.dart';
import 'package:wavenadmin/persentation/riverpod/state/admin_list_state.dart';

class AdminListNotifier extends StateNotifier<AdminListState> {
  final GetListAdmin getListAdmin;
  AdminListNotifier( {required this.getListAdmin}) : super(AdminListState());

  void getListAdminData(int page, int limit, {String? search, Sort? sort}) async {
    state = state.copyWith(requestState: RequestState.loading);
    try {
      final responseData = await getListAdmin.execute(
        page+1,
        limit,
        search: search,
        sort: sort,
      );
      state = state.copyWith(requestState: RequestState.succes,listAdmin: responseData,isReachedLastPage: responseData.length<limit);
    } catch (e) {
      state = state.copyWith(
        requestState:  RequestState.error
      );
    }
  }

  void appendAdminData(int page, int limit, {String? search, Sort? sort})async{
    if(state.isReachedLastpage)return;
    if(state.highestPage>=page)return;
    state = state.copyWith(requestState:  RequestState.loading);
    try {
      
      state = state.copyWith(heighestPage: page);
      final responseAppendData = await getListAdmin.execute(state.highestPage+1, limit,search: search,sort: sort);
      state = state.appendData(responseAppendData,responseAppendData.length<limit);
    } catch (e) {
      state = state.copyWith(requestState: RequestState.error);
    }
  }
}
