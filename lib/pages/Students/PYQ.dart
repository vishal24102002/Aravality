import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PYQViewPage extends StatefulWidget {
  @override
  _PYQViewPageState createState() => _PYQViewPageState();
}

class _PYQViewPageState extends State<PYQViewPage> {
  String selectedSemester = "Semester 1"; // Default semester
  List<String> semesters = ["Semester 1", "Semester 2", "Semester 3", "Semester 4"];
  Map<String, List<Map<String, String>>> pyqData = {
    "Semester 1": [
      {"title": "Mathematics", "file": "maths.pdf"},
      {"title": "Physics", "file": "physics.pdf"}
    ],
    "Semester 2": [
      {"title": "Data Structures", "file": "ds.pdf"},
      {"title": "Digital Logic", "file": "dl.pdf"}
    ],
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> pyqList = pyqData[selectedSemester] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Previous Year Papers"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedSemester,
              onChanged: (String? newValue) {
                setState(() {
                  selectedSemester = newValue!;
                });
              },
              items: semesters.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: GoogleFonts.poppins(fontSize: 16)),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pyqList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Icon(Icons.picture_as_pdf, color: Colors.red),
                    title: Text(pyqList[index]["title"]!, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    subtitle: Text(pyqList[index]["file"]!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.visibility, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFViewScreen(pyqList[index]["file"]!),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.download, color: Colors.green),
                          onPressed: () async {
                            await downloadPDF(pyqList[index]["file"]!);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> downloadPDF(String fileName) async {
    Directory? directory = await getExternalStorageDirectory();
    String filePath = "${directory?.path}/$fileName";

    // Simulate download
    File file = File(filePath);
    await file.writeAsBytes([]);  // Dummy empty file

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Downloaded: $fileName")),
    );
  }
}

class PDFViewScreen extends StatelessWidget {
  final String filePath;
  PDFViewScreen(this.filePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View PDF")),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}
