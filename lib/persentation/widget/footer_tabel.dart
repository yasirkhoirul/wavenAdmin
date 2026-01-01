import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/persentation/widget/button.dart';

class FooterTabel extends StatelessWidget {
  final int? jumlahPage;
  final Function()? back;
  final Function()? next;
  final int currentPage;
  const FooterTabel({
    super.key,
    required this.back,
    required this.next,
    required this.jumlahPage,
    required this.currentPage,
  });
  @override
  Widget build(BuildContext context) {
    List<Widget> dataList = [
      Expanded(
        child: Text(
          "Jumlah Page ${jumlahPage ?? 0}",
          style: GoogleFonts.robotoFlex(fontWeight: FontWeight.bold),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          MediaQuery.of(context).size.width > 900
              ? MButtonWeb(ontap: back, teks: "Kembali")
              : MButtonMobile(ontap: back, teks: "Kembali"),
          Text(
            "$currentPage",
            style: GoogleFonts.robotoFlex(fontWeight: FontWeight.bold),
          ),
          MediaQuery.of(context).size.width > 900
              ? MButtonWeb(ontap: next, teks: "Berikutnya")
              : MButtonMobile(ontap: next, teks: "Berikutnya"),
        ],
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: MediaQuery.of(context).size.width > 900
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: dataList,
            )
          : ConstrainedBox(
              constraints: BoxConstraints(minHeight: 50, maxHeight: 70),
              child: Column(children: dataList),
            ),
    );
  }
}