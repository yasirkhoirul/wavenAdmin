
import 'package:wavenadmin/data/model/usermodel.dart';

class UserFotograferWrap{
  final Metadata? metada;
  final List<UserFotografer> listData;
  const UserFotograferWrap({this.metada , required this.listData});
}
class UserFotografer {
  final String id;
  final String name;
  final String? phoneNumber;
  final String? accountNumber;
  final String? bankAccount;
  final int? feePerHour;
  final String? gears;
  final String? instagram;
  final String? location;

  const UserFotografer({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.accountNumber,
    this.bankAccount,
    this.feePerHour,
    this.gears,
    this.instagram,
    this.location,
  });
}