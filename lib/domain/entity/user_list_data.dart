import 'package:wavenadmin/domain/entity/user.dart';

class UserListData {
  final int totalUser;
  final int activeUser;
  final List<User> users;

  const UserListData(this.totalUser, this.activeUser, this.users);
}
