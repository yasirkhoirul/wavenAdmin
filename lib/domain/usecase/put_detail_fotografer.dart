import 'package:wavenadmin/domain/entity/detail_fotografer.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class PutDetailFotografer {
  final UserRepositoty userRepositoty;
  const PutDetailFotografer(this.userRepositoty);

  Future<String> execute(DetailFotografer payload,String idFotografer)async{
    return userRepositoty.putDetailFotografer(payload, idFotografer);
  }
}