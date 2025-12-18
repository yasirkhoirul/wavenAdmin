import 'package:wavenadmin/domain/entity/user.dart';

class UserListState {
  final List<User>? userData;
  final bool isreached;
  final bool? isloading;
  final String? error;

  UserListState({this.userData, this.isloading, this.error, this.isreached = false});

  UserListState copyWith({List<User>? userData, bool? isloading, String? error,bool? isreached}) {
    return UserListState(
      userData: userData ?? this.userData,
      isloading: isloading ?? this.isloading,
      isreached: isreached??this.isreached,
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
