import 'package:wavenadmin/domain/entity/pnegaturan.dart';
import 'package:wavenadmin/domain/repository/pengaturan_repository.dart';

class GetPengaturan {
  final PengaturanRepository pengaturanRepository;
  const GetPengaturan(this.pengaturanRepository);

  Future<Pengaturan> execute()async{
    return pengaturanRepository.getPengaturan();
  }
}