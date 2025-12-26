import 'package:wavenadmin/domain/entity/universitas_list.dart';

class UniversitasListState {
  final int limit;
  final int currentPage;
  final bool isReached;
  final int highestPage;
  final UniversityMetadata? metadata;
  final List<UniversityItem> item;
  final bool isloadingmore;

  const UniversitasListState({
    required this.limit,
    this.currentPage = 1,
    this.isReached = false,
    this.highestPage = 1,
    required this.item,
    this.metadata,
    this.isloadingmore = false
  });

  UniversitasListState copyWith({
    int? limit,
    int? currentPage,
    bool? isReached,
    int? highestPage,
    UniversityMetadata? metadata,
    List<UniversityItem>? item,
    bool? isloading
  }) {
    return UniversitasListState(
      limit: limit ?? this.limit,
      item: item ?? this.item,
      isReached: isReached??this.isReached,
      highestPage: highestPage??this.highestPage,
      metadata: metadata??this.metadata,
      isloadingmore: isloading??isloadingmore,
      currentPage: currentPage??this.currentPage
    );
  }

  UniversitasListState  appendData({
    List<UniversityItem>? item
  }){
    return copyWith(item: [...this.item,...item??[]],isloading: 
    false);
  }
}
