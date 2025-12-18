import 'package:flutter/material.dart';
import 'package:wavenadmin/common/color.dart';

class Carditemsinglecontainer extends StatelessWidget{
  final List<Widget>? header;
  final Widget content;
  const Carditemsinglecontainer({super.key,this.header, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColor.abucontainer,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: header??[]
            ),
            Expanded(child:content 
            )
          ],
        ),
      ),
    );
    
  }
}
class CarditemsinglecontainerWithBorder extends StatelessWidget{
  final List<Widget>? header;
  final Widget content;
  const CarditemsinglecontainerWithBorder({super.key,this.header, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: const BorderSide(
      color: Color(0xFF595959),  // warna border
      width: 0.8,             // ketebalan border
    ),
  ),
      color: MyColor.abucontainer,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: header??[]
            ),
            Expanded(child:content 
            )
          ],
        ),
      ),
    );
    
  }
}