import 'package:wavenadmin/domain/entity/file_mover_history.dart';
import 'package:wavenadmin/domain/repository/file_mover_repository.dart';

class GetFileMoverHistories {
  final FileMoverRepository repository;

  GetFileMoverHistories(this.repository);

  Future<List<FileMoverHistory>> execute() async {
    return await repository.getHistories();
  }
}
