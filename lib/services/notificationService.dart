import 'package:awesome_notifications/awesome_notifications.dart';

// @pragma('vm:entry-point')
// Future<void> _myBackgroundMessageHandler(RemoteMessage message) async {
//   print('Handling a background message ${message.messageId}, ${message.notification!.title}');
// }
//
// class NotificationHelper{
//   static String fcmtoken="";
//   static Future<void> initialize() async {
//     await getTokensToSendNotification();
//     FirebaseMessaging.instance.getInitialMessage().then((message){
//       print("FirebaseMessaging.instance.getInitialMessage");
//       if (message!=null){
//         print("new notification");
//       }
//     });
//
//     FirebaseMessaging.onBackgroundMessage(_myBackgroundMessageHandler);
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       print("------------------");
//       print("-----------${message.notification!.body}-------------");
//       print("-------------------------------------");
//       if (message.notification != null) {
//         AwesomeNotifications().createNotification(content: NotificationContent(
//             id: DateTime.now().millisecondsSinceEpoch~/1000,
//           channelKey: "testing",
//           title: message.notification!.title,
//           body: message.notification!.body
//         ));
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       print("FirebaseMessaging.onMessageOpenedApp");
//       if (message.notification != null) {
//         print(message.data);
//         print(message.notification!.title);
//         print(message.notification!.body);
//       }
//     });
//   }
//
//   static Future<void> getTokensToSendNotification() async{
//     FirebaseMessaging.instance.getToken().then((token) {
//       fcmtoken=token.toString();
//       print(fcmtoken);
//     });
//   }
// }

class NotificationController{
  @pragma( 'vm:entry-point')
  static Future<void> onNotificationCreated(ReceivedNotification receivedNotification) async {}

  @pragma('vm:entry-point')
  static Future<void> onNotificationDisplayedMethod (ReceivedNotification receivedNotification) async {}

  @pragma('vm:entry-point')
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {}

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {}
}