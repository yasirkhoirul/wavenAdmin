class KeyValueEntity {
  final String key;
  final int value;

  KeyValueEntity({
    required this.key,
    required this.value,
  });

  @override
  String toString() => 'KeyValueEntity(key: $key, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KeyValueEntity && other.key == key && other.value == value;
  }

  @override
  int get hashCode => key.hashCode ^ value.hashCode;
}

class DashboardEntity {
  final int totalClients;
  final int totalClientsThisMonth;
  final int totalRevenue;
  final int totalProfit;
  final int totalBookings;
  final int bookingNeedVerification;
  final int bookingNeedPhotographer;
  final int bookingNeedUploadPhoto;
  final List<KeyValueEntity> bookingPerUniversity;
  final List<KeyValueEntity> bookingPerPackage;

  DashboardEntity({
    required this.totalClients,
    required this.totalClientsThisMonth,
    required this.totalRevenue,
    required this.totalProfit,
    required this.totalBookings,
    required this.bookingNeedVerification,
    required this.bookingNeedPhotographer,
    required this.bookingNeedUploadPhoto,
    required this.bookingPerUniversity,
    required this.bookingPerPackage,
  });

  @override
  String toString() {
    return 'DashboardEntity(totalClients: $totalClients, totalClientsThisMonth: $totalClientsThisMonth, totalRevenue: $totalRevenue, totalProfit: $totalProfit, totalBookings: $totalBookings, bookingNeedVerification: $bookingNeedVerification, bookingNeedPhotographer: $bookingNeedPhotographer, bookingNeedUploadPhoto: $bookingNeedUploadPhoto, bookingPerUniversity: $bookingPerUniversity, bookingPerPackage: $bookingPerPackage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DashboardEntity &&
        other.totalClients == totalClients &&
        other.totalClientsThisMonth == totalClientsThisMonth &&
        other.totalRevenue == totalRevenue &&
        other.totalProfit == totalProfit &&
        other.totalBookings == totalBookings &&
        other.bookingNeedVerification == bookingNeedVerification &&
        other.bookingNeedPhotographer == bookingNeedPhotographer &&
        other.bookingNeedUploadPhoto == bookingNeedUploadPhoto &&
        other.bookingPerUniversity == bookingPerUniversity &&
        other.bookingPerPackage == bookingPerPackage;
  }

  @override
  int get hashCode {
    return totalClients.hashCode ^
        totalClientsThisMonth.hashCode ^
        totalRevenue.hashCode ^
        totalProfit.hashCode ^
        totalBookings.hashCode ^
        bookingNeedVerification.hashCode ^
        bookingNeedPhotographer.hashCode ^
        bookingNeedUploadPhoto.hashCode ^
        bookingPerUniversity.hashCode ^
        bookingPerPackage.hashCode;
  }
}
