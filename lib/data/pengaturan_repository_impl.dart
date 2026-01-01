import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/domain/entity/pnegaturan.dart';
import 'package:wavenadmin/domain/repository/pengaturan_repository.dart';

class PengaturanRepositoryImpl implements PengaturanRepository {
  final RemoteData remoteData;

  const PengaturanRepositoryImpl(this.remoteData);
  @override
  Future<Pengaturan> getPengaturan() async{
    try {
      final response = await remoteData.getPengaturan();
      return response.data.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Pengaturan> updatePengaturan(bool isActive) async {
    try {
      final response = await remoteData.updatePengaturan(isActive);
      return response.data.toEntity();
    } catch (e) {
      rethrow;
    }
  }

}
