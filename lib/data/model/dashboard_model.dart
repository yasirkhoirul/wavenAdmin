import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/dashboard.dart';

part 'dashboard_model.g.dart';

@JsonSerializable()
class DashboardResponse {
    final String message;
    final DashboardModel data;
    const DashboardResponse(this.message,this.data);

    factory DashboardResponse.fromJson(Map<String,dynamic> json) => _$DashboardResponseFromJson(json);
}

@JsonSerializable()
class KeyValueItem {
  @JsonKey(name: 'Key')
  final String key;

  @JsonKey(name: 'Value')
  final int value;

  KeyValueItem({
    required this.key,
    required this.value,
  });

  factory KeyValueItem.fromJson(Map<String, dynamic> json) =>
      _$KeyValueItemFromJson(json);

  Map<String, dynamic> toJson() => _$KeyValueItemToJson(this);

  KeyValueEntity toEntity() => KeyValueEntity(
        key: key,
        value: value,
      );
}

@JsonSerializable()
class DashboardModel {
  @JsonKey(name: 'total_clients')
  final int totalClients;

  @JsonKey(name: 'total_clients_this_month')
  final int totalClientsThisMonth;

  @JsonKey(name: 'total_revenue')
  final int totalRevenue;

  @JsonKey(name: 'total_profit')
  final int totalProfit;

  @JsonKey(name: 'total_bookings')
  final int totalBookings;

  @JsonKey(name: 'booking_need_verification')
  final int bookingNeedVerification;

  @JsonKey(name: 'booking_need_photographer')
  final int bookingNeedPhotographer;

  @JsonKey(name: 'booking_need_upload_photo')
  final int bookingNeedUploadPhoto;

  @JsonKey(name: 'booking_per_university')
  final List<KeyValueItem> bookingPerUniversity;

  @JsonKey(name: 'booking_per_package')
  final List<KeyValueItem> bookingPerPackage;

  DashboardModel({
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

  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardModelToJson(this);

  DashboardEntity toEntity() => DashboardEntity(
        totalClients: totalClients,
        totalClientsThisMonth: totalClientsThisMonth,
        totalRevenue: totalRevenue,
        totalProfit: totalProfit,
        totalBookings: totalBookings,
        bookingNeedVerification: bookingNeedVerification,
        bookingNeedPhotographer: bookingNeedPhotographer,
        bookingNeedUploadPhoto: bookingNeedUploadPhoto,
        bookingPerUniversity: bookingPerUniversity.map((e) => e.toEntity()).toList(),
        bookingPerPackage: bookingPerPackage.map((e) => e.toEntity()).toList(),
      );
}
