class FileMoverHistory {
  final String id;
  final DateTime timestamp;
  final List<String> fileNames;
  final String extension;
  final int successCount;
  final List<String> failedFiles;
  final List<String> notFoundFiles;

  FileMoverHistory({
    required this.id,
    required this.timestamp,
    required this.fileNames,
    required this.extension,
    required this.successCount,
    required this.failedFiles,
    required this.notFoundFiles,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'fileNames': fileNames,
      'extension': extension,
      'successCount': successCount,
      'failedFiles': failedFiles,
      'notFoundFiles': notFoundFiles,
    };
  }

  factory FileMoverHistory.fromJson(Map<String, dynamic> json) {
    return FileMoverHistory(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      fileNames: List<String>.from(json['fileNames'] as List),
      extension: json['extension'] as String,
      successCount: json['successCount'] as int,
      failedFiles: List<String>.from(json['failedFiles'] as List),
      notFoundFiles: List<String>.from(json['notFoundFiles'] as List),
    );
  }
}
