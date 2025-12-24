class PhotographerDropdown {
  final String message;
  final int count;
  final int totalPages;
  final int page;
  final int limit;
  final List<PhotographerDropdownItem> photographers;

  PhotographerDropdown({
    this.message = '',
    this.count = 0,
    this.totalPages = 0,
    this.page = 0,
    this.limit = 0,
    this.photographers = const [],
  });

  PhotographerDropdown copyWith({
    String? message,
    int? count,
    int? totalPages,
    int? page,
    int? limit,
    List<PhotographerDropdownItem>? photographers,
  }) {
    return PhotographerDropdown(
      message: message ?? this.message,
      count: count ?? this.count,
      totalPages: totalPages ?? this.totalPages,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      photographers: photographers ?? this.photographers,
    );
  }
}

class PhotographerDropdownItem {
  final String id;
  final String name;
  final int feePerHour;

  PhotographerDropdownItem({
    this.id = '',
    this.name = '',
    this.feePerHour = 0,
  });

  PhotographerDropdownItem copyWith({
    String? id,
    String? name,
    int? feePerHour,
  }) {
    return PhotographerDropdownItem(
      id: id ?? this.id,
      name: name ?? this.name,
      feePerHour: feePerHour ?? this.feePerHour,
    );
  }
}
