import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';

class XlButtonWeb extends StatelessWidget {
  final IconData? icon;
  final String teks;
  final VoidCallback ontap;
  const XlButtonWeb({
    required this.ontap,
    super.key,
    this.icon,
    required this.teks,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 170,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: MyColor.hijauaccent),
        onPressed: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null ? Icon(icon, color: Colors.white,size: 30,) : Container(),
            Text(
              teks,
              style: GoogleFonts.robotoFlex(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class LButtonWeb extends StatelessWidget {
  final IconData? icon;
  final String teks;
  final VoidCallback ontap;
  const LButtonWeb({
    required this.ontap,
    super.key,
    this.icon,
    required this.teks,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
       height: 42,
      width: 157,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColor.hijauaccent),
        onPressed: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null ? Icon(icon, color: Colors.white,size: 24,) : Container(),
            Text(
              teks,
              style: GoogleFonts.robotoFlex(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MButtonWeb extends StatelessWidget {
  final IconData? icon;
  final String teks;
  final VoidCallback ontap;
  final Color? color;
  const MButtonWeb({
    required this.ontap,
    super.key,
    this.icon,
    required this.teks,
    this.color 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 122,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color??MyColor.hijauaccent),
        onPressed: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null ? Icon(icon, color: Colors.white,size: 17,) : Container(),
            Text(
              teks,
              style: GoogleFonts.robotoFlex(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
