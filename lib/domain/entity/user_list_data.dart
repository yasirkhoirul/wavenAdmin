import 'package:wavenadmin/data/model/usermodel.dart';
import 'package:wavenadmin/domain/entity/user.dart';

class UserDataWrapperEntity{
  final UserListData dataUser;
  final Metadata? metadata;
  const UserDataWrapperEntity(this.dataUser,this.metadata);
}


class UserListData {
  final int totalUser;
  final int activeUser;
  final List<User> users;

  const UserListData(this.totalUser, this.activeUser, this.users);
}
