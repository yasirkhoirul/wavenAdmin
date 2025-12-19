import 'package:wavenadmin/domain/entity/user.dart';

class UserListState {
  final List<User>? userData;
  final int? totaldata;
  final bool isreached;
  final bool? isloading;
  final String? error;

  UserListState( {this.totaldata,this.userData, this.isloading, this.error, this.isreached = false});

  UserListState copyWith({List<User>? userData, bool? isloading, String? error,bool? isreached,int? totaldata}) {
    return UserListState(
      userData: userData ?? this.userData,
      isloading: isloading ?? this.isloading,
      isreached: isreached??this.isreached,
      totaldata: totaldata??this.totaldata,
      error: error,
    );
  }

  UserListState appendData({List<User>? userData, bool? isloading, String? error,bool? isReached}){
    return copyWith(
      userData: [...this.userData??[],...userData??[]],
      isloading: false,
    );
  }
}
