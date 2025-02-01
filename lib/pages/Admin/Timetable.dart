import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Timetable extends StatefulWidget {
  const Timetable({super.key});

  @override
  State<Timetable> createState() => _TimetableState();
}

late String savedPath;
String url_link =
    "https://script.googleusercontent.com/macros/echo?user_content_key=D5uXSqo_ERY9tp1TkZBYhE9CVLOZ9FYSMIojcfDcvR248mP3S9tqWZmqt7YFXWTDilD9QASVdiRv8jSfMVV8y60nGXGZb-KFm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnL1vPvFQ_RUVkWSimPJ_lH6fBZ8NYV8KmnGYRpbaJn-lo4NC8em2yFcfFgoXsBeQqygJefR81mTYHsk82PEej5zSPVxZeDhzb9z9Jw9Md8uu&lib=MUZk2DHoW_2ear-AKi5xqudbNCSvIPR8A";
List report = [];
// var file_location;
// double? _progress;

class _TimetableState extends State<Timetable> {
  var url_link_extracted;
  List<List<dynamic>> excelData = [];
  
  Future GetList() async{
    http.Response extractList=await http.get(Uri.parse("https://vishal6596.pythonanywhere.com/worksheet/urls"));
    return extractList.body;
  }

  // Future GetLink() async {
  //   http.Response extract_url = await http.get(Uri.parse(url_link));
  //   var url_link_extracted = jsonDecode(extract_url.body);
  //   http.Response obtained_url =
  //       await http.get(Uri.parse(url_link_extracted[0]['url']));
  //   return obtained_url.body;
  // }
  //
  // Future Download_excel() async {
  //   http.Response extract_url = await http.get(Uri.parse(url_link));
  //   var url_link_extracted = jsonDecode(extract_url.body);
  //   var url=url_link_extracted[0]['url']+'download_excel';
  //   var status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     String path= await FilePicker.platform.getDirectoryPath() ?? '';
  //     if (path.isNotEmpty){
  //       savedPath='$path/time_table.xlsx';
  //       log(savedPath);
  //       try{
  //         await Dio().download(url,savedPath);
  //         log('saved to given location');
  //       }on DioError catch (e){
  //         log(e.message.toString());
  //       }
  //       log('saved to given location');
  //     }
  //     print('Storage permission granted');
  //   } else {
  //     print('Storage permission denied');
  //   }
  //   print("downloaded");
  // }
  //
  // Future<List<List<dynamic>>> readExcel() async {
  //   // Path to your Excel file
  //   // log("saved file = $savedPath");
  //   var bytes = File("/storage/emulated/0/Download/P.xlsx").readAsBytesSync();
  //   if (bytes != null) {
  //     var excel = Excel.decodeBytes(bytes);
  //     List<List<List<dynamic>>> allData = [];
  //     for (var table in excel!.tables.values) {
  //       print(table);
  //       List<List<dynamic>> data = [];
  //       for (var row in table.rows) {
  //         data.add(row.toList()); // Converting row to a list
  //       }
  //       allData.add(data);
  //     }
  //     return allData;
  //     }
  //   return [];
  // }

  Future<void> preprocess() async{
    // showDialog(context: context, builder: (context) => Center(
    //   child:LoadingAnimationWidget.fourRotatingDots(
    //   color: Colors.green,
    //   size: 50,
    // ),
    // ),
    // );
    var data = await GetList();
    report = jsonDecode(data);
    // Navigator.of(context).pop();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preprocess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          title: const Text(
            "Time-tables",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.purpleAccent,
        ),
        body: Container(
          color: Colors.grey[300],
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 70,
          child: Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
              child:ListView.builder(
                  itemCount: report.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                        startActionPane: ActionPane(
                        motion: const StretchMotion(),
                    children:[
                    SlidableAction(
                    backgroundColor:Colors.greenAccent,
                    icon: Icons.remove_red_eye_outlined,
                    onPressed: (context) {
                      Navigator.push(context,MaterialPageRoute(builder: (context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text(report[index][0],style: const TextStyle(fontWeight: FontWeight.bold),),
                            elevation: 0.0,
                            backgroundColor: Colors.black,
                            toolbarHeight: 115,
                          ),
                          extendBody: false,
                          body: Container(
                            child: WebViewWidget(
                              controller: WebViewController()
                                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                                ..loadRequest(Uri.parse(report[index][1])),
                            ),
                          ),
                        );
                      },
                      )
                      );

                    // Navigator.push(context, MaterialPageRoute(builder:(context) => const ttable_view(),));
                    },)
                    ]
                    ),
                    child: Card(
                      margin:
                          const EdgeInsets.only(bottom: 10, left: 5, right: 5, top: 5),
                      elevation: 2.0,
                      child: ListTile(
                        title: Text(
                          report[index][0],
                        ),
                        subtitle: Text(report[index][1],style: const TextStyle(fontSize: 10,color: Colors.lightBlueAccent),),
                      ),
                    ));
                  },
                ),
              ),
            ),
          ),
      extendBody: true,

        );
  }
}
