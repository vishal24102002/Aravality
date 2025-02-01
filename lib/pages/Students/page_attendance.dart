import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Widget> _students = [];
final GlobalKey _listkey = GlobalKey();

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List student=[];
  List<String> data_list_sub=['Course'];
  String teacher="";
  String Selected_item= 'Course';

  Future<List<String>> get_subjects() async {
    http.Response subList=await http.get(Uri.parse("https://vishal6596.pythonanywhere.com/subjects?teacher=$teacher"));
    var subListNew=subList.body;
    data_list_sub=jsonDecode(subListNew);
    return data_list_sub;
  }

  @override
  void initState() {

    get_subjects();
    // TODO: implement initState
    super.initState();
  }

  Future _addstudent() async{
    http.Response stu=await http.get(Uri.parse("https://script.google.com/macros/s/AKfycbyLP_86xx1CuVEhnlAdIKvinFQ_-p_a81UQdnEoxbPAOhK3sKX-5IY9ZAGW-v451g87/exec"));
    student =jsonDecode(stu.body);
    print(student);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color.fromRGBO(251, 139, 36, 50),
        shadowColor: Colors.transparent,
        title: const Center(
          child: Text(
            "Attendance",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      extendBody: true,
      body: Container(
        color: Colors.black,
        child: Center(
          child: SizedBox(
            height: 200,
            width: 300,
            child: Card(
              child: Column(
                children: [
                  const SizedBox(height: 8,),
                  const Text("Lecture Details"),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(width:2,color: Colors.blueAccent)
                        )
                      ),
                      value:Selected_item,
                      items:data_list_sub.map((item)=>DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                      )).toList(),
                      onChanged: (item)=>setState(()=> Selected_item=item!),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({super.key});

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<WidgetState> states) {
      const Set<WidgetState> interactiveStates = <WidgetState>{
        WidgetState.pressed,
        WidgetState.hovered,
        WidgetState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: WidgetStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
