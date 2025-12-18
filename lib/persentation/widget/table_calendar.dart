import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:wavenadmin/common/color.dart';

class CustomCalendar extends StatelessWidget {
  const CustomCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      
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

      /// Disable klik tanggal
      onTap: (CalendarTapDetails details) {
        if (details.targetElement == CalendarElement.calendarCell) {
          return; // tanggal tidak bisa diklik
        }

        if (details.targetElement == CalendarElement.appointment) {
          // Jika event ingin bisa diklik, tulis kode di sini
          debugPrint("Klik event: ${details.appointments?.first}");
        }
      },

      /// Event source
      dataSource: _CalendarDataSource(_getDataSource()),
    );
  }
}

/// ---------- DATA EVENT ----------


/// ---------- DATA SOURCE ----------
class _CalendarDataSource extends CalendarDataSource {
  _CalendarDataSource(List<Appointment> source) {
    appointments = source;
  }
}


List<Appointment> _getDataSource() {
  return [
    Appointment(
      startTime: DateTime(2025, 12, 5, 06, 00),
      endTime: DateTime(2025, 12, 5, 07, 00),
      subject: 'UGM - Fadila',
      color: MyColor.hijauaccent,
    ),
    Appointment(
      startTime: DateTime(2025, 12, 5, 07, 00),
      endTime: DateTime(2025, 12, 5, 08, 00),
      subject: 'UGM - Fadila',
      color: MyColor.hijauaccent,
    ),
    Appointment(
      startTime: DateTime(2025, 12, 6, 06, 00),
      endTime: DateTime(2025, 12, 6, 07, 00),
      subject: 'UGM - Fadila',
      color: MyColor.hijauaccent,
    ),
    Appointment(
      startTime: DateTime(2025, 12, 30, 06, 00),
      endTime: DateTime(2025, 12, 30, 07, 00),
      subject: 'UGM - Fadila',
      color: MyColor.hijauaccent,
    ),
  ];
}