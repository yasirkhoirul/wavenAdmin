import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';

class XlButtonWeb extends StatelessWidget {
  final IconData? icon;
  final String teks;
  final Color? color;
  final VoidCallback ontap;
  const XlButtonWeb({
    required this.ontap,
    super.key,
    this.icon,
    required this.teks,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 47, minWidth: 168),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          backgroundColor: color ?? MyColor.hijauaccent,
        ),
        onPressed: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? Icon(icon, color: Colors.white, size: 30)
                : Container(),
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

class XlButtonMobile extends StatelessWidget {
  final IconData? icon;
  final String teks;
  final Color? color;
  final VoidCallback ontap;
  const XlButtonMobile({
    required this.ontap,
    super.key,
    this.icon,
    required this.teks,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 42, minWidth: 157),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          backgroundColor: color ?? MyColor.hijauaccent,
        ),
        onPressed: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? Icon(icon, color: Colors.white, size: 24)
                : Container(),
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

class LButtonWeb extends StatelessWidget {
  final IconData? icon;
  final String teks;
  final VoidCallback? ontap;
  final Color? color;
  const LButtonWeb({
    required this.ontap,
    super.key,
    this.icon,
    required this.teks, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints( minHeight: 42),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            backgroundColor: color??MyColor.hijauaccent,
          ),
          onPressed: ontap,
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: icon != null
                ? <Widget>[
                    Icon(icon, color: Colors.white, size: 24),
                    Text(
                      teks,
                      style: GoogleFonts.robotoFlex(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                : [
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
      ),
    );
  }
}

class LBUttonMobile extends StatelessWidget {
  final IconData? icon;
  final String teks;
  final VoidCallback? ontap;
  final Color? color;
  const LBUttonMobile({
    required this.ontap,
    super.key,
    this.icon,
    required this.teks, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 121, minHeight: 36),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            backgroundColor:color?? MyColor.hijauaccent,
          ),
          onPressed: ontap,
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: icon != null
                ? <Widget>[
                    Icon(icon, color: Colors.white, size: 18),
                    Text(
                      teks,
                      style: GoogleFonts.robotoFlex(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                : [
                    Text(
                      teks,
                      style: GoogleFonts.robotoFlex(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}

class MButtonWeb extends StatelessWidget {
  final IconData? icon;
  final String teks;
  final VoidCallback? ontap;
  final Color? color;
  const MButtonWeb({
    required this.ontap,
    super.key,
    this.icon,
    required this.teks,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 122, minHeight: 21),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            backgroundColor: color ?? MyColor.hijauaccent,
          ),
          onPressed: ontap,
          child: Row(
            spacing: 4,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: icon != null
                ? <Widget>[
                    Icon(icon, color: Colors.white, size: 17),

                    Text(
                      teks,
                      style: GoogleFonts.robotoFlex(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                : [
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
      ),
    );
  }
}

class MButtonMobile extends StatelessWidget {
  final IconData? icon;
  final String teks;
  final VoidCallback? ontap;
  final Color? color;
  const MButtonMobile({
    required this.ontap,
    super.key,
    this.icon,
    required this.teks,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 78),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            backgroundColor: color ?? MyColor.hijauaccent,
          ),
          onPressed: ontap,
          child: Row(
            spacing: 4,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: icon != null
                ? <Widget>[
                    Icon(icon, color: Colors.white, size: 17),
                    Text(
                      teks,
                      style: GoogleFonts.robotoFlex(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                : [
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
      ),
    );
  }
}
