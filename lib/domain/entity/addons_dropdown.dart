class AddonsDropdown {
  final String message;
  final int count;
  final int totalPages;
  final int page;
  final int limit;
  final List<AddonDropdownItem> addons;

  AddonsDropdown({
    this.message = '',
    this.count = 0,
    this.totalPages = 0,
    this.page = 0,
    this.limit = 0,
    this.addons = const [],
  });

  AddonsDropdown copyWith({
    String? message,
    int? count,
    int? totalPages,
    int? page,
    int? limit,
    List<AddonDropdownItem>? addons,
  }) {
    return AddonsDropdown(
      message: message ?? this.message,
      count: count ?? this.count,
      totalPages: totalPages ?? this.totalPages,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      addons: addons ?? this.addons,
    );
  }
}

class AddonDropdownItem {
  final String id;
  final String title;

  AddonDropdownItem({
    this.id = '',
    this.title = '',
  });

  AddonDropdownItem copyWith({
    String? id,
    String? title,
  }) {
    return AddonDropdownItem(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}
