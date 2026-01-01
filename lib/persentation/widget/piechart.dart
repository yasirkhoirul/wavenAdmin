import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/domain/entity/dashboard.dart';

class PieChartExample extends StatelessWidget {
  final List<KeyValueEntity> data;
  const PieChartExample({super.key, required this.data});

  // Warna-warna yang berbeda untuk setiap section
  static const List<Color> chartColors = [
    Color(0xFF4CAF50), // Green
    Color(0xFF2196F3), // Blue
    Color(0xFFFF9800), // Orange
    Color(0xFFF44336), // Red
    Color(0xFF9C27B0), // Purple
    Color(0xFF00BCD4), // Cyan
    Color(0xFFFFEB3B), // Yellow
    Color(0xFF795548), // Brown
    Color(0xFFE91E63), // Pink
    Color(0xFF009688), // Teal
  ];

  Color _getColor(int index) {
    return chartColors[index % chartColors.length];
  }

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
                ...data.asMap().entries.map((entry) {
                  int index = entry.key;
                  KeyValueEntity item = entry.value;
                  return PieChartSectionData(
                    color: _getColor(index),
                    value: (item.value * 10).toDouble(),
                    radius: 80,
                  );
                }),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              ...data.asMap().entries.map((entry) {
                int index = entry.key;
                KeyValueEntity item = entry.value;
                return ColorLabelRow(
                  color: _getColor(index),
                  label: item.key,
                );
              }),
            ],
          ),
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
