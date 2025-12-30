import 'package:wavenadmin/domain/entity/file_mover_history.dart';
import 'package:wavenadmin/domain/repository/file_mover_repository.dart';

class SaveFileMoverHistory {
  final FileMoverRepository repository;

  SaveFileMoverHistory(this.repository);

  Future<void> execute(FileMoverHistory history) async {
    return await repository.saveHistory(history);
  }
}
