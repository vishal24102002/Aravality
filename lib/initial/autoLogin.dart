import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vishal/initial/login.dart';
import '../services/mysql_api.dart';

class AutoLogin extends StatefulWidget {
  const AutoLogin({super.key});
  @override
  State<AutoLogin> createState() => _AutoLoginState();
}
late String user_email_live;
class _AutoLoginState extends State<AutoLogin> {
   // ❌ Removed `late` to prevent null issues

  Future<void> loginValidationRecheck() async {
    try {
      var data = await GetRole(user_email_live!);
      var roleType = jsonDecode(data);

      if (!mounted) return; // ✅ Prevents calling setState after widget disposal
      Navigator.pop(context);

      if (roleType[0] == "Teacher") {
        Navigator.pushNamed(context, '/home_admin');
      } else if (roleType[0] == "Student") {
        Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No Internet Connection", style: TextStyle(color: Colors.white))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            user_email_live = snapshot.data!.email!; // ✅ No more `late` issues
            loginValidationRecheck();

            return Container(
              color: Colors.black,
              width: double.infinity, // ✅ Fixed width issue
              height: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: ExactAssetImage("assets/images/ara.jpeg", scale: 0.7),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Aravality",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    Dialog(
                      backgroundColor: Colors.black,
                      alignment: Alignment.center,
                      child: Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
