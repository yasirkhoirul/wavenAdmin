import 'package:equatable/equatable.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/photographer_payment.dart';

class PhotographerPaymentState extends Equatable {
  final List<PhotographerPayment> items;
  final PhotographerPaymentMetadata? metadata;
  final int currentPage;
  final RequestState requestState;
  final String message;
  final int highestpage;
  final bool isReach;

  const PhotographerPaymentState({
    this.items = const [],
    this.metadata,
    this.currentPage = 0,
    this.requestState = RequestState.init,
    this.message = '',
    this.highestpage = 0,
    this.isReach = false
  });

  PhotographerPaymentState copyWith({
    List<PhotographerPayment>? items,
    PhotographerPaymentMetadata? metadata,
    int? currentPage,
    RequestState? requestState,
    String? message,
    int? highestPage,
    bool? isReach,
  }) {
    return PhotographerPaymentState(
      items: items ?? this.items,
      metadata: metadata ?? this.metadata,
      currentPage: currentPage ?? this.currentPage,
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
      highestpage: highestPage??highestpage,
      isReach: isReach??this.isReach
    );
  }

  @override
  List<Object?> get props => [items, metadata, currentPage, requestState, message,isReach,highestpage];
}
