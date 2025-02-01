import 'package:flutter/material.dart';

class Notice extends StatefulWidget {
  const Notice({super.key});
  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
      shadowColor: Colors.transparent,
      title: const Center(
        child: Text(
        "Notice",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
        ),
      ),
    ),
    );
  }
}
