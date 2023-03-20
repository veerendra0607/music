import 'package:flutter/material.dart';

class Utils {
  static showSnackBar(String? text) {
    final messengerKey = GlobalKey<ScaffoldMessengerState>();
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.green,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
