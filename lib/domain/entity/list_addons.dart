class ListAddons {
  final String message;
  final int count;
  final int totalPages;
  final int page;
  final int limit;
  final List<Addon> addons;
  final bool isReached;
  final int highestpage;

  ListAddons({
    this.message = '',
    this.count = 0,
    this.totalPages = 0,
    this.page = 0,
    this.limit = 0,
    this.addons = const [],
    this.isReached = false,
    this.highestpage = 1
  });

  ListAddons copyWith({
    String? message,
    int? count,
    int? totalPages,
    int? page,
    int? limit,
    List<Addon>? addons,
    int? highestpage,
    bool? isReached
  }) {
    return ListAddons(
      message: message ?? this.message,
      count: count ?? this.count,
      totalPages: totalPages ?? this.totalPages,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      addons: addons ?? this.addons,
      highestpage: highestpage?? this.highestpage,
      isReached: isReached??this.isReached
    );
  }
  ListAddons appendMode({
    
    List<Addon>? addons,
    
  }) {
    return copyWith(
      addons: [...this.addons,...addons??[]]
    );
  }
}

class Addon {
  final String id;
  final String title;
  final int price;
  final bool isActive;

  Addon({
    this.id = '',
    this.title = '',
    this.price = 0,
    this.isActive = true,
  });

  Addon copyWith({
    String? id,
    String? title,
    int? price,
    bool? isActive,
  }) {
    return Addon(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      isActive: isActive ?? this.isActive,
    );
  }
}
