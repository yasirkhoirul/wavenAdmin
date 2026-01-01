import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/domain/entity/dashboard.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/dashboard/dashboard_state.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/cardItemSingleContainer.dart';
import 'package:wavenadmin/persentation/widget/carditemcontainer.dart';
import 'package:wavenadmin/persentation/widget/piechart.dart';

String _formatCurrency(int amount) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return formatter.format(amount);
}

class Dashboardpage extends ConsumerWidget {
  const Dashboardpage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(getDashboardStateProvider);

    return state.when(
      data: (data) => Center(
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
                        HeaderInformation(data: data,),
                        Expanded(child: MainContent(dashboardEntity: data,)),
                      ],
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                      HeaderInformation(data: data,),
                      MainContent(dashboardEntity: data,),
                    ],
                  ),
                ),
              ),
      ),
      error: (error, stackTrace) => Center(
        child: Column(
          children: [
            Text(error.toString()),
            MButtonWeb(ontap: (){
              ref.invalidate(getDashboardStateProvider);
            }, teks: "coba lagi")
          ],
        ),
      ),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
    
  }
}

class MainContent extends StatefulWidget {
  final DashboardEntity dashboardEntity;
  const MainContent({super.key, required this.dashboardEntity});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  List<Widget> data() => [
    Expanded(
      child: Column(
        spacing: 10,
        children: [
          Expanded(
            child: CardItemContainer(
              aset: MyIcon.icondashboard,
              judul: "Total Bookings",
              content: widget.dashboardEntity.totalBookings.toString(),
              color: Colors.white,
            ),
          ),
          Expanded(
            child: CardItemContainer(
              aset: MyIcon.icondashboard,
              judul: "Perlu Verifikasi",
              content: widget.dashboardEntity.bookingNeedVerification.toString(),
              color: MyColor.oren,
            ),
          ),
          Expanded(
            child: CardItemContainer(
              aset: MyIcon.icondashboard,
              judul: "Belum Assign Fotografer",
              content: widget.dashboardEntity.bookingNeedPhotographer.toString(),
              color: MyColor.hijauaccent,
            ),
          ),
          Expanded(
            child: CardItemContainer(
              aset: MyIcon.icondashboard,
              judul: "Belum Upload Foto",
              content: widget.dashboardEntity.bookingNeedUploadPhoto.toString(),
              color: MyColor.birutua,
            ),
          ),
        ],
      ),
    ),
    Expanded(
      child: Carditemsinglecontainer(
        content: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              ...widget.dashboardEntity.bookingPerUniversity.map((e) => ItemUniv(judul: e.key, jumlah: e.value.toString()),),
            ],
          ),
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
        content: SizedBox(
          height: 600,
          child: PieChartExample(data: widget.dashboardEntity.bookingPerPackage,)),
      ),
    ),
  ];
  
  List<Widget> _buildMobileGrid() => [
    CardItemContainer(
      aset: MyIcon.icondashboard,
      judul: "Total Bookings",
      content: widget.dashboardEntity.totalBookings.toString(),
      color: Colors.white,
    ),
    CardItemContainer(
      aset: MyIcon.icondashboard,
      judul: "Perlu Verifikasi",
      content: widget.dashboardEntity.bookingNeedVerification.toString(),
      color: MyColor.oren,
    ),
    CardItemContainer(
      aset: MyIcon.icondashboard,
      judul: "Belum Assign Fotografer",
      content: widget.dashboardEntity.bookingNeedPhotographer.toString(),
      color: MyColor.hijauaccent,
    ),
    CardItemContainer(
      aset: MyIcon.icondashboard,
      judul: "Belum Upload Foto",
      content: widget.dashboardEntity.bookingNeedUploadPhoto.toString(),
      color: MyColor.birutua,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 700
        ? Row(spacing: 20, children: data())
        : Column(
            spacing: 20,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemCount: _buildMobileGrid().length,
                itemBuilder: (context, index) => _buildMobileGrid()[index],
              ),
              Carditemsinglecontainer(
                content: Column(
                  spacing: 10,
                  children: [
                    ...widget.dashboardEntity.bookingPerUniversity.map((e) => ItemUniv(judul: e.key, jumlah: e.value.toString()),),
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
              Carditemsinglecontainer(
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
                content: SizedBox(
                  height: 500,
                  child: PieChartExample(data: widget.dashboardEntity.bookingPerPackage,)),
              ),
            ],
          );
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
  final DashboardEntity data;
  const HeaderInformation({super.key, required this.data});

  @override
  State<HeaderInformation> createState() => _HeaderInformationState();
}

class _HeaderInformationState extends State<HeaderInformation> {
  
  List<Widget> data() => [
    Expanded(
      child: CardItemContainer(
        aset: MyIcon.icondashboard,
        judul: "Total Client",
        content: widget.data.totalClients.toString(),
        color: MyColor.birutua,
      ),
    ),
    Expanded(
      child: CardItemContainer(
        aset: MyIcon.icondashboard,
        judul: "Total Client Bulan Ini",
        content: widget.data.totalClientsThisMonth.toString(),
        color: MyColor.oren,
      ),
    ),
    Expanded(
      child: CardItemContainer(
        aset: MyIcon.icondashboard,
        judul: "Total Revenue",
        content: _formatCurrency(widget.data.totalRevenue),
        color: MyColor.kuning,
      ),
    ),
    Expanded(
      child: CardItemContainer(
        aset: MyIcon.icondashboard,
        judul: "Profit",
        content: _formatCurrency(widget.data.totalProfit),
        color: MyColor.hijauaccent,
      ),
    ),
  ];

  List<Widget> _buildMobileHeaderGrid() => [
    CardItemContainer(
      aset: MyIcon.icondashboard,
      judul: "Total Client",
      content: widget.data.totalClients.toString(),
      color: MyColor.birutua,
    ),
    CardItemContainer(
      aset: MyIcon.icondashboard,
      judul: "Total Client Bulan Ini",
      content: widget.data.totalClientsThisMonth.toString(),
      color: MyColor.oren,
    ),
    CardItemContainer(
      aset: MyIcon.icondashboard,
      judul: "Total Revenue",
      content: _formatCurrency(widget.data.totalRevenue),
      color: MyColor.kuning,
    ),
    CardItemContainer(
      aset: MyIcon.icondashboard,
      judul: "Profit",
      content: _formatCurrency(widget.data.totalProfit),
      color: MyColor.hijauaccent,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 700
        ? Row(spacing: 10, mainAxisSize: MainAxisSize.min, children: data())
        : GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
            ),
            itemCount: _buildMobileHeaderGrid().length,
            itemBuilder: (context, index) => _buildMobileHeaderGrid()[index],
          );
  }
}
