class UniversityDropdown {
  final String message;
  final int count;
  final int totalPages;
  final int page;
  final int limit;
  final List<University> universities;

  UniversityDropdown({
    this.message = '',
    this.count = 0,
    this.totalPages = 0,
    this.page = 0,
    this.limit = 0,
    this.universities = const [],
  });

  UniversityDropdown copyWith({
    String? message,
    int? count,
    int? totalPages,
    int? page,
    int? limit,
    List<University>? universities,
  }) {
    return UniversityDropdown(
      message: message ?? this.message,
      count: count ?? this.count,
      totalPages: totalPages ?? this.totalPages,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      universities: universities ?? this.universities,
    );
  }
}

class University {
  final String id;
  final String name;

  University({
    this.id = '',
    this.name = '',
  });

  University copyWith({
    String? id,
    String? name,
  }) {
    return University(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
