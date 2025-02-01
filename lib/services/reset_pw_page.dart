import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class passwordreset extends StatefulWidget {
  const passwordreset({super.key});

  @override
  State<passwordreset> createState() => _passwordresetState();
}

class _passwordresetState extends State<passwordreset> {
  final _passwordreset=TextEditingController();

  @override
  void dispose() {
    _passwordreset.dispose();
    super.dispose();
  }

  Future passwordresetlink() async {

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _passwordreset.text.trim());
    } on FirebaseAuthException catch (e){
      print(e);
      showDialog(
          context: context,
          builder:(context){
            return AlertDialog(
              actions: [
                MaterialButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  color: Colors.deepPurple[300],
                  child: const Text("OK"),
                ),
              ],
              content:Text(e.message.toString()),
            );
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
                "Enter your email & we will send you the password reset link to that email",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              autocorrect: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25)),
                hintText: "College-Email",
                hintStyle: const TextStyle(
                    color: Colors.black, decorationColor: Colors.black),
                fillColor: Colors.grey,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              controller: _passwordreset,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          MaterialButton(
              onPressed:passwordresetlink,
            color: Colors.deepPurple[300],
            child: const Text(
                "Reset password"
              ),
          ),
        ],
      ),
    );
  }
}
