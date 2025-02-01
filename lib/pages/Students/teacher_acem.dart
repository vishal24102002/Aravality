import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vishal/services/mysql_api.dart';
import '../../initial/Home.dart';

class MyTeachers extends StatefulWidget {
  const MyTeachers({super.key});

  @override
  State<MyTeachers> createState() => _MyTeachersState();
}

class _MyTeachersState extends State<MyTeachers> {
  final List<Widget> _teachers = [];
  final GlobalKey _listkey = GlobalKey();

  @override
  void initState() {
    _addTeacher();
    super.initState();
  }


  Future _addTeacher() async {
    await Future.delayed(const Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (context)=>Center(child: LoadingAnimationWidget.newtonCradle(color: Colors.red, size:130)),
        );
    var teacher=await Getteachers(course);
    var teacher0 = jsonDecode(teacher);
    teacher0.forEach((teach) {
      _teachers.add(_buildTile(teach));
    });
    Navigator.of(context).pop();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          toolbarHeight: 125,
          foregroundColor: Colors.white,
          backgroundColor: Colors.purple,
          title:const Center(
              child: Text(
                      "My-Teachers",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  ),
            ),
          ),
        extendBody: true,
        body:Container(
          child: Column(
            children: [
              Expanded(
                child:ListView.builder(
              key: _listkey,
              itemCount: _teachers.length,
              itemBuilder: (context, index) {
                return _teachers[index];
              }
              ),
              ),
            ],
          ),
        ),
    );
  }

  Widget _buildTile(teach) {
    var id =teach[2];
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.all(10),
      subtitle: Column(
        children: [
          Text(teach[1], style: const TextStyle(fontSize: 14),),
        ],
      ),
      leading: const Icon(Icons.account_circle_outlined,size: 35,),
        title: Text(teach[0],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

        trailing: Text('$id'),
    );
  }
}