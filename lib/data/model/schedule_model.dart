import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/schedule_entity.dart';


part 'schedule_model.g.dart';

@JsonSerializable()
class ScheduleModel {
  final String message;
  final List<ScheduleModelItem> data;

  ScheduleModel({
    required this.message,
    required this.data,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);
}


@JsonSerializable()
class ScheduleModelItem {
  final String id;

  @JsonKey(name: 'event_date')
  final String eventDate;

  @JsonKey(name: 'event_start_time')
  final String eventStartTime;

  @JsonKey(name: 'event_end_time')
  final String eventEndTime;

  final String location;
  final String status;

  @JsonKey(name: 'university_id')
  final String universityId;

  @JsonKey(name: 'university_name')
  final String universityName;

  @JsonKey(name: 'university_brief_name')
  final String universityBriefName;

  @JsonKey(name: 'package_id')
  final String packageId;

  @JsonKey(name: 'package_name')
  final String packageName;

  @JsonKey(name: 'client_name')
  final String clientName;

  ScheduleModelItem({
    required this.id,
    required this.eventDate,
    required this.eventStartTime,
    required this.eventEndTime,
    required this.location,
    required this.status,
    required this.universityId,
    required this.universityName,
    required this.universityBriefName,
    required this.packageId,
    required this.packageName,
    required this.clientName,
  });

  factory ScheduleModelItem.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelItemFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleModelItemToJson(this);

  ScheduleEntity toEntity() {
    return ScheduleEntity(
      id: id,
      eventDate: DateTime.parse(eventDate),
      startTime: eventStartTime,
      endTime: eventEndTime,
      location: location,
      status: status,
      universityName: universityName,
      packageName: packageName,
      clientName: clientName,
    );
  }
}