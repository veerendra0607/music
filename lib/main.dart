import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_music_app/UI/auth_page.dart';
import 'package:fl_music_app/UI/songs_screen.dart';
import 'package:fl_music_app/widgets/playlistCard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'UI/HomeTab_screen.dart';
import 'UI/home_screen.dart';
import 'UI/playlist.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

// flutter local notification
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

// firebase background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A Background message just showed up :  ${message.messageId}');
}
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// Firebase local notification plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

//Firebase messaging
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    //   MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: HomeDesign(key: navigatorKey,)
    // );

        GetMaterialApp(
        // scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.white, displayColor: Colors.white)),
        home: HomeDesign(),
        getPages: [
          GetPage(name: '/', page: () => HomeDesign()),
          GetPage(name: '/song', page: () => SongsScreen()),
          GetPage(name: '/playlist', page: () => SongsScreen()),
        ],
        );


  }
}

class HomeDesign extends StatelessWidget {
  const HomeDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }
        if (snapshot.hasData) {
          return HomeTabScreen();
        } else {
          return AuthPage();
        }
      },
    ));
  }
}

// class LoginWidget extends StatefulWidget {
//   final VoidCallback onClickedSignUp;

//   const LoginWidget({Key? key, required this.onClickedSignUp})
//       : super(key: key);


//   @override
//   _LoginWidgetState createState() => _LoginWidgetState();
// }

// class _LoginWidgetState extends State<LoginWidget> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 40,
//           ),
//           TextField(
//             style: TextStyle(color: Colors.pink[400]),
//             controller: emailController,
//             // cursorColor: Colors.white,
//             textInputAction: TextInputAction.next,
//             decoration: InputDecoration(labelText: "Enter Email"),
//           ),
//           SizedBox(
//             height: 4,
//           ),
//           TextField(
//             style: TextStyle(color: Colors.pink[400]),
//             controller: passwordController,
//             // cursorColor: Colors.white,
//             textInputAction: TextInputAction.next,
//             decoration: InputDecoration(labelText: "Enter Password"),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
//               onPressed: signIn,
//               icon: Icon(
//                 Icons.lock_open,
//                 size: 32,
//               ),
//               label: Text(
//                 'Sign In',
//                 style: TextStyle(fontSize: 24),
//               )),
//           SizedBox(
//             height: 25.0,
//           ),
//           GestureDetector(
//             child: Text('Forgot Password?',style: TextStyle(decoration: TextDecoration.underline,color: Theme.of(context).colorScheme.background,fontSize: 20),
//             ),
//             onTap: (){},
//           ),
//           SizedBox(height: 16,),
//           RichText(
//               text: TextSpan(
//                   style: TextStyle(
//                     color: Colors.pink,
//                   ),
//                   text: 'No account?',
//                   children: [
//                 TextSpan(
//                     recognizer: TapGestureRecognizer()..onTap = onClickedSignUp,
//                     text: 'Sign-Up',
//                     style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         color: Theme.of(context).colorScheme.background))
//               ])),
//         ],
//       ),
//     );
//   }

//   Future signIn() async {
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => Center(
//               child: CircularProgressIndicator(),
//             ));
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: emailController.text.trim(),
//           password: passwordController.text.trim());
//     } on FirebaseAuthException catch (e) {
//       print(e);
//     }
//     navigatorKey.currentState!.popUntil((route) => route.isFirst);
//   }
// }
