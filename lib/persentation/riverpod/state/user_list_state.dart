import 'package:wavenadmin/data/model/usermodel.dart';
import 'package:wavenadmin/domain/entity/user.dart';

class UserListState {
  final List<User>? userData;
  final int? totaldata;
  final Metadata? metadata;
  final bool isreached;
  final int currentpage;
  final int highestpage;
  final bool? isloading;
  final String? error;

  UserListState({
    this.totaldata,
    this.userData,
    this.isloading,
    this.error,
    this.isreached = false,
    this.currentpage = 0,
    this.highestpage = 0, this.metadata,
  });

  UserListState copyWith({
    List<User>? userData,
    bool? isloading,
    String? error,
    bool? isreached,
    int? totaldata,
    int? currentPage,
    int? highestPage,
    Metadata? metadata
  }) {
    return UserListState(
      userData: userData ?? this.userData,
      isloading: isloading ?? this.isloading,
      isreached: isreached ?? this.isreached,
      totaldata: totaldata ?? this.totaldata,
      currentpage: currentPage??currentpage,
      highestpage: highestPage??highestpage,
      metadata: metadata??this.metadata,
      error: error,
    );
  }

  UserListState appendData({
    List<User>? userData,
    bool? isloading,
    String? error,
    bool? isReached,
  }) {
    return copyWith(
      userData: [...this.userData ?? [], ...userData ?? []],
      isloading: false,
    );
  }
}
