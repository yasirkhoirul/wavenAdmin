import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/schedule_entity.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/schedule/get_list_schedule.dart';

class CustomCalendar extends ConsumerStatefulWidget {
  final Function(DateTime date, List<ScheduleEntity> schedules)? onDateSelected;
  
  const CustomCalendar({super.key, this.onDateSelected});

  @override
  ConsumerState<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends ConsumerState<CustomCalendar> {
  late int currentMonth;
  late int currentYear;
  late CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    currentMonth = now.month;
    currentYear = now.year;
    _calendarController = CalendarController();
    _calendarController.displayDate = now;
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleAsync = ref.watch(getListScheduleProvider(currentMonth, currentYear, VerificationStatus.APPROVED));
    
    return scheduleAsync.when(
      data: (schedules) => SfCalendar(
        controller: _calendarController,
        onViewChanged: (viewChangedDetails) {
          final visibleDates = viewChangedDetails.visibleDates;
          final DateTime focusedDate = visibleDates[visibleDates.length ~/ 2];
          final int month = focusedDate.month;
          final int year = focusedDate.year;
          
          if (month != currentMonth || year != currentYear) {
            // setState akan trigger rebuild dan watch akan fetch data bulan baru
            setState(() {
              currentMonth = month;
              currentYear = year;
            });
            Logger().d("bulan $month year $year");
          }
        },
      view: CalendarView.month,
      backgroundColor: const Color(0xFF1E1E1E),
      todayHighlightColor: MyColor.hijauaccent,
      headerStyle: const CalendarHeaderStyle(
        textStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      viewHeaderStyle: const ViewHeaderStyle(
        dayTextStyle: TextStyle(color: Colors.white70),
      ),
      monthViewSettings: const MonthViewSettings(
        dayFormat: 'EEE',
        numberOfWeeksInView: 6,
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        showAgenda: false,
        monthCellStyle: MonthCellStyle(
          textStyle: TextStyle(color: Colors.white),
          leadingDatesTextStyle: TextStyle(color: Colors.white24),
          trailingDatesTextStyle: TextStyle(color: Colors.white24),
        ),
      ),

      /// Handle tap events
      onTap: (CalendarTapDetails details) {
        if (details.targetElement == CalendarElement.calendarCell) {
          // Ketika klik tanggal, tampilkan jadwal untuk hari itu
          final DateTime? selectedDate = details.date;
          if (selectedDate != null && widget.onDateSelected != null) {
            final schedulesForDate = schedules.where((schedule) {
              return schedule.eventDate.year == selectedDate.year &&
                     schedule.eventDate.month == selectedDate.month &&
                     schedule.eventDate.day == selectedDate.day;
            }).toList();
            widget.onDateSelected!(selectedDate, schedulesForDate);
          }
        }

        if (details.targetElement == CalendarElement.appointment) {
          // Ketika klik event, tampilkan detail untuk hari event tersebut
          final Appointment? appointment = details.appointments?.first as Appointment?;
          if (appointment != null && widget.onDateSelected != null) {
            final DateTime eventDate = appointment.startTime;
            final schedulesForDate = schedules.where((schedule) {
              return schedule.eventDate.year == eventDate.year &&
                     schedule.eventDate.month == eventDate.month &&
                     schedule.eventDate.day == eventDate.day;
            }).toList();
            widget.onDateSelected!(eventDate, schedulesForDate);
          }
        }
      },

      /// Event source
      dataSource: _CalendarDataSource(_convertToAppointments(schedules)),
    ),
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (error, stack) => Center(
      child: Text(
        'Error loading schedule: $error',
        style: const TextStyle(color: Colors.red),
      ),
    ),
    );
  }

  /// Convert schedule entities to appointments
  List<Appointment> _convertToAppointments(List<ScheduleEntity> schedules) {
    return schedules.map((schedule) {
      // Parse time string (format: "HH:mm")
      final startTimeParts = schedule.startTime.split(':');
      final endTimeParts = schedule.endTime.split(':');
      
      final startTime = DateTime(
        schedule.eventDate.year,
        schedule.eventDate.month,
        schedule.eventDate.day,
        int.parse(startTimeParts[0]),
        int.parse(startTimeParts[1]),
      );
      
      final endTime = DateTime(
        schedule.eventDate.year,
        schedule.eventDate.month,
        schedule.eventDate.day,
        int.parse(endTimeParts[0]),
        int.parse(endTimeParts[1]),
      );
      
      return Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: '${schedule.universityName} - ${schedule.clientName}',
        notes: schedule.packageName,
        color: MyColor.hijauaccent,
      );
    }).toList();
  }
}

/// ---------- DATA SOURCE ----------
class _CalendarDataSource extends CalendarDataSource {
  _CalendarDataSource(List<Appointment> source) {
    appointments = source;
  }
}
