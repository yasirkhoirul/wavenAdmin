import 'package:flutter/material.dart';
import 'package:wavenadmin/common/color.dart';

class OutlinedSearcchBar extends StatelessWidget {
  final Function(String) onSubmitted; 
  final TextEditingController controller;
  const OutlinedSearcchBar({
    super.key, required this.onSubmitted, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 200,
        maxWidth: 400
      ),
      child: SearchBar(
        controller: controller,
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
        onSubmitted: onSubmitted ,
        leading: Icon(Icons.search),
        elevation: WidgetStateProperty.all(0),
        hintText: "Cari",
      ),
    );
  }
}