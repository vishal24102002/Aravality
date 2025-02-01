import 'package:flutter/material.dart';
import 'package:vishal/initial/Admin_home.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {

  void get_profile() async {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("profile picture")
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: (){
            print(name);
            // upload_profile();
          },
          child: const Text("click me"),
        ),
      ),
    );
  }
}
