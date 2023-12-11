import 'package:flutter/material.dart';

class Trending extends StatefulWidget {
  const Trending({super.key});

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trending")),
      body: const Center(
          child: Text(
        "Trending Screen",
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}
