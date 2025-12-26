import 'package:wavenadmin/domain/entity/package_list.dart';

class PackageListState {
  final int currentPage;
  final int highestPage;
  final bool isReached;
  final List<PackageItem> item;
  final int limit;
  final PackageMetadataEntity? metadata;
  final bool isloading;

  PackageListState({
    required this.currentPage,
    required this.highestPage,
    required this.isReached,
    required this.item,
    required this.limit,
    this.metadata,
    this.isloading = false,
  });

  bool get isloadingmore => isloading;

  PackageListState copyWith({
    int? currentPage,
    int? highestPage,
    bool? isReached,
    List<PackageItem>? item,
    int? limit,
    PackageMetadataEntity? metadata,
    bool? isloading,
  }) {
    return PackageListState(
      currentPage: currentPage ?? this.currentPage,
      highestPage: highestPage ?? this.highestPage,
      isReached: isReached ?? this.isReached,
      item: item ?? this.item,
      limit: limit ?? this.limit,
      metadata: metadata ?? this.metadata,
      isloading: isloading ?? this.isloading,
    );
  }

  PackageListState appendData({required List<PackageItem> item}) {
    return PackageListState(
      currentPage: currentPage,
      highestPage: highestPage,
      isReached: isReached,
      item: [...this.item, ...item],
      limit: limit,
      metadata: metadata,
      isloading: false,
    );
  }
}
