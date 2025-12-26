// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) =>
    ScheduleModel(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => ScheduleModelItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

ScheduleModelItem _$ScheduleModelItemFromJson(Map<String, dynamic> json) =>
    ScheduleModelItem(
      id: json['id'] as String,
      eventDate: json['event_date'] as String,
      eventStartTime: json['event_start_time'] as String,
      eventEndTime: json['event_end_time'] as String,
      location: json['location'] as String,
      status: json['status'] as String,
      universityId: json['university_id'] as String,
      universityName: json['university_name'] as String,
      universityBriefName: json['university_brief_name'] as String,
      packageId: json['package_id'] as String,
      packageName: json['package_name'] as String,
      clientName: json['client_name'] as String,
    );

Map<String, dynamic> _$ScheduleModelItemToJson(ScheduleModelItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_date': instance.eventDate,
      'event_start_time': instance.eventStartTime,
      'event_end_time': instance.eventEndTime,
      'location': instance.location,
      'status': instance.status,
      'university_id': instance.universityId,
      'university_name': instance.universityName,
      'university_brief_name': instance.universityBriefName,
      'package_id': instance.packageId,
      'package_name': instance.packageName,
      'client_name': instance.clientName,
    };
