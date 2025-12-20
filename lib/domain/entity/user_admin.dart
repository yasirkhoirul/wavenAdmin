import 'package:wavenadmin/data/model/usermodel.dart';
import 'package:wavenadmin/domain/entity/user.dart';

class UserAdminWrapper {
  final Metadata? metadata;
  final List<User> users;

  const UserAdminWrapper({
    required this.metadata,
    required this.users,
  });
}