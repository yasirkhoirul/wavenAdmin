import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PieChartExample extends StatelessWidget {
  const PieChartExample({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 0,
              sections: [
                PieChartSectionData(color: Colors.green, value: 40, radius: 80),
                PieChartSectionData(color: Colors.cyan, value: 30, radius: 80),
                PieChartSectionData(color: Colors.orange, value: 10, radius: 80),
                PieChartSectionData(
                  color: Colors.lightGreen,
                  value: 20,
                  radius: 80,
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            ColorLabelRow(color: Colors.green, label: "Work"),
            ColorLabelRow(color: Colors.cyan, label: "Work"),
            ColorLabelRow(color: Colors.orange, label: "Work"),
            ColorLabelRow(color: Colors.lightGreen, label: "Work"),
          ],
        ),
      ],
    );
  }
}

class ColorLabelRow extends StatelessWidget {
  final Color color;
  final String label;
  final double dotSize;
  final double spacing;
  final TextStyle? textStyle;

  const ColorLabelRow({
    super.key,
    required this.color,
    required this.label,
    this.dotSize = 14,
    this.spacing = 8,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: spacing),
        Text(
          label,
          style:
              textStyle ??
              GoogleFonts.publicSans(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
