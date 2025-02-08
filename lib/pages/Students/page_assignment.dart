import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class Assignment extends StatefulWidget {
  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  String selectedSemester = "Semester 1";
  String selectedClass = "CSE-A";

  List<String> semesters = ["Semester 1", "Semester 2", "Semester 3"];
  List<String> classes = ["CSE-A", "CSE-B", "CSE-C"];

  List<Map<String, dynamic>> assignmentsList = [];

  @override
  void initState() {
    super.initState();
    fetchAssignments();
  }

  // 🔹 Fetch assignments from Google Sheets
  Future<void> fetchAssignments() async {
    try {
      String url = "https://script.google.com/macros/s/YOUR_SCRIPT_ID/exec?semester=$selectedSemester&class=$selectedClass";
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          assignmentsList = List<Map<String, dynamic>>.from(data);
        });
      }
    } catch (e) {
      print("Error fetching assignments: $e");
    }
  }

  // 🔹 Upload file (Simulated)
  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      print("Uploading: ${file.path}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Assignment submitted successfully!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Assignments")),
      body: Column(
        children: [
          // 🔹 Dropdowns for Semester & Class Selection
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: selectedSemester,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedSemester = newValue;
                      fetchAssignments();
                    });
                  }
                },
                items: semesters.map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
              ),
              SizedBox(width: 20),
              DropdownButton<String>(
                value: selectedClass,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedClass = newValue;
                      fetchAssignments();
                    });
                  }
                },
                items: classes.map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
              ),
            ],
          ),
          Expanded(
            child: assignmentsList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: assignmentsList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(assignmentsList[index]["subject"]),
                    subtitle: Text("Due Date: ${assignmentsList[index]["due_date"]}"),
                    trailing: ElevatedButton(
                      onPressed: uploadFile,
                      child: Text("Submit"),
                    ),
                    onTap: () async {
                      String url = assignmentsList[index]["assignment_link"];
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        print("Could not open link");
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
