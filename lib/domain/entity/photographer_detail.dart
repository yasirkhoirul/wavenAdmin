import 'package:equatable/equatable.dart';

class PhotographerDetail extends Equatable {
  final PhotographerData photographerData;
  final PaymentData paymentData;

  const PhotographerDetail({
    required this.photographerData,
    required this.paymentData,
  });

  @override
  List<Object?> get props => [photographerData, paymentData];
}

class PhotographerData extends Equatable {
  final String id;
  final String username;
  final String email;
  final String name;
  final String phoneNumber;
  final String bankAccount;
  final bool isActive;
  final String gear;
  final int feePerHour;
  final String createdAt;

  const PhotographerData({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.bankAccount,
    required this.isActive,
    required this.gear,
    required this.feePerHour,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        name,
        phoneNumber,
        bankAccount,
        isActive,
        gear,
        feePerHour,
        createdAt,
      ];
}

class PaymentData extends Equatable {
  final int sessionCount;
  final int sessionPending;
  final int sessionVerified;
  final int sessionRejected;
  final int sessionPaid;
  final int sessionUnpaid;
  final int paidAmount;
  final int unpaidAmount;
  final String status;

  const PaymentData({
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
