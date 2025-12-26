class ScheduleEntity {
  final String id;
  final DateTime eventDate;
  final String startTime;
  final String endTime;
  final String location;
  final String status;
  final String universityName;
  final String packageName;
  final String clientName;

  ScheduleEntity({
    required this.id,
    required this.eventDate,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.status,
    required this.universityName,
    required this.packageName,
    required this.clientName,
  });
}
