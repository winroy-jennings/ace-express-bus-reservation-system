import 'package:flutter/material.dart';

class ViewPayment extends StatefulWidget {
  const ViewPayment({super.key});

  @override
  State<ViewPayment> createState() => _ViewPaymentState();
}

class _ViewPaymentState extends State<ViewPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Payment"),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text("View Payment"),
      ),
    );
  }
}
