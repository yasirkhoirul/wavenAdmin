import 'package:equatable/equatable.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/photographer_detail.dart';

class PhotographerDetailState extends Equatable {
  final PhotographerDetail? detail;
  final RequestState requestState;
  final String message;

  const PhotographerDetailState({
    this.detail,
    required this.requestState,
    required this.message,
  });

  factory PhotographerDetailState.initial() {
    return const PhotographerDetailState(
      detail: null,
      requestState: RequestState.init,
      message: '',
    );
  }

  PhotographerDetailState copyWith({
    PhotographerDetail? detail,
    RequestState? requestState,
    String? message,
  }) {
    return PhotographerDetailState(
      detail: detail ?? this.detail,
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [detail, requestState, message];
}
