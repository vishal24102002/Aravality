import 'package:flutter/material.dart';

import '../../initial/Admin_home.dart';

class NewNotice extends StatefulWidget {
  const NewNotice({super.key});

  @override
  State<NewNotice> createState() => _NewNoticeState();
}

class _NewNoticeState extends State<NewNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("Add-Notice"),
        toolbarHeight: 92,
        backgroundColor: app_bar_color,
      ) ,
      body: Container(
        color: container_color,
      ),
      extendBodyBehindAppBar: true,
    );
  }
}

