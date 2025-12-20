import 'package:wavenadmin/domain/entity/detailFotografer.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class GetDetailFotografer {
  final UserRepositoty userRepositoty;
  const GetDetailFotografer(this.userRepositoty);

  Future<DetailFotografer> execute(String idFotografer)async{
    return userRepositoty.getDetailFotografer(idFotografer);
  }
}