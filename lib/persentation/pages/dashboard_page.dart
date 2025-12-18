import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/persentation/widget/cardItemSingleContainer.dart';
import 'package:wavenadmin/persentation/widget/carditemcontainer.dart';
import 'package:wavenadmin/persentation/widget/piechart.dart';

class Dashboardpage extends StatelessWidget {
  const Dashboardpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MediaQuery.of(context).size.width > 700
          ? Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: SizedBox(
                height: 900,
                child: Column(
                    spacing: 20,
                    children: [
                      Row(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(MyIcon.icondashboard),
                          Text("Dashboard"),
                        ],
                      ),
                      HeaderInformation(),
                      Expanded(child: MainContent()),
                    ],
                  ),
              ),
            ),
          )
          : SingleChildScrollView(
              child: SizedBox(
                height: 2000,
                child: Column(
                  spacing: 20,
                  children: [
                    Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(MyIcon.icondashboard),
                        Text("Dashboard"),
                      ],
                    ),
                    HeaderInformation(),
                    Expanded(child: MainContent()),
                  ],
                ),
              ),
            ),
    );
  }
}

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  List<Widget> data = [
    Expanded(
      child: Column(
        spacing: 10,
        children: [
          Expanded(
            child: CardItemContainer(
              aset: MyIcon.icondashboard,
              judul: "Total Bookings",
              content: "1500",
              color: Colors.white,
            ),
          ),
          Expanded(
            child: CardItemContainer(
              aset: MyIcon.icondashboard,
              judul: "Perlu Verifikasi",
              content: "1500",
              color: MyColor.oren,
            ),
          ),
          Expanded(
            child: CardItemContainer(
              aset: MyIcon.icondashboard,
              judul: "Belum Assign Fotografer",
              content: "1500",
              color: MyColor.hijauaccent,
            ),
          ),
          Expanded(
            child: CardItemContainer(
              aset: MyIcon.icondashboard,
              judul: "Belum Upload Foto",
              content: "1500",
              color: MyColor.birutua,
            ),
          ),
        ],
      ),
    ),
    Expanded(
      child: Carditemsinglecontainer(
        content: Column(
          spacing: 10,
          children: [
            ItemUniv(judul: "UGM", jumlah: "1000"),
            ItemUniv(judul: "UGM", jumlah: "1000"),
            ItemUniv(judul: "UGM", jumlah: "1000"),
            ItemUniv(judul: "UGM", jumlah: "1000"),
            ItemUniv(judul: "UGM", jumlah: "1000"),
          ],
        ),
        header: [
          Text(
            "Universitas",
            style: GoogleFonts.publicSans(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(Icons.link),
        ],
      ),
    ),
    Expanded(
      child: Carditemsinglecontainer(
        header: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "by Package",
                style: GoogleFonts.publicSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "percentage by package",
                style: GoogleFonts.publicSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: MyColor.abudalamcontainer,
                ),
              ),
            ],
          ),
        ],
        content: PieChartExample(),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 700
        ? Row(spacing: 20, children: data)
        : SizedBox(height: 1500, child: Column(spacing: 20, children: data));
  }
}

class ItemUniv extends StatelessWidget {
  final String judul;
  final String jumlah;
  const ItemUniv({super.key, required this.judul, required this.jumlah});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: MyColor.abudalamcontainer,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.location_city, color: Colors.white),
        ),
      ),
      title: Text(
        judul,
        style: GoogleFonts.publicSans(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Text(
        jumlah,
        style: GoogleFonts.publicSans(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class HeaderInformation extends StatefulWidget {
  const HeaderInformation({super.key});

  @override
  State<HeaderInformation> createState() => _HeaderInformationState();
}

class _HeaderInformationState extends State<HeaderInformation> {
  List<Widget> data = [
    Expanded(
      child: CardItemContainer(
        aset: MyIcon.icondashboard,
        judul: "Total Client",
        content: '1500',
        color: MyColor.birutua,
      ),
    ),
    Expanded(
      child: CardItemContainer(
        aset: MyIcon.icondashboard,
        judul: "Total Client Bulan Ini",
        content: '1500',
        color: MyColor.oren,
      ),
    ),
    Expanded(
      child: CardItemContainer(
        aset: MyIcon.icondashboard,
        judul: "Total Revenue",
        content: '1500',
        color: MyColor.kuning,
      ),
    ),
    Expanded(
      child: CardItemContainer(
        aset: MyIcon.icondashboard,
        judul: "Profit",
        content: '1500',
        color: MyColor.hijauaccent,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 700
        ? Row(
          spacing: 10,
          mainAxisSize: MainAxisSize.min, children: data)
        : SizedBox(height: 500, child: Column(children: data));
  }
}
