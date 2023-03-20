
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_music_app/UI/notificationbadge.dart';
import 'package:fl_music_app/UI/product_categoryScreen.dart';
import 'package:fl_music_app/UI/product_homeScreen.dart';
import 'package:fl_music_app/UI/user_profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';
import '../models/searchproducts.dart';


class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({Key? key}) : super(key: key);

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('A Background message just showed up :  ${message.messageId}');
  }
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    //  om message app open
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
              channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_lancher',
              ),
            ));
      }
    });
    //Message for Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new messageopen app event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  // registerNotification();
  }

  void showNotification() {
    setState(() {
      _counter++;
    });

    flutterLocalNotificationsPlugin.show(
        0,
        "This is Push message",
        "Flutter Push Notification alert message",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name,channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

// late final FirebaseMessaging _messaging;
//   late int _totalNotificationCounter;
//   PushNotification? _notificationinfo;
//
//   void registerNotification() async{
//     await Firebase.initializeApp();
//
//     _messaging=FirebaseMessaging.instance;
//
//     NotificationSettings settings=await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       provisional: false,
//       sound: true,
//     );
//
//     if(settings.authorizationStatus==AuthorizationStatus.authorized){
//       print("user granted permission");
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         PushNotification notification=PushNotification(
//           title: message.notification!.title,
//           body: message.notification!.body,
//           dataTitle: message.data['title'],
//           dataBody: message.data['body'],
//         );
//         setState(() {
//           _totalNotificationCounter++;
//           _notificationinfo=notification;
//         });
//
//         if(notification!=null){
//         showSimpleNotification(
//           Text(_notificationinfo!.title.toString()),
//           leading: NotificationBadge(totalNotification: _totalNotificationCounter),
//           subtitle: Text(_notificationinfo!.body.toString()),
//           background: Colors.cyan.shade700,
//           duration: Duration(seconds: 3)
//
//         );
//         }
//       });
//     }
//       else{
//         print("permission declined by user");
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(centerTitle: true,title: Text("Machine Task"),),
        body: Column(
          children: [
            TabBar(tabs: [
              Tab(
                icon: Icon(Icons.home,color: Colors.deepPurple,),
                child: Text('Home',style: TextStyle(
                  color: Colors.black87,
                ),),
              ),
              Tab(
                icon: Icon(Icons.category,color: Colors.deepPurple,),
                child: Text('Product Category ',style: TextStyle(
                  color: Colors.black87,
                ),),
              ),
              Tab(
                icon: Icon(Icons.person_pin,color: Colors.deepPurple,),
                child: Text('User Profile',style: TextStyle(
                  color: Colors.black87,
                ),),
              ),
            ]),
            Expanded(
              child: TabBarView(children: [
                ProductHomeScreen(),
                ProductCategory(),
                Userprofile(),
              ]),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: showNotification,
          tooltip: 'Increment',
          child: Text('Push '),
        ),
      ),

    );
  }
}
