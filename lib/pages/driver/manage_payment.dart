import 'package:flutter/material.dart';

class ManagePayment extends StatefulWidget {
  const ManagePayment({super.key});

  @override
  State<ManagePayment> createState() => _ManagePaymentState();
}

class _ManagePaymentState extends State<ManagePayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Payment"),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text("Manage Payment"),
      ),
    );
  }
}
