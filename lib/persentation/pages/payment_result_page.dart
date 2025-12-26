import 'package:flutter/material.dart';


class PaymentResultPage extends StatelessWidget {
  final String? orderId;
  const PaymentResultPage(this.orderId, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("resulst page"),
    );
  }
}
