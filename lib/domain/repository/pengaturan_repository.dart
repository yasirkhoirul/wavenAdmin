import 'package:wavenadmin/domain/entity/pnegaturan.dart';

abstract class PengaturanRepository {
  Future<Pengaturan> getPengaturan();
  Future<Pengaturan> updatePengaturan(bool isActive);
}