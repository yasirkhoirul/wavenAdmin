import 'package:wavenadmin/domain/entity/file_mover_history.dart';

abstract class FileMoverRepository {
  Future<void> saveHistory(FileMoverHistory history);
  Future<List<FileMoverHistory>> getHistories();
  Future<void> clearHistory();
}
