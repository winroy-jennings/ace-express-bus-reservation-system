import 'package:flutter/material.dart';

class ClientAccountant extends StatefulWidget {
  const ClientAccountant({super.key});

  @override
  State<ClientAccountant> createState() => _ClientAccountantState();
}

class _ClientAccountantState extends State<ClientAccountant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Client Accountant"),
      ),
      body: const Center(
        child: Text("Client Accountant"),
      ),
    );
  }
}
