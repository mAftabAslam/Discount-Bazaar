import 'package:flutter/material.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saved")),
      body: const Center(
          child: Text(
        "Saved Screen",
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}
