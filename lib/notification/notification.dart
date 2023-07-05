import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class Noti {
  static Future initialize (FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin ) async {
    var androidIntialize = const AndroidInitializationSettings('mipmap/ic_launcher');
    var initialzationsSettings = InitializationSettings(android: androidIntialize);
    await flutterLocalNotificationsPlugin.initialize(initialzationsSettings);
  }
  static Future showBigTextNotification ({var id=0 , required String title ,required String body ,
  required FlutterLocalNotificationsPlugin fln , var payload ,})
  async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails('channel 3', 'channelName',
        playSound:  true,
         importance:  Importance.max ,
         priority: Priority.high ,
        );
 var not = NotificationDetails(android: androidPlatformChannelSpecifics,

 );
 await fln.show(0, title, body, not);
  }
}
