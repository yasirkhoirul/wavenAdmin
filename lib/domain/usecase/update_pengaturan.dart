import 'package:wavenadmin/domain/entity/pnegaturan.dart';
import 'package:wavenadmin/domain/repository/pengaturan_repository.dart';

class UpdatePengaturan {
  final PengaturanRepository pengaturanRepository;
  const UpdatePengaturan(this.pengaturanRepository);

  Future<Pengaturan> execute(bool isActive) async {
    return pengaturanRepository.updatePengaturan(isActive);
  }
}
