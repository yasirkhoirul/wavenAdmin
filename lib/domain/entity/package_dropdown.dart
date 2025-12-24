class PackageDropdown {
  final String message;
  final int count;
  final int totalPages;
  final int page;
  final int limit;
  final List<Package> packages;

  PackageDropdown({
    this.message = '',
    this.count = 0,
    this.totalPages = 0,
    this.page = 0,
    this.limit = 0,
    this.packages = const [],
  });

  PackageDropdown copyWith({
    String? message,
    int? count,
    int? totalPages,
    int? page,
    int? limit,
    List<Package>? packages,
  }) {
    return PackageDropdown(
      message: message ?? this.message,
      count: count ?? this.count,
      totalPages: totalPages ?? this.totalPages,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      packages: packages ?? this.packages,
    );
  }
}

class Package {
  final String id;
  final String title;
  final int? price;

  Package({
    this.id = '',
    this.title = '',
    this.price,
  });

  Package copyWith({
    String? id,
    String? title,
    int? price,
  }) {
    return Package(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
    );
  }
}
