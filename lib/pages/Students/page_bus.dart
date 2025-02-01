import 'package:flutter/material.dart';
import 'package:vishal/initial/Home.dart';

class BusPass extends StatefulWidget {
  const BusPass({super.key});

  @override
  State<BusPass> createState() => _BusPassState();
}

class _BusPassState extends State<BusPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.pink[300],
        title: const Center(

          child: Text(
            "Buss-Pass",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        color: Colors.pink[200],
        child: Center(
          child: AnimatedContainer(
            width: 325,
            curve: Curves.bounceInOut,
            duration: const Duration(seconds: 1),
            color: Colors.pink[200],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 25),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.pink[400],
                      radius: 70,
                      foregroundColor: Colors.white,
                      child: const Center(
                        child: Icon(
                          Icons.account_circle,
                          size: 130,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  color: Colors.pink[400],
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                         const Row(
                          children: [
                            SizedBox(width: 240,),
                            Text(
                              "Route: 5",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                          child: ListTile(
                              isThreeLine: false,
                              leading: const Text(
                                "Roll No:",
                                style: TextStyle(
                                  fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.start,
                              ),
                              trailing: Text(
                                roll_no,
                                style: const TextStyle(fontSize: 20),
                              )),
                        ),
                        SizedBox(
                          height: 25,
                          child: ListTile(
                            leading: const Text(
                              "Name:",
                              style: TextStyle(
                                fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.start,
                            ),
                            trailing: Text(
                              name,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                          child: ListTile(
                            leading: Text("Contact No:",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.start),
                            trailing: Text("8882083822",style: TextStyle(fontSize: 20,),textAlign:TextAlign.start,),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        SizedBox(
                          height: 55,
                          child: ListTile(
                            leading: const Text("Valid For: 2023-24",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end),
                            trailing: CircleAvatar(
                               radius: 20,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                    child: Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green[800],
                                  size: 50,
                                ))),
                          ),
                        ),
                        const SizedBox(height:25),
                      ]
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
