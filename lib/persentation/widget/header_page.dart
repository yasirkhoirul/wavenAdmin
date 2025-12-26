import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';

class HeaderPage extends StatelessWidget {
  final String judul;
  final String icon;
  const HeaderPage({super.key, required this.judul, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
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