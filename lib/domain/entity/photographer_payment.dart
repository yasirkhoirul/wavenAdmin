import 'package:equatable/equatable.dart';

class PhotographerPayment extends Equatable {
  final String id;
  final String name;
  final int sessionCount;
  final int sessionPending;
  final int sessionVerified;
  final int sessionRejected;
  final int sessionPaid;
  final int sessionUnpaid;
  final int paidAmount;
  final int unpaidAmount;
  final String status;

  const PhotographerPayment({
    required this.id,
    required this.name,
    required this.sessionCount,
    required this.sessionPending,
    required this.sessionVerified,
    required this.sessionRejected,
    required this.sessionPaid,
    required this.sessionUnpaid,
    required this.paidAmount,
    required this.unpaidAmount,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        sessionCount,
        sessionPending,
        sessionVerified,
        sessionRejected,
        sessionPaid,
        sessionUnpaid,
        paidAmount,
        unpaidAmount,
        status,
      ];
}

class PhotographerPaymentMetadata extends Equatable {
  final int count;
  final int totalPages;
  final int page;
  final int limit;

  const PhotographerPaymentMetadata({
    required this.count,
    required this.totalPages,
    required this.page,
    required this.limit,
  });

  @override
  List<Object?> get props => [count, totalPages, page, limit];
}
