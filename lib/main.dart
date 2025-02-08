import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vishal/initial/Admin_home.dart';
import 'package:vishal/initial/autoLogin.dart';
import 'package:vishal/initial/Home.dart';
import 'package:vishal/pages/Students/page_Notice.dart';
import 'package:vishal/pages/Students/page_bus.dart';
import 'package:vishal/pages/Students/page_calender.dart';
import 'package:vishal/pages/Students/page_feereceipt.dart';
import 'package:vishal/pages/Students/page_report.dart';
import 'package:vishal/pages/Students/page_timetable.dart';
import 'package:vishal/pages/Students/payment.dart';
import 'package:vishal/pages/Students/teacher_acem.dart';
import 'package:vishal/pages/Students/page_assignment.dart';
import 'package:vishal/pages/Students/PYQ.dart';
import 'common pages/message.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBCX-B7WgIm5o7Lsja_VO5jmskGmOu4D-Q',
      appId: "1:846353640998:android:5450ed4122bb6f5bd180e7",
      projectId: "aravali-34df8",
      messagingSenderId: "AIzaSyBCX-B7WgIm5o7Lsja_VO5jmskGmOu4D-Q",
      storageBucket: "aravali-34df8.appspot.com",
    ),
  );

  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.playIntegrity,
  // );

  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: "testing",
        channelName: "basic",
        channelDescription: "trial",
        playSound: true,
        onlyAlertOnce: true,
        groupAlertBehavior: GroupAlertBehavior.Children,
        importance: NotificationImportance.High,
        defaultPrivacy: NotificationPrivacy.Private,
        defaultColor: Colors.deepPurple,
        ledColor: Colors.deepPurple
      )
    ],
    debug: true
  );

  bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isNotificationAllowed) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const AutoLogin(),
        '/home_admin': (context) => const Admin_home(),
        '/home': (context) => const Home(),
        '/teachers': (context) => const MyTeachers(),
        '/bus': (context) => const BusPass(),
        '/notice': (context) => const Notice(),
        '/calender': (context) => const Calender(),
        '/report': (context) => const Report(),
        '/fee_receipt': (context) => const Fee(),
        '/assignment': (context) => Assignment(),
        '/payment': (context) => const Pay(),
        '/payment_gateway': (context) => const Pay(),
        '/transport': (context) => const BusPass(),
        '/chat':(context)=> Message_chat(),
        '/timetable':(context)=> TimetablePage(),
        '/pyq':(context)=> PYQViewPage()
      },
    );
  }
}