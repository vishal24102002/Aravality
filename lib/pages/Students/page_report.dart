import 'package:flutter/material.dart';
import 'package:vishal/services/mysql_api.dart';
import 'dart:convert';

class Report extends StatefulWidget {
  const Report({super.key});
  @override
  State<Report> createState() => _ReportState();
}

bool _result_visiblity = false;
var pas = "fail";
var check = [];
var data1;

class _ReportState extends State<Report> {
  TextEditingController entry_roll = TextEditingController();
  late String url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.amber,
        shadowColor: Colors.transparent,
        title: const Text(
          "Result",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
      body: Container(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          child: Column(children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: const Text(
                "Sessionals",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
              child: const ListTile(
                title: Text("Course",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                subtitle: TextField(
                    enabled: true,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        hintText: "course name",
                        hintStyle:
                            TextStyle(textBaseline: TextBaseline.alphabetic),
                        alignLabelWithHint: false)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25, top: 5),
              child: ListTile(
                title: const Text("Roll-NO.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                subtitle: TextField(
                    onChanged: (value) {
                      url =
                          '/retreive_rollno?Query=${entry_roll.text}';
                    },
                    controller: entry_roll,
                    enabled: true,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      hintText: "roll - No.     ",
                    )),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                data1 = await GetReport(url);
                var dataDecode = jsonDecode(data1);
                var studentRoll = dataDecode['result'].toList();
                print(studentRoll[0]);
                setState(() {
                  _result_visiblity = true;
                });
              },
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.amber),
                  minimumSize: WidgetStatePropertyAll(Size(195, 40))),
              child: const Text(
                "Search",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Expanded(
              child: AnimatedContainer(
                width: 350,
                height: 375,
                padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                duration: const Duration(seconds: 1),
                color: Colors.transparent,
                child: Visibility(
                  visible: _result_visiblity,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Result : $pas",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
