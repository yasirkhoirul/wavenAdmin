import 'package:wavenadmin/data/model/usermodel.dart';
import 'package:wavenadmin/domain/entity/booking_list_data.dart';

class BookingListState {
  final List<Booking> items;
  final int currentPage;
  final int highestPage;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final Object? error;
  final Metadata? metadata;
  final int totalBooking;
  final int totalPending;
  final int totalLunas;
  final int totalNeedVerified;
  final int totalVerified;

  const BookingListState({
    this.items = const [],
    this.currentPage = 0,
    this.highestPage = 0,
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.metadata,
    this.totalBooking = 0,
    this.totalPending = 0,
    this.totalLunas = 0,
    this.totalNeedVerified = 0,
    this.totalVerified = 0,
  });

  BookingListState copyWith({
    List<Booking>? items,
    int? currentPage,
    int? highestPage,
    bool? hasMore,
    bool? isLoading,
    bool? isLoadingMore,
    Object? error,
    Metadata? metadata,
    int? totalBooking,
    int? totalPending,
    int? totalLunas,
    int? totalNeedVerified,
    int? totalVerified,
  }) {
    return BookingListState(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      highestPage: highestPage ?? this.highestPage,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
      metadata: metadata ?? this.metadata,
      totalBooking: totalBooking ?? this.totalBooking,
      totalPending: totalPending ?? this.totalPending,
      totalLunas: totalLunas ?? this.totalLunas,
      totalNeedVerified: totalNeedVerified ?? this.totalNeedVerified,
      totalVerified: totalVerified ?? this.totalVerified,
    );
  }

  BookingListState appendData(BookingListData data) {
    final newItems = [...items, ...data.bookings];
    final totalPages = data.metadata?.totalPages ?? 0;
    final currentPageFromApi = (data.metadata?.page ?? 1) - 1; // Convert 1-indexed to 0-indexed

    return copyWith(
      items: newItems,
      currentPage: currentPageFromApi,
      highestPage: currentPageFromApi > highestPage ? currentPageFromApi : highestPage,
      hasMore: currentPageFromApi < totalPages - 1, // totalPages is 1-indexed, compare with 0-indexed
      metadata: data.metadata,
      totalBooking: data.totalBooking,
      totalPending: data.totalPending,
      totalLunas: data.totalLunas,
      totalNeedVerified: data.totalNeedVerified,
      totalVerified: data.totalVerified,
      isLoading: false,
      isLoadingMore: false,
    );
  }

  BookingListState replaceData(BookingListData data) {
    final totalPages = data.metadata?.totalPages ?? 0;
    final currentPageFromApi = (data.metadata?.page ?? 1) - 1; // Convert 1-indexed to 0-indexed

    return copyWith(
      items: data.bookings,
      currentPage: currentPageFromApi,
      highestPage: currentPageFromApi,
      hasMore: currentPageFromApi < totalPages - 1, // totalPages is 1-indexed, compare with 0-indexed
      metadata: data.metadata,
      totalBooking: data.totalBooking,
      totalPending: data.totalPending,
      totalLunas: data.totalLunas,
      totalNeedVerified: data.totalNeedVerified,
      totalVerified: data.totalVerified,
      isLoading: false,
      isLoadingMore: false,
      error: null,
    );
  }
}
