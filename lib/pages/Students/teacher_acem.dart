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
  final List<dynamic> _teachers = [];
  bool _isLoading = true; // ✅ Track loading state

  @override
  void initState() {
    super.initState();
    _fetchTeachers();
  }

  Future<void> _fetchTeachers() async {
    try {
      var teacherData = await Getteachers(course); // Ensure 'course' is defined
      var teacherList = jsonDecode(teacherData);

      setState(() {
        _teachers.clear();
        _teachers.addAll(teacherList.map((teach) => _buildTile(teach)).toList());
        _isLoading = false; // ✅ Hide loading animation after data is loaded
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error fetching teachers: $e"),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isLoading = false; // Hide loading animation on error
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        toolbarHeight: 90,
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
        title: const Text(
          "My-Teachers",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? Center(
        child: LoadingAnimationWidget.newtonCradle(
          color: Colors.red,
          size: 130,
        ),
      )
          : _teachers.isEmpty
          ? const Center(
        child: Text(
          "No teachers available",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        itemCount: _teachers.length,
        itemBuilder: (context, index) {
          return _teachers[index];
        },
      ),
    );
  }

  Widget _buildTile(dynamic teach) {
    var id = teach[2];
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.all(10),
      subtitle: Column(
        children: [
          Text(teach[1], style: const TextStyle(fontSize: 14)),
        ],
      ),
      leading: const Icon(Icons.account_circle_outlined, size: 35),
      title: Text(
        teach[0],
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      trailing: Text('$id'),
    );
  }
}
