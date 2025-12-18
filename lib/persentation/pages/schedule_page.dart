import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/persentation/widget/cardItemSingleContainer.dart';
import 'package:wavenadmin/persentation/widget/table_calendar.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: SizedBox(
      height: MediaQuery.of(context).size.width>700?900:2000,
      child: MainContent()));
  }
}

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  final List<Widget> maincalendar = [
                    Expanded(
                      flex: 7,
                      child: CarditemsinglecontainerWithBorder(
                        content: CustomCalendar(),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: CarditemsinglecontainerWithBorder(
                        content: DetailJadwalSection(
                          tanggal: DateTime(2025, 12, 5, 06, 00),
                          listJadwal: [
                            'UGM - Fadila',
                            'UGM - Fadila',
                            'UGM - Fadila',
                          ],
                        ),
                      ),
                    ),
                  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderPage(icon: MyIcon.icondashboard, judul: "Schedule",),
        ButtonAdd(),
        SizedBox(
          height: MediaQuery.of(context).size.width>700?700:1500,
          child: MediaQuery.of(context).size.width>700? Row(
            mainAxisSize: MainAxisSize.min,
            children: maincalendar,
          ):Column(children: maincalendar,),
        ),
      ],
    );
  }
}

class ButtonAdd extends StatelessWidget {
  const ButtonAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // aksi tombol
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00A86B), // warna hijau
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Tambah Jadwal",
            style: GoogleFonts.publicSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.add, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}

class HeaderPage extends StatelessWidget {
  final String judul;
  final String icon;
  const HeaderPage({super.key, required this.judul, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 200,
      child: Center(
        child: Row(
          spacing: 10,
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                MyColor.hijauaccent,
                BlendMode.srcIn,
              ),
              height: 28,
            ),
            Text(
              judul,
              style: GoogleFonts.publicSans(
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailJadwalSection extends StatelessWidget {
  final DateTime tanggal;
  final List<String> listJadwal;

  const DetailJadwalSection({
    super.key,
    required this.tanggal,
    required this.listJadwal,
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
                listJadwal.length.toString(),
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
        Column(
          children: listJadwal
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: MyColor.hijauaccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      item,
                      style: GoogleFonts.publicSans(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
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
