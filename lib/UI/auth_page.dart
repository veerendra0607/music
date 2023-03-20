import 'package:fl_music_app/UI/login_page.dart';
import 'package:fl_music_app/UI/signup_widget.dart';
import 'package:fl_music_app/main.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginWidget(onClickedSignUp: toggle)
        : SignUpWidget(onClickedSignUp: toggle);
  }

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
