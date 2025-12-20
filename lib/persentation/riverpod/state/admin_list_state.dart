import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/model/usermodel.dart';
import 'package:wavenadmin/domain/entity/user.dart';

class AdminListState {
  final List<User> listAdmin;
  final bool isReachedLastpage;
  final Metadata? metadata;
  final RequestState requestState;
  final int? currentpage;
  final int highestPage;
  const AdminListState({
    this.listAdmin = const [],
    this.isReachedLastpage = false,
    this.requestState = RequestState.init,this.highestPage =0, this.metadata, this.currentpage = 0,
  });

  AdminListState copyWith(
    {List<User>? listAdmin,
    bool? isReachedLastPage,
    RequestState? requestState,
    int? heighestPage,
    int? currentPage,
    Metadata? metadaa
    }
  ) {
    return AdminListState(
      isReachedLastpage: isReachedLastPage ?? isReachedLastpage,
      listAdmin: listAdmin ?? this.listAdmin,
      requestState: requestState ?? this.requestState,
      highestPage: heighestPage??highestPage,
      metadata: metadaa??metadata, currentpage: currentPage??currentpage
    );
  }

  AdminListState appendData(List<User>? listAdmin,bool isReachedLastPage){
    return copyWith(listAdmin: [...this.listAdmin,...listAdmin??[]],isReachedLastPage: isReachedLastPage,requestState: RequestState.succes);
  }
}
