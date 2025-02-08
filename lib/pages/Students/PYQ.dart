import 'dart:convert';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../services/mysql_api.dart';
import 'package:http/http.dart' as http;

class PYQViewPage extends StatefulWidget {
  @override
  _PYQViewPageState createState() => _PYQViewPageState();
}

class _PYQViewPageState extends State<PYQViewPage> {
  String selectedSemester = "Semester 1"; // Default semester
  List<String> semesters = [
    "Semester 1", "Semester 2", "Semester 3", "Semester 4",
    "Semester 5", "Semester 6", "Semester 7", "Semester 8"
  ];

  List<Map<String, dynamic>> pyqList = []; // ✅ Fix: Defined at class level

  @override
  void initState() {
    super.initState();
    getFiles(); // ✅ Call function in initState
  }

  void getFiles() async {
    try {
      var _data = await GetPyq(selectedSemester);
      var rawData = jsonDecode(_data);

      if (rawData is List) {
        setState(() {
          pyqList = List<Map<String, dynamic>>.from(rawData);
        });
      }
    } catch (e) {
      print("Error fetching files: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Text("Previous Year Papers", style: GoogleFonts.poppins(fontSize: 20)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedSemester,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedSemester = newValue;
                    getFiles(); // ✅ Refresh data on semester change
                  });
                }
              },
              items: semesters.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: GoogleFonts.poppins(fontSize: 16)),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: pyqList.isEmpty
                ? Center(child: CircularProgressIndicator()) // ✅ Show loader if empty
                : ListView.builder(
              itemCount: pyqList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Icon(Icons.picture_as_pdf, color: Colors.red),
                    title: Text(pyqList[index]["name"] ?? "Unknown File",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold)
                    ),
                    // subtitle: Text(pyqList[index]["url"] ?? "No URL"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.visibility, color: Colors.blue),
                          onPressed: () {
                            String? fileUrl = pyqList[index]["url"].toString().replaceAll("drivesdk", "sharing");

                            print("file url for viewing is as follows $fileUrl");
                            if (fileUrl != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PDFViewScreen(fileUrl),
                                ),
                              );
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.download, color: Colors.green),
                          onPressed: () async {
                            String? getFileId(String url) {
                              RegExp regExp = RegExp(r"/d/([-\w]+)");
                              Match? match = regExp.firstMatch(url);
                              return match?.group(1); // Returns FILE_ID if found, else null
                            }

                            String? fileId = getFileId(pyqList[index]["url"]);


                            if (fileId != null) {
                              print("File ID: $fileId");
                            } else {
                              print("Invalid URL");
                            }

                            String fileUrl="https://drive.google.com/uc?export=download&id=$fileId";
                            String? fileName = pyqList[index]["name"];

                            if (fileUrl != null) {
                              print("file url for the download option is this one $fileUrl");
                              await downloadPDF(fileUrl,fileName!);
                            }
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

  Future<void> downloadPDF(String fileUrl,String fileName) async {
    // final status = await Permission.storage.request();
    // setState(() {
    //   print(status);
    //   // print(_permissionStatus);
    // });
    // if (status.isDenied) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Storage permission is required to download files")),
    //   );
    // }
    try {
      Directory? downloadsDirectory = Directory('/storage/emulated/0/Download');

      if (!downloadsDirectory.existsSync()) {
        downloadsDirectory = await getApplicationDocumentsDirectory(); // Fallback
      }

      // Create the "Aravality" folder inside Downloads
      Directory aravalityFolder = Directory("${downloadsDirectory.path}/Aravality");
      if (!aravalityFolder.existsSync()) {
        aravalityFolder.createSync(recursive: true);
      }

      String filePath = "${aravalityFolder.path}/$fileName";

      var response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode == 200) {
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Downloaded: $filePath")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Download failed: ${response.statusCode}")),
        );
      }
    } catch (e) {
      print("Download error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error downloading file")),
      );
    }
  }
}

class PDFViewScreen extends StatelessWidget {
  final String fileUrl;
  PDFViewScreen(this.fileUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF-Viewer")),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(fileUrl)),
      ),
    );
  }
}
