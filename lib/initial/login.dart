import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vishal/initial/new%20home.dart';
import 'package:vishal/services/mysql_api.dart';
import 'package:vishal/services/service.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


String username=_usercontroller.text.toString();
TextEditingController _usercontroller = TextEditingController();
TextEditingController _passcontroller = TextEditingController();
bool error = false;
bool _passwordVisible = true;

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  void dispose() {
    _usercontroller.dispose();
    _passcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _usercontroller.clear();
    _passcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.black,
          child:Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "L",
                            style: TextStyle(fontSize: 40,
                                color: Colors.indigo),
                          ),
                          Text(
                            "o",
                            style: TextStyle(fontSize: 40, color: Colors.blue),
                          ),
                          Text(
                            "g",
                            style: TextStyle(fontSize: 40, color: Colors.green),
                          ),
                          Text(
                            "i",
                            style: TextStyle(fontSize: 40,
                                color: Colors.yellow),
                          ),
                          Text(
                            "n",
                            style: TextStyle(fontSize: 40, color: Colors.red),
                          ),
                          Text(
                            "-",
                            style:
                            TextStyle(fontSize: 40, color: Colors.greenAccent),
                          ),
                          Text(
                            "P",
                            style:
                            TextStyle(fontSize: 40, color: Colors.cyanAccent),
                          ),
                          Text(
                            "a",
                            style: TextStyle(
                                fontSize: 40, color: Colors.lightBlueAccent),
                          ),
                          Text(
                            "g",
                            style: TextStyle(fontSize: 40, color: Colors.amber),
                          ),
                          Text(
                            "e",
                            style:
                            TextStyle(fontSize: 40, color: Colors.deepOrange),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 100,
                  ),
                  TextField(
                    autocorrect: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      hintText: "College-Email",
                      hintStyle: const TextStyle(
                          color: Colors.white, decorationColor: Colors.black),
                      fillColor: Colors.grey,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    maxLines: 1,
                    controller: _usercontroller,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    obscureText: !_passwordVisible,
                    maxLines: 1,
                    controller: _passcontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      hintText: "College-Email-password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme
                              .of(context)
                              .primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      hintStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    style: const ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          side: BorderSide(width: 5, color: Colors.white),
                        ))),
                    child: const SizedBox(
                      width: 200,
                      height: 50,
                      child: Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: error,
                    child: const Text(
                      " -> try using correct credential",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  GestureDetector(
                    onTap: () {
                      username="skip";
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const NewHome(),));
                    },
                    child: const Text(
                        " Skip login ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),

                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }

  void _login() async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child:LoadingAnimationWidget.fourRotatingDots(
          color: Colors.green,
          size: 50,
        ),
      ),
    );
    User? user = await _auth.signInWithEmailAndPassword(_usercontroller.text.toLowerCase().toString(),_passcontroller.text.toString());
    if (user != null) {
      var data=await GetRole(_usercontroller.text.toLowerCase().toString());
      var roleType = jsonDecode(data);
      Navigator.of(context).pop();
      Navigator.pop(context);
      username=_usercontroller.text.toString();
      print(username);
      if (roleType[0]=="Teacher") {
        Navigator.of(context).pushNamed('/home_admin');
      }
      else if (roleType[0]=="Student"){
        Navigator.of(context).pushNamed('/home');
      }
    }
    else {
      Navigator.of(context).pop();
      setState(() {
        _usercontroller.clear();
        _passcontroller.clear();
        error = true;
      });
    }
  }
}

