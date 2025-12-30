import 'package:flutter/material.dart';
import 'package:wavenadmin/common/color.dart';



class Mychip extends StatelessWidget {
  final Color? color;
  final String label;
  const Mychip({required this.label ,this.color,super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color ?? MyColor.hijauaccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}