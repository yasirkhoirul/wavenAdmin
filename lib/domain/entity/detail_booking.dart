class DetailBooking {
  final String id;
  final String clientName;
  final String clientPhoneNumber;
  final String clientInstagram;
  final String universityId;
  final String university;
  final String packageId;
  final String packageName;
  final String eventDate;
  final String eventStartTime;
  final String eventEndTime;
  final String location;
  final String note;
  final String verificationStatus;
  final bool alreadyPhoto;
  final String editedPhoto;
  final String photoResultUrl;
  final String editedPhotoResultUrl;
  final String status;
  final List<Extra> extra;
  final int totalAmount;
  final int paidAmount;
  final int unpaidAmount;
  final List<Transaction> transactions;
  final List<Photographer> photographerData;

  DetailBooking({
    this.id = '',
    this.clientName = '',
    this.clientPhoneNumber = '',
    this.clientInstagram = '',
    this.universityId = '',
    this.university = '',
    this.packageId = '',
    this.packageName = '',
    this.eventDate = '',
    this.eventStartTime = '',
    this.eventEndTime = '',
    this.location = '',
    this.note = '',
    this.verificationStatus = '',
    this.alreadyPhoto = false,
    this.photoResultUrl = '',
    this.editedPhotoResultUrl = '',
    this.status = '',
    this.extra = const [],
    this.totalAmount = 0,
    this.paidAmount = 0,
    this.unpaidAmount = 0,
    this.transactions = const [],
    this.photographerData = const [],
    this.editedPhoto = '',
  });

  DetailBooking copyWith({
    String? id,
    String? clientName,
    String? clientPhoneNumber,
    String? clientInstagram,
    String? universityId,
    String? university,
    String? packageId,
    String? packageName,
    String? eventDate,
    String? eventStartTime,
    String? eventEndTime,
    String? location,
    String? note,
    String? verificationStatus,
    bool? alreadyPhoto,
    String? photoResultUrl,
    String? editedPhotoResultUrl,
    String? status,
    List<Extra>? extra,
    int? totalAmount,
    int? paidAmount,
    int? unpaidAmount,
    List<Transaction>? transactions,
    List<Photographer>? photographerData,
  }) {
    return DetailBooking(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      clientPhoneNumber: clientPhoneNumber ?? this.clientPhoneNumber,
      clientInstagram: clientInstagram ?? this.clientInstagram,
      universityId: universityId ?? this.universityId,
      university: university ?? this.university,
      packageId: packageId ?? this.packageId,
      packageName: packageName ?? this.packageName,
      eventDate: eventDate ?? this.eventDate,
      eventStartTime: eventStartTime ?? this.eventStartTime,
      eventEndTime: eventEndTime ?? this.eventEndTime,
      location: location ?? this.location,
      note: note ?? this.note,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      alreadyPhoto: alreadyPhoto ?? this.alreadyPhoto,
      photoResultUrl: photoResultUrl ?? this.photoResultUrl,
      editedPhotoResultUrl: editedPhotoResultUrl ?? this.editedPhotoResultUrl,
      status: status ?? this.status,
      extra: extra ?? this.extra,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      unpaidAmount: unpaidAmount ?? this.unpaidAmount,
      transactions: transactions ?? this.transactions,
      photographerData: photographerData ?? this.photographerData,
      editedPhoto: editedPhoto,
    );
  }
}

class Extra {
  final String id;
  final String name;

  Extra({this.id = '', this.name = ''});

  Extra copyWith({String? id, String? name}) {
    return Extra(id: id ?? this.id, name: name ?? this.name);
  }
}

class Transaction {
  final String id;
  final int amount;
  final String status;
  final String type;
  final String method;
  final String transactionTime;
  final String verificationStatus;
  final String? transactionEvidenceUrl;

  Transaction({
    this.id = '',
    this.amount = 0,
    this.status = '',
    this.type = '',
    this.method = '',
    this.transactionTime = '',
    this.verificationStatus = '',
    this.transactionEvidenceUrl,
  });

  Transaction copyWith({
    String? id,
    int? amount,
    String? status,
    String? type,
    String? method,
    String? transactionTime,
    String? verificationStatus,
    String? transactionEvidenceUrl,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      type: type ?? this.type,
      method: method ?? this.method,
      transactionTime: transactionTime ?? this.transactionTime,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      transactionEvidenceUrl:
          transactionEvidenceUrl ?? this.transactionEvidenceUrl,
    );
  }
}

class Photographer {
  final String id;
  final String name;
  final String phoneNumber;
  final int fee;

  Photographer({
    this.id = '',
    this.name = '',
    this.phoneNumber = '',
    this.fee = 0,
  });

  Photographer copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    int? fee,
  }) {
    return Photographer(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fee: fee ?? this.fee,
    );
  }
}
