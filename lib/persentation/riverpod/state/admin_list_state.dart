import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/user.dart';

class AdminListState {
  final List<User> listAdmin;
  final bool isReachedLastpage;
  final RequestState requestState;
  final int highestPage;
  const AdminListState({
    this.listAdmin = const [],
    this.isReachedLastpage = false,
    this.requestState = RequestState.init,this.highestPage =0,
  });

  AdminListState copyWith(
    {List<User>? listAdmin,
    bool? isReachedLastPage,
    RequestState? requestState,
    int? heighestPage
    }
  ) {
    return AdminListState(
      isReachedLastpage: isReachedLastPage ?? isReachedLastpage,
      listAdmin: listAdmin ?? this.listAdmin,
      requestState: requestState ?? this.requestState,
      highestPage: heighestPage??highestPage
    );
  }

  AdminListState appendData(List<User>? listAdmin,bool isReachedLastPage){
    return copyWith(listAdmin: [...this.listAdmin,...listAdmin??[]],isReachedLastPage: isReachedLastPage,requestState: RequestState.succes);
  }
}
