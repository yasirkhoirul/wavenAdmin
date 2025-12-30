import 'package:wavenadmin/data/datasource/file_mover_local_data_source.dart';
import 'package:wavenadmin/domain/entity/file_mover_history.dart';
import 'package:wavenadmin/domain/repository/file_mover_repository.dart';

class FileMoverRepositoryImpl implements FileMoverRepository {
  final FileMoverLocalDataSource localDataSource;

  FileMoverRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveHistory(FileMoverHistory history) async {
    return await localDataSource.saveHistory(history);
  }

  @override
  Future<List<FileMoverHistory>> getHistories() async {
    return await localDataSource.getHistories();
  }

  @override
  Future<void> clearHistory() async {
    return await localDataSource.clearHistory();
  }
}
