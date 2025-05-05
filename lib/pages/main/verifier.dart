import 'package:flutter/material.dart';

class Verifier extends StatefulWidget {
  const Verifier({super.key});

  @override
  State<Verifier> createState() => _VerifierState();
}

class _VerifierState extends State<Verifier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verifier"),
      ),
      body: const Center(
        child: Text("Verifier"),
      ),
    );
  }
}
