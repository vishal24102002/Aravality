// ignore: file_names
// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:googleapis/authorizedbuyersmarketplace/v1.dart' as servicecontrol;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'autoLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vishal/initial/login.dart';
import 'package:vishal/initial/login.dart';
import '../pages/Students/web_ymca.dart';
import '../services/mysql_api.dart';
import '../services/notificationService.dart';

bool yes = true;
bool no = false;
bool prop_hide = true;
bool visible_options = false;
bool search_visible = false;
int counter_search = 0;
int counter_add = 0;
int togle_counter = 0;
int theme_conter = 0;
int counter_hide = 0;
bool ena_drawer = false;
String vid_url_start ="https://drive.google.com/uc?export=view&id=";
String network_drive='https://drive.google.com/uc?export=view&id=';
var togel = Icons.toggle_off_outlined;
var _profile_color = [
  Colors.red,
  Colors.deepOrange,
  Colors.purpleAccent,
  Colors.lightBlueAccent,
  Colors.lightGreenAccent,
  Colors.green
];
var colours = [
  Colors.black,
  Colors.white,
  Colors.grey[600],
  Colors.grey[400],
  Colors.lightBlueAccent,
  Colors.redAccent,
  Colors.cyanAccent
];
// late CustomVideoPlayerController _customvidcontroller;
// late VideoPlayerController _vidcontroller;
var roll_no="";
var name="";
int ree = 0;
var course="";
var profile_image_user;
var paid;
bool transporter_agree=false;
var contact=0;

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final storage = FirebaseStorage.instanceFor(bucket: "gs://aravali-34df8.appspot.com");
  var label_color = colours[5];
  String id='1aOGtOhZ4Up72zWoAIPUCniZNdPeknhvX';
  final TextEditingController _edit = TextEditingController();
  final ScrollController _scroll_cont=ScrollController();
  var theme_colour = colours[0];
  var app_bar_color = colours[0];
  var app_container_color = colours[2];
  var text_color = colours[1];
  var container_color = colours[2];
  var but_menu_color = colours[0];
  var icon_data = Icons.person_off;
  var p_value = "OFF";
  var Colour = Colors.black;
  var age = 12;
  final _prof_col = _profile_color[3];
  var storageRef = FirebaseStorage.instance.ref();
  late String user_email;
  final _passwordreset=TextEditingController();

  //fMC code here it is
  Future<String> getAccessTokens() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "aravali-34df8",
      "private_key_id": "38448a5419fbacedca4eb2d5560c706cd9d85821",
      "private_key":
      "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQCZTdZu5jST84oh\n5H/sUDaBIt9C/fJHvsyw7/Kj5s/ahV8olQwTt5RSFOQkyd8U/7sqjjFqVi8sqo9o\n5shtjbCA6lcq4cWFsRnMF9mhRSL5tgEhsdww63v6kR9vlB5C2dgR6oHb1pxM+lxb\nv97v1oIdqACGxEzdu8pt3ROSBbgNu0/mKefxOEPg2MWEKtRJWEiYBD/QZK4rNg8w\nbe/QPzjo7+yhriOV2mto6JrLXCG268s/E0PN8Pn/lXRQs5y9eRyNk7J742iru7pi\n37AcLDvONSEqJVxqJdyAWVTmrWg5JY0y4dYmH2/wo+uo7KBvSs1CE7pU5nUrnyVP\n81613aI7AgMBAAECgf8Bna7S/VpEkDdx3y1QEXH7oFuNGkuMV4G62tEfRgh+GmpO\n2KNHi2jpVnF0lfe4NFGpDJr8Gg9+slqXnG99xPfSFKD9SXXghycga8J1Z94bYCVM\nWkkPudP/2iG6CSBnFOkLdOvUulODYR/PF4V8UVhZvGlgGH17QpAw8xtFxvOb98sp\nGCTn4qEDSzNDmSlPDM4ZPqUPt9+wl9JgZK1c3MrrHy5LnYQv4DxRk6vowO5kRRhK\nHKw80yPtWz/gS3QKsfcyY0fVmaTCEw90r017BvQg+9Elm0IOy9cYoSj7EumHIzP/\nVN9zIXdNej0n0G+yIvL3r2uASZaZQDwqHk2X6gECgYEAyIAch8Sw3UJMINOIiJXp\nifBlGfKosLXMGUmEhtssZrjCpCN1eFyCtnnunKy9zg5faVgCoPNv9DTYttDnM3Qp\nEfxDBKOsoXLWXqy9/rYsW/ud017+V5+ExT6LJ/NGwWfay+5dPsHsAKVFhFIzF+AX\nCfpW6OQwPFrgJVRYViddoKcCgYEAw71KNNefnOMDmGAy/mc6bvguqZTN1jedul8w\ndpgj7Z0ffJ1pBTkvT3SKn1TGcqCQHDrCU1kco+QPrRgD4ADQGEjXw3uZqU8d0v4B\nvVWnST/JH3H/socjq9/Ondite+s3N924rNJaJNKdESwaXkkCgOG/wo2t958r1mHH\nRlBjME0CgYAMhNNDNujEJ+uQ8SRJQvL+BeCKKjiWMAO6YHjB4tV25HpivUQMa9pN\ngnd/mNmREBys+y3O1uRanyIY6BpHgC1ATjvxAjc5LW5tIuQKD13dsGw+UmQXHIKx\nviH6MJpuYQmsSgnQbVNLBwa8KFXAW+GUYekjSXwpiJMOQaHyXyrdaQKBgQC3cvrP\nV58iPKkr8E0ancjoI/YnvWzE7k8HUxtqquBRXEccVbMN0DCE+SbKeXucBtvJeVCT\nKRtshtwiUDWhhWGCwRJnBbpYMewzyRf8SQCF6CApNoB846cM+K7+xQqi7ypLU6Q3\nZNZTWIkYhQsZfre37tv4DS0UvLsrK2zGe6TaqQKBgGYAMPhrUhT1XHrUNu6Py+5P\nkzsKK9HlwzGXePf/VjI6DCttbf4jDYCcJaV3EHEjGkY6JQHOmz9NGd4mzJTvtfJ5\nhapenIaykNjIQXVg7s4CAWaXzgTbkZ7TWEbpib/70fY8rvqGvlyaOtjq3Rv5XB/D\ng+waeRtap+tVhv6bj571\n-----END PRIVATE KEY-----\n",
      "client_email":
      "firebase-adminsdk-6ze4s@aravali-34df8.iam.gserviceaccount.com",
      "client_id": "100175883459965184632",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
      "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
      "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-6ze4s%40aravali-34df8.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    auth.AccessCredentials credentials =
    await auth.obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
        client);
    client.close();
    print("token_data");
    print(credentials.accessToken.data);
    return credentials.accessToken.data;
  }

  Future<void> sendFCMMessage() async {
    final String serverkey = await getAccessTokens();
    const String fcmEndpoint =
        'https://fcm.googleapis.com/v1/projects/aravali-34df8/messages:send';
    final String? currentFCMToken = await FirebaseMessaging.instance.getToken();

    final Map<String, dynamic> message = {
      'message': {
        'token': currentFCMToken,
        'notification': {
          'body': 'this is vishal',
          'title': 'FCM message'
        },
        'data': {'current_user_fcm_token': currentFCMToken}
      }
    };
    final http.Response response24 = await http.post(
      Uri.parse(fcmEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverkey',
      },
      body: jsonEncode(message),
    );
  }
  //end of notification code


  // password reset popup design
  void pass_design_reset(){
    Navigator.of(context).pop();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        title: const Center(child: Text(
          "Reset password",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        )
        ),
        backgroundColor: Colors.white,
        content: const Text(
          "Enter your email & we will send you the password reset link to that email",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          TextField(
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
          const SizedBox(height:10),
          Center(
            child: MaterialButton(
              onPressed:passwordresetlink,
              color: Colors.deepPurple[300],
              height: 45,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: const Text(
                  "Reset password"
              ),
            ),
          ),
        ],
      );
    });
  }


  //funtion for reset password for users
  Future passwordresetlink() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _passwordreset.text.trim());
    } on FirebaseAuthException catch (e){
      print(e);
      Navigator.pop(context);
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
  //end for FCM code here
  void upload_profile() async{
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 72,
    );
    final mountainsRef = FirebaseStorage.instance.ref().child("profile_images/$name.jpg");
    try {
      await mountainsRef.putFile(File(image!.path));
      Navigator.of(context).pop();
      setState(() {});
    } on FirebaseException catch (e) {
      print(e);
    }
    fetch_profile();
    Navigator.of(context).pop();
  }

  void fetch_profile() async{
    try{
    Reference ref=FirebaseStorage.instance.ref().child("profile_images/$name.jpg");
    await ref.getDownloadURL().then((value) {
      profile_image_user=NetworkImage(value);
    });
    } on FirebaseException {
      profile_image_user=const AssetImage('assets/images/pro.jpeg');
    }
    setState(() {});
  }

  void User_Email(){
    if (username.isEmpty){
      user_email=user_email_live;
    }
    else{
      user_email=username;
    }
    setState(() {});
  }

  void getdetail_email() async{
    print(user_email);
    var detail_data = await Getdetails(user_email.toLowerCase());
    var stud_data=jsonDecode(detail_data);
    name=stud_data[0];
    roll_no=stud_data[1];
    course=stud_data[2];
    ree=stud_data[3];
    contact=stud_data[4];
    paid=stud_data[5];
    transporter_agree=stud_data[6];
    fetch_profile();
    setState(() {});
  }

  // trying to add message of flutter
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod: NotificationController.onNotificationCreated,
      onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod
    );
    User_Email();
    if (user_email!="skip"){
      getdetail_email();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Visibility(
        visible: prop_hide,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100.0),
          child: Drawer(
            width: 250,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight:Radius.circular(40.0),bottomRight: Radius.circular(40.0))),
            backgroundColor: Colors.blue[300],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 30, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal:20,vertical: 25),
                    child: CircleAvatar(
                      backgroundImage:profile_image_user,
                      radius: 80,
                      foregroundColor: Colors.red,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                  title: const Text("profile_picture"),
                                  content: const Text("select the profile image from galery"),
                                  backgroundColor: container_color,
                                  actions: [
                                    MaterialButton(
                                        onPressed: (){
                                          upload_profile();
                                        },
                                      color: Colors.blue[300],
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Select Image",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                          Icon(Icons.upload)
                                        ],
                                      ),
                                    ),

                                    MaterialButton(
                                      onPressed: (){
                                        // delete_profile();
                                      },
                                      color: Colors.blue[300],
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Delete Profile Image",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                          Icon(Icons.delete),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },);
                        },
                        hoverColor: Colors.cyanAccent,
                        icon: const Icon(Icons.edit),
                        color: Colors.black87,
                        padding: const EdgeInsets.only(bottom:110,left: 110),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Text(
                              "Name : ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrangeAccent),
                                )),
                            IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: app_bar_color,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                            ),
                                            width: 100,
                                            height : 250,
                                            child: Column(
                                              children: <Widget>[
                                                const Padding(
                                                  padding:EdgeInsets.only(top:15)
                                                ),
                                                const Text(
                                                  " Edit ",
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepOrange,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Text(
                                                  "New Username",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                      color: app_container_color),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.fromLTRB(15,10,15,0,),
                                                  child: TextField(
                                                      style: const TextStyle(color: Colors.white),
                                                      decoration: InputDecoration(
                                                        fillColor: Colors.white,
                                                        border: const OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(5))
                                                        ),
                                                        hintText: "Enter new username",
                                                        hintStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                                                      ),
                                                      keyboardType: TextInputType.name,
                                                      controller: _edit,
                                                      enabled: true),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        name = _edit.text;
                                                        Navigator.pop(context);
                                                        _scaffoldKey
                                                            .currentState
                                                            ?.openDrawer();
                                                      });
                                                    },
                                                    child: const Text(
                                                      "Submit",
                                                    )),
                                              ],
                                            )),
                                      ));
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "Age : ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$age yr',
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "Roll No :  ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            roll_no,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "Reappears :  ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            '$ree',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "Contact :  ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            contact.toString(),
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "Branch :  ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            course.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
                          },
                          child: const Text("Sign-Out"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawerEnableOpenDragGesture: ena_drawer,
      endDrawer: Container(
        decoration: BoxDecoration(
          color: colours[3],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), bottomLeft: Radius.circular(40)),
        ),
        width: 250.0,
        margin: const EdgeInsets.fromLTRB(0, 85, 0, 55),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 70, 75, 30),
              child: Text(
                "Settings",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.blue[600],
                ),
              ),
            ),
            Card(
              elevation: 0.0,
              color: colours[3],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        GestureDetector(
                          onTap: () => profile_view(),
                          child: Text(
                            "Profile $p_value",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: ()=>profile_view(),
                          icon: Icon(icon_data),
                          color: Colour,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        GestureDetector(
                          onTap: ()=>pass_design_reset(),
                          child: const Text(
                            "Reset-PIN",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        IconButton(
                          onPressed: () =>pass_design_reset(),
                          icon: const Icon(Icons.pin_rounded),
                          color: colours[0],
                        ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1),
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        GestureDetector(
                          onTap: ()=>change_theme(),
                          child: const Text(
                            "Theme",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        IconButton(
                          onPressed: ()=>change_theme(),
                          icon: const Icon(Icons.brightness_6),
                          color: theme_colour,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        const Text(
                          "Prof-Slider",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                togle_counter = togle_counter + 1;
                                if (togle_counter % 2 == 0) {
                                  togel = Icons.toggle_on_outlined;
                                  ena_drawer = true;
                                } else {
                                  togel = Icons.toggle_off_outlined;
                                  ena_drawer = false;
                                }
                              });
                            },
                            icon: Icon(togel,size: 40,),
                            color: colours[0],
                            iconSize: 40),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        AwesomeNotifications().createNotification(content: NotificationContent(
                          id: 1,
                          channelKey: "testing",
                          title: "good",
                          body:"boya are good"
                        ));
                        showDialog(
                            context: context,
                            builder: (context) {
                              var star1=Icons.star_border;
                              var star2=Icons.star_border;
                              var star3=Icons.star_border;
                              var star4=Icons.star_border;
                              var star5=Icons.star_border;
                              var Color1=Colors.black;
                              var Color2=Colors.black;
                              var Color3=Colors.black;
                              var Color4=Colors.black;
                              var Color5=Colors.black;
                              return StatefulBuilder
                                (builder: (BuildContext context,StateSetter setState){
                                  return AlertDialog(
                                    backgroundColor:app_container_color ,
                                    alignment: Alignment.center,
                                    title: const Text("Rate-us 😊😊",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    content:const TextField(
                                          maxLines: null,
                                          keyboardType: TextInputType.multiline,
                                          textAlign: TextAlign.start,
                                        ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          IconButton(onPressed: (){
                                            star1=Icons.star_rate;
                                            Color1=Colors.amberAccent;
                                            setState(() {
                                            });
                                          }, icon: Icon(star1,size: 35,color: Color1,)),
                                          IconButton(onPressed: (){
                                            star1=Icons.star_rate;
                                            star2=Icons.star_rate;
                                            Color1=Colors.amberAccent;
                                            Color2=Colors.amberAccent;
                                            setState(() {});
                                          }, icon: Icon(star2,size: 35,color: Color2,)),
                                          IconButton(onPressed: (){
                                            star3=Icons.star_rate;
                                            star1=Icons.star_rate;
                                            star2=Icons.star_rate;
                                            Color1=Colors.amberAccent;
                                            Color2=Colors.amberAccent;
                                            Color3=Colors.amberAccent;
                                            setState(() {});
                                          }, icon: Icon(star3,size: 35,color: Color3,)),
                                          IconButton(onPressed: (){
                                            star3=Icons.star_rate;
                                            star1=Icons.star_rate;
                                            star2=Icons.star_rate;
                                            star4=Icons.star_rate;
                                            Color1=Colors.amberAccent;
                                            Color2=Colors.amberAccent;
                                            Color3=Colors.amberAccent;
                                            Color4=Colors.amberAccent;
                                            setState(() {});
                                          }, icon: Icon(star4,size: 35,color: Color4,)),
                                          IconButton(onPressed: (){
                                            star3=Icons.star_rate;
                                            star1=Icons.star_rate;
                                            star2=Icons.star_rate;
                                            star4=Icons.star_rate;
                                            star5=Icons.star_rate;
                                            Color5=Colors.amberAccent;
                                            Color1=Colors.amberAccent;
                                            Color2=Colors.amberAccent;
                                            Color3=Colors.amberAccent;
                                            Color4=Colors.amberAccent;
                                            setState(() {});
                                          }, icon: Icon(star5,size: 35,color: Color5,)),
                                        ],
                                      ),
                                      const SizedBox(height:15),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap:(){
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              "cancel",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),
                                            ),
                                          ),
                                          const SizedBox(),
                                          GestureDetector(
                                            child: const Text(
                                                "submit",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                              },);
                            },);
                      },
                      style: const ButtonStyle(
                        fixedSize:
                            WidgetStatePropertyAll(Size.fromWidth(205)),
                      ),
                      icon: const Icon(Icons.star_rate_outlined),
                      label: const Text("Rate-US"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(context: context, builder: (context){
                          return const AlertDialog(
                            title: Text("😩😩 Help 😩😩",textAlign:TextAlign.center,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                            content: Text("For help please contact us at the below email or check our website"),
                            actions: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("Email:- vishalsharma@acem.edu.in",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),

                                  ],
                              ),
                            ],
                          );
                        },);
                      },
                      style: const ButtonStyle(
                        fixedSize:
                            WidgetStatePropertyAll(Size.fromWidth(205)),
                      ),
                      icon: const Icon(Icons.help),
                      label: const Text("Help"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text("Website:- https://vishal6596.pythonanywhere.com/about",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                              );
                            },);
                      },
                      style: const ButtonStyle(
                        fixedSize:
                            MaterialStatePropertyAll(Size.fromWidth(205)),
                      ),
                      icon: const Icon(Icons.supervised_user_circle_rounded),
                      label: const Text("About-Us"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: app_bar_color,
        title: Card(
            margin: const EdgeInsets.fromLTRB(0, 25, 0, 20),
            elevation: 0.0,
            color: app_bar_color,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "ARAVALi",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: label_color),
                    ),
                  ],
                ),
                Text(
                  "College of Engg. & Management",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                      color: text_color),
                ),
              ],
            )),
        centerTitle: true,
        leading: Visibility(
          visible: prop_hide,
          child: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(Icons.person_pin,size: 43,color: text_color,),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                counter_search = counter_search + 1;
                if (counter_search % 2 == 1) {
                  search_visible = true;
                } else {
                  search_visible = false;
                }
              });
            },
            icon: Icon(Icons.search,color: text_color,size: 30,),
          ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: Icon(Icons.settings,size: 30,color: text_color,),
          ),
        ],
      ),
      extendBody: true,
      body: Container(
        color: container_color,
        child: SizedBox(
          width: 900,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: search_visible,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  width: 400,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3.5),
                      shape: BoxShape.rectangle,
                      color: Colors.black,
                      borderRadius: const BorderRadius.all(Radius.circular(35.0))),
                  child: SearchBar(
                    onSubmitted: (value) {
                    },
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                    leading: const Icon(
                      Icons.search,
                      color: Colors.white,
                      weight: 12,
                    ),
                    backgroundColor: const WidgetStatePropertyAll(
                      Colors.black,
                    ),
                    hintText: "Search",
                    textStyle: const WidgetStatePropertyAll(
                      TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                    child:Padding(
                      padding: const EdgeInsets.all(40),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: _scroll_cont,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.network(network_drive+id,height: 375,width: 340,),
                            // SizedBox(height:300,width: 20,),
                          // AnimatedContainer(
                          //       alignment: Alignment.center,
                          //         // color: Colors.black,
                          //         margin: EdgeInsets.only(left:85,right:85),
                          //         width:170,
                          //         duration: Duration(seconds: 1),
                          //         child: SizedBox(
                          //             width:175,
                          //             child: VideoPlayer(_vidcontroller)
                          //         )
                          // )
                          ],
                        ),
                      ),
                    ),
                  ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
                  child: Container(
                    color: app_container_color,
                    width: 550,
                    height: 260,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: but_menu_color,
                                      child: IconButton(
                                        onPressed: () => {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                color: colours[0],
                                                height: 150,
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Web_ymca()));
                                                            },
                                                          style: const ButtonStyle(
                                                            fixedSize:
                                                                WidgetStatePropertyAll(
                                                              Size(400, 50),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                              "YMCA-Result")),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator
                                                                .pushNamed(
                                                                    context,
                                                                    '/report');
                                                          },
                                                          style: const ButtonStyle(
                                                            fixedSize:
                                                                WidgetStatePropertyAll(
                                                              Size(400, 50),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                              "Sessionals")),
                                                    ]),
                                              );
                                            },
                                          )
                                        },
                                        icon: const Icon(Icons.pending_actions,
                                            color: Colors.white, size: 30),
                                      ),
                                    ),
                                    Text(
                                      "Report",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: text_color),
                                    )
                                  ]),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: but_menu_color,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/teachers');
                                        },
                                        icon: Icon(
                                          Icons.person_pin_rounded,
                                          color: colours[1],
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Teachers",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: text_color),
                                    )
                                  ]),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: but_menu_color,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/notice');
                                        },
                                        icon: const Icon(
                                          Icons.event_note,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Notice",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: text_color),
                                    )
                                  ]),
                            ]),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: but_menu_color,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/calender');
                                      },
                                      icon: const Icon(
                                        Icons.calendar_month_outlined,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Calender",
                                    style: TextStyle(
                                        color: text_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: but_menu_color,
                                    radius: 25,
                                    child: IconButton(
                                      onPressed: ()=>transporter(),
                                      icon: const Icon(
                                        Icons.directions_bus,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Transport",
                                    style: TextStyle(
                                        color: text_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ]),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: but_menu_color,
                                    child: IconButton(
                                        onPressed: () {
                                          Future.delayed(const Duration(milliseconds: 400), () {
                                            Navigator.pushNamed(context, '/payment_gateway');
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.currency_rupee_outlined,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                    ),
                                  ),
                                  Text(
                                    "Fee-Payment",
                                    style: TextStyle(
                                        color: text_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: but_menu_color,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/fee_receipt');
                                      },
                                      icon: const Icon(
                                        Icons.receipt_long,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Fee Receipt",
                                    style: TextStyle(
                                        color: text_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: but_menu_color,
                                    child: const Icon(
                                      Icons.assignment,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Assignments",
                                    style: TextStyle(
                                        color: text_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ]),
                          ],
                        ),
                            const SizedBox(
                              height: 15,
                            ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                          Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius:25,
                                  backgroundColor: but_menu_color,
                                  child: const Icon(
                                    Icons.question_mark_sharp,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                  Text(
                                  "Previous Year",
                                  style: TextStyle(
                                      color: text_color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                  ),
                                  Text(
                                    "Paper",
                                    style: TextStyle(
                                        color: text_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                  ],),
                              ],
                          ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius:25,
                                  backgroundColor: but_menu_color,
                                  child: const Icon(
                                    Icons.view_comfortable_sharp,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Timetable",
                                  style: TextStyle(
                                      color: text_color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ],),
                          ],
                      ),
                      ]),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: visible_options,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                  child: Card(
                    color: container_color,
                    elevation: 0.0,
                    child: Column(children: <Widget>[
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.chat,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.black),
                          fixedSize:
                              WidgetStatePropertyAll(Size.fromWidth(305.0)),
                        ),
                        label: const Text("Message"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          sendFCMMessage();
                        },
                        icon: const Icon(Icons.task_alt, color: Colors.yellow),
                        style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.black),
                          fixedSize:
                              WidgetStatePropertyAll(Size.fromWidth(305.0)),
                        ),
                        label: const Text(" Book "),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                counter_add = counter_add + 1;
                if (counter_add % 2 == 1) {
                  visible_options = true;
                } else {
                  visible_options = false;
                }
              });
            },
            backgroundColor: app_bar_color,
            hoverColor: Colors.grey,
        child: Text(
          "+",
          style: TextStyle(color: text_color, fontSize: 30),
        ),
          ),
    );
  }

  change_theme() {
    setState(() {
      theme_conter = theme_conter + 1;
      if (theme_conter % 2 == 1) {
        container_color = colours[1];
        app_container_color = container_color;
        app_bar_color = colours[6];
        text_color = colours[0];
        theme_colour = colours[1];
      } else {
        container_color = colours[2];
        app_container_color = container_color;
        app_bar_color = colours[0];
        text_color = colours[1];
        theme_colour = colours[0];
      }
    });
  }

  profile_view() {
    setState(() {
      counter_hide = counter_hide + 1;
      if (counter_hide % 2 == 1) {
        icon_data = Icons.person;
        ena_drawer = false;
        Colour = Colors.white;
        prop_hide = ena_drawer;
        p_value = "On  ";
      } else {
        icon_data = Icons.person_off;
        Colour = Colors.black;
        prop_hide = true;
        ena_drawer = prop_hide;
        p_value = "OFF";
      }
    });
  }

  transporter() {
    if (transporter_agree==true){
      print(transporter_agree);
      Navigator.pushNamed(context, '/transport');
    }
  }
}