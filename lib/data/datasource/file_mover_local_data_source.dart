import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wavenadmin/domain/entity/file_mover_history.dart';

class FileMoverLocalDataSource {
  final FlutterSecureStorage storage;
  static const String _historyKey = 'file_mover_histories';

  FileMoverLocalDataSource(this.storage);

  Future<void> saveHistory(FileMoverHistory history) async {
    try {
      final histories = await getHistories();
      histories.insert(0, history); // Add to beginning
      
      // Keep only last 50 histories
      if (histories.length > 50) {
        histories.removeRange(50, histories.length);
      }
      
      final jsonList = histories.map((h) => h.toJson()).toList();
      await storage.write(key: _historyKey, value: jsonEncode(jsonList));
    } catch (e) {
      throw Exception('Failed to save history: $e');
    }
  }

  Future<List<FileMoverHistory>> getHistories() async {
    try {
      final jsonString = await storage.read(key: _historyKey);
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }
      
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => FileMoverHistory.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> clearHistory() async {
    try {
      await storage.delete(key: _historyKey);
    } catch (e) {
      throw Exception('Failed to clear history: $e');
    }
  }
}
