import 'package:wavenadmin/data/model/usermodel.dart';
import 'package:wavenadmin/domain/entity/user_fotografer.dart';

class PhotographerPagedState {
  final List<UserFotografer> items;
  final Metadata?  metadata;
  final int currentPage;
  final int highestPage;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final Object? error;

  const PhotographerPagedState({
    this.items = const [],
    this.currentPage = 0,
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.highestPage = 0,
    this.metadata
  });

  PhotographerPagedState copyWith({
    List<UserFotografer>? items,
    int? currentPage,
    int? highestPage,
    int? totalUser,
    int? activeUser,
    bool? hasMore,
    bool? isLoading,
    bool? isLoadingMore,
    Object? error,
    bool clearError = false,
    Metadata? metadata
  }) {
    return PhotographerPagedState(
      metadata: metadata??this.metadata,
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      highestPage: highestPage??this.highestPage,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: clearError ? null : (error ?? this.error),
    );
  }
}
