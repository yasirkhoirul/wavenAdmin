import 'package:flutter/material.dart';
import 'package:wavenadmin/common/color.dart';

class OutlinedSearcchBar extends StatelessWidget {
  final Function(String) onSubmitted; 
  const OutlinedSearcchBar({
    super.key, required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) => Colors.transparent,
      ),
      shape: WidgetStateProperty.resolveWith(
        (states) => RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
          side: BorderSide(
            color: MyColor.abudalamcontainer,
            width: 1,
          ),
        ),
      ),
      onSubmitted: (value) => onSubmitted,
      leading: Icon(Icons.search),
      elevation: WidgetStateProperty.all(0),
      hintText: "Cari",
    );
  }
}