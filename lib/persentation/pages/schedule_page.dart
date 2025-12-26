import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/domain/entity/schedule_entity.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/cardItemSingleContainer.dart';
import 'package:wavenadmin/persentation/widget/header_page.dart';
import 'package:wavenadmin/persentation/widget/table_calendar.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: SizedBox(
      height: MediaQuery.of(context).size.width>700?900:1350,
      child: MainContent()));
  }
}

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  DateTime selectedDate = DateTime.now();
  List<ScheduleEntity> selectedSchedules = [];

  void _handleDateSelected(DateTime date, List<ScheduleEntity> schedules) {
    setState(() {
      selectedDate = date;
      selectedSchedules = schedules;
    });
  }

  @override
  Widget build(BuildContext context) {
    final maincalendar = [
      Expanded(
        flex: MediaQuery.of(context).size.width>700?7:5,
        child: CarditemsinglecontainerWithBorder(
          content: CustomCalendar(
            onDateSelected: _handleDateSelected,
          ),
        ),
      ),
      Expanded(
        flex: MediaQuery.of(context).size.width>700?3:5,
        child: CarditemsinglecontainerWithBorder(
          content: DetailJadwalSection(
            tanggal: selectedDate,
            schedules: selectedSchedules,
          ),
        ),
      ),
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderPage(icon: MyIcon.icondashboard, judul: "Schedule",),
        LBUttonMobile(ontap: (){
          context.go('/client');
        }, teks: "Tambah Booking"),
        SizedBox(
          height: MediaQuery.of(context).size.width>700?700:1200,
          child: MediaQuery.of(context).size.width>700? Row(
            mainAxisSize: MainAxisSize.min,
            children: maincalendar,
          ):Column(children: maincalendar,),
        ),
      ],
    );
  }
}




class DetailJadwalSection extends StatelessWidget {
  final DateTime tanggal;
  final List<ScheduleEntity> schedules;

  const DetailJadwalSection({
    super.key,
    required this.tanggal,
    required this.schedules,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // === JUDUL UTAMA ===
        Text(
          "Detail Jadwal",
          style: GoogleFonts.publicSans(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // GARIS PEMISAH
        Container(height: 1, width: double.infinity, color: Colors.white24),

        const SizedBox(height: 24),

        // === SUBJUDUL TANGGAL ===
        Text(
          "Tanggal",
          style: GoogleFonts.publicSans(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),

        // TANGGAL VALUE
        Text(
          formatTanggal(tanggal),
          style: GoogleFonts.publicSans(fontSize: 18, color: Colors.white70),
        ),

        const SizedBox(height: 24),

        // === ROW LIST JADWAL + BADGE ===
        Row(
          children: [
            Text(
              "List Jadwal",
              style: GoogleFonts.publicSans(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                schedules.length.toString(),
                style: GoogleFonts.publicSans(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // === LIST CARD JADWAL ===
        Expanded(
          child: schedules.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada jadwal',
                    style: GoogleFonts.publicSans(
                      color: Colors.white54,
                      fontSize: 16,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: schedules.length,
                  itemBuilder: (context, index) {
                    final schedule = schedules[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: MyColor.hijauaccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Universitas - Client
                            Text(
                              '${schedule.universityName} - ${schedule.clientName}',
                              style: GoogleFonts.publicSans(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Waktu
                            Row(
                              children: [
                                const Icon(Icons.access_time, color: Colors.white70, size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  '${schedule.startTime} - ${schedule.endTime}',
                                  style: GoogleFonts.publicSans(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            // Package
                            Row(
                              children: [
                                const Icon(Icons.card_giftcard, color: Colors.white70, size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  schedule.packageName,
                                  style: GoogleFonts.publicSans(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            // Location
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: Colors.white70, size: 16),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    schedule.location,
                                    style: GoogleFonts.publicSans(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  String formatTanggal(DateTime d) {
    const bulan = [
      "",
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];

    const hari = [
      "",
      "Senin",
      "Selasa",
      "Rabu",
      "Kamis",
      "Jumat",
      "Sabtu",
      "Minggu",
    ];

    return "${hari[d.weekday]}, ${d.day} ${bulan[d.month]} ${d.year}";
  }
}
