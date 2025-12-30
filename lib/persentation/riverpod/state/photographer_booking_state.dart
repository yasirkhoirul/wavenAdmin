import 'package:equatable/equatable.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/photographer_booking.dart';

class PhotographerBookingState extends Equatable {
  final List<PhotographerBooking> items;
  final PhotographerBookingMetadata? metadata;
  final int currentPage;
  final RequestState requestState;
  final String message;

  const PhotographerBookingState({
    required this.items,
    this.metadata,
    required this.currentPage,
    required this.requestState,
    required this.message,
  });

  factory PhotographerBookingState.initial() {
    return const PhotographerBookingState(
      items: [],
      metadata: null,
      currentPage: 0,
      requestState: RequestState.init,
      message: '',
    );
  }

  PhotographerBookingState copyWith({
    List<PhotographerBooking>? items,
    PhotographerBookingMetadata? metadata,
    int? currentPage,
    RequestState? requestState,
    String? message,
  }) {
    return PhotographerBookingState(
      items: items ?? this.items,
      metadata: metadata ?? this.metadata,
      currentPage: currentPage ?? this.currentPage,
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [items, metadata, currentPage, requestState, message];
}
