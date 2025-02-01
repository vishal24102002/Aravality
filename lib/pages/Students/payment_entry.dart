import 'package:flutter/material.dart';

class Gateway extends StatefulWidget {
  const Gateway({super.key});

  @override
  State<Gateway> createState() => _GatewayState();
}

List<String> stream_list_btech = <String>['select','CSE', 'CSE-AIML', 'EC', 'Mech'];
List<String> course_list = <String>['select','B-Tech', 'BBA', 'MBA', 'BCA'];

String dropdownValue = course_list.first;
String dropdownValue_stream = stream_list_btech.first;
bool visibl=false;

class _GatewayState extends State<Gateway> {
  final TextEditingController _rollcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text("Gate-Way"),
      ),
      body: Center(
        child: Expanded(
          flex: 1,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      ExactAssetImage("assets/images/ara.jpeg", scale: 0.7),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 45),
                  child: Text(
                    "A.C.E.M.",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      " Course :",
                      style: TextStyle(color: Colors.black, fontSize: 19),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    DropdownButton(
                      value: dropdownValue,
                      elevation: 0,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      menuMaxHeight: 175,
                      // dropdownColor: Colors.lightGreenAccent[400],
                      autofocus: true,
                      focusColor: Colors.green,
                      style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      items: course_list
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                          if (dropdownValue =="B-Tech"){
                            visibl=true;
                          }
                          else{
                            visibl=false;
                          }
                        });
                      },
                    )
                  ],
                ),
                Visibility(
                  visible: visibl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        " Stream :",
                        style: TextStyle(color: Colors.black, fontSize: 19),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      DropdownButton(
                        value: dropdownValue_stream,
                        elevation: 0,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        menuMaxHeight: 195,
                        // dropdownColor: Colors.lightGreenAccent[400],
                        autofocus: true,
                        dropdownColor: Colors.lightGreenAccent,
                        style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        items: stream_list_btech
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue_stream = value!;
                          });
                        },
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Roll-no. :",
                      style: TextStyle(color: Colors.black, fontSize: 19),
                    ),
                    SizedBox(
                      width: 170,
                      height: 40,
                      child: TextField(
                        obscureText: false,
                        controller: _rollcontroller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Roll-No',
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () {
                      String userroll = _rollcontroller.text;
                      if (userroll.length>=7){
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/payment');
                      }
                      else if (userroll.isEmpty){
                        print("error !!!");
                      }
                    },
                    style: const ButtonStyle(fixedSize: WidgetStatePropertyAll(Size(200,50))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.currency_rupee_outlined,
                        ),
                        Text(" PAY NOW ")
                      ],
                    )),
              ]),
        ),
      ),
    );
  }
}
