class PackageList {
  final PackageMetadataEntity metadata;
  final List<PackageItem> data;

  PackageList({
    required this.metadata,
    required this.data,
  });
}

class PackageMetadataEntity {
  final int count;
  final int totalPages;
  final int page;
  final int limit;

  PackageMetadataEntity({
    required this.count,
    required this.totalPages,
    required this.page,
    required this.limit,
  });
}

class PackageItem {
  final String id;
  final String title;
  final int price;
  final String bannerUrl;
  final String description;
  final dynamic benefits;

  PackageItem({
    required this.id,
    required this.title,
    required this.price,
    required this.bannerUrl,
    required this.description,
    this.benefits,
  });
}
