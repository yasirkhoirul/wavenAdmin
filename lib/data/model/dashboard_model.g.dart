// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardResponse _$DashboardResponseFromJson(Map<String, dynamic> json) =>
    DashboardResponse(
      json['message'] as String,
      DashboardModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardResponseToJson(DashboardResponse instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

KeyValueItem _$KeyValueItemFromJson(Map<String, dynamic> json) => KeyValueItem(
  key: json['Key'] as String,
  value: (json['Value'] as num).toInt(),
);

Map<String, dynamic> _$KeyValueItemToJson(KeyValueItem instance) =>
    <String, dynamic>{'Key': instance.key, 'Value': instance.value};

DashboardModel _$DashboardModelFromJson(
  Map<String, dynamic> json,
) => DashboardModel(
  totalClients: (json['total_clients'] as num).toInt(),
  totalClientsThisMonth: (json['total_clients_this_month'] as num).toInt(),
  totalRevenue: (json['total_revenue'] as num).toInt(),
  totalProfit: (json['total_profit'] as num).toInt(),
  totalBookings: (json['total_bookings'] as num).toInt(),
  bookingNeedVerification: (json['booking_need_verification'] as num).toInt(),
  bookingNeedPhotographer: (json['booking_need_photographer'] as num).toInt(),
  bookingNeedUploadPhoto: (json['booking_need_upload_photo'] as num).toInt(),
  bookingPerUniversity: (json['booking_per_university'] as List<dynamic>)
      .map((e) => KeyValueItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  bookingPerPackage: (json['booking_per_package'] as List<dynamic>)
      .map((e) => KeyValueItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DashboardModelToJson(DashboardModel instance) =>
    <String, dynamic>{
      'total_clients': instance.totalClients,
      'total_clients_this_month': instance.totalClientsThisMonth,
      'total_revenue': instance.totalRevenue,
      'total_profit': instance.totalProfit,
      'total_bookings': instance.totalBookings,
      'booking_need_verification': instance.bookingNeedVerification,
      'booking_need_photographer': instance.bookingNeedPhotographer,
      'booking_need_upload_photo': instance.bookingNeedUploadPhoto,
      'booking_per_university': instance.bookingPerUniversity,
      'booking_per_package': instance.bookingPerPackage,
    };
