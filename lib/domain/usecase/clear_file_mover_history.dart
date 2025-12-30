import 'package:wavenadmin/domain/repository/file_mover_repository.dart';

class ClearFileMoverHistory {
  final FileMoverRepository repository;

  ClearFileMoverHistory(this.repository);

  Future<void> execute() async {
    return await repository.clearHistory();
  }
}
