import 'package:wavenadmin/data/datasource/pengaturan_remote_data_source.dart';
import 'package:wavenadmin/domain/entity/pnegaturan.dart';
import 'package:wavenadmin/domain/repository/pengaturan_repository.dart';

class PengaturanRepositoryImpl implements PengaturanRepository {
  final PengaturanRemoteDataSource remoteData;

  const PengaturanRepositoryImpl(this.remoteData);
  @override
  Future<Pengaturan> getPengaturan() async{
    final response = await remoteData.getPengaturan();
    return response.data.toEntity();
  }

  @override
  Future<Pengaturan> updatePengaturan(bool isActive) async {
    final response = await remoteData.updatePengaturan(isActive);
    return response.data.toEntity();
  }

}
