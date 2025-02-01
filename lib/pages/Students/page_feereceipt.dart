import 'package:flutter/material.dart';

class Fee extends StatefulWidget {
  const Fee({super.key});

  @override
  State<Fee> createState() => _FeeState();
}

class _FeeState extends State<Fee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        shadowColor: Colors.transparent,
        title: const Center(
          child: Text(
            "Fee-Details",
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
