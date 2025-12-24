class DetailAddons {
  final String message;
  final String id;
  final String title;
  final int price;
  final bool isActive;
  final String createdAt;

  DetailAddons({
    this.message = '',
    this.id = '',
    this.title = '',
    this.price = 0,
    this.isActive = true,
    this.createdAt = '',
  });

  DetailAddons copyWith({
    String? message,
    String? id,
    String? title,
    int? price,
    bool? isActive,
    String? createdAt,
  }) {
    return DetailAddons(
      message: message ?? this.message,
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
