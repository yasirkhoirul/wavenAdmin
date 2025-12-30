class UniversitasList {
  final String message;
  final UniversityMetadata metadata;
  final List<UniversityItem> data;

  UniversitasList({
    required this.message,
    required this.metadata,
    required this.data,
  });
}

class UniversityMetadata {
  final int? count;
  final int? totalPages;
  final int? page;
  final int? limit;

  UniversityMetadata({
    required this.count,
    required this.totalPages,
    required this.page,
    required this.limit,
  });
}

class UniversityItem {
  final String id;
  final String name;
  final String briefName;
  final String address;
  final bool isActive;
  final String createdAt;

  UniversityItem({
    required this.id,
    required this.name,
    required this.briefName,
    required this.address,
    required this.isActive,
    required this.createdAt,
  });
}
