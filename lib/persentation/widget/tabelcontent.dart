import 'package:flutter/material.dart';

class TabelContent extends StatelessWidget {
  const TabelContent({
    super.key,
    required this.dataColumnUser,
    required this.datarow,
  });

  final List<DataColumn> dataColumnUser;
  final List<DataRow> datarow;

  @override
  Widget build(BuildContext context,) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(15),
      child: Container(
        
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300.withAlpha(50),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: DataTable(
          dataRowMinHeight: 48,
          border: TableBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          headingRowColor: WidgetStateColor.resolveWith(
            (states) => Color(0xFF313131),
          ),
          columns: dataColumnUser,
          rows: datarow,
        ),
      ),
    );
  }
}
