import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';

class CardItemContainer extends StatelessWidget {
  final Color color;
  final String aset;
  final String judul;
  final String content;
  final String? subcontent;
  const CardItemContainer({
    super.key,
    required this.aset,
    required this.judul,
    required this.content,
    this.subcontent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColor.abucontainer,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              spacing: 10,
              children: [
                SvgPicture.asset(
                  aset,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
                Expanded(
                  child: Text(
                    judul,
                    style: GoogleFonts.publicSans(color: color),
                  ),
                ),
              ],
            ),
            Text(
              content,
              style: GoogleFonts.publicSans(color: Colors.white, fontSize: 28),
              textAlign: TextAlign.end,
            ),
            if (subcontent != null)
              Text(
                subcontent!,
                style: GoogleFonts.publicSans(color: MyColor.abudalamcontainer, fontSize: 14),
                textAlign: TextAlign.end,
              ),
          ],
        ),
      ),
    );
  }
}
