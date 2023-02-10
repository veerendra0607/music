import 'package:fl_music_app/UI/songs_screen.dart';
import 'package:fl_music_app/widgets/playlistCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'UI/home_screen.dart';
import 'UI/playlist.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dev Music',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white,displayColor: Colors.white)
      ),
      home: HomeScreen(),
      getPages: [
        GetPage(name: '/', page:()=> HomeScreen()),
        GetPage(name: '/song', page:()=> SongsScreen()),
        GetPage(name: '/playlist', page:()=> SongsScreen()),
      ],
    );
  }
}
