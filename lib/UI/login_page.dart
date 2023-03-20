import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_music_app/UI/forgot_password_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          TextField(
            style: TextStyle(color: Colors.black87),
            controller: emailController,
            // cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Enter Email"),
          ),
          SizedBox(
            height: 4,
          ),
          TextField(
            style: TextStyle(color: Colors.black87),
            controller: passwordController,
            // cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Enter Password"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
              onPressed: signIn,
              icon: Icon(
                Icons.lock_open,
                size: 32,
              ),
              label: Text(
                'Sign In',
                style: TextStyle(fontSize: 24),
              )),
          SizedBox(
            height: 25.0,
          ),
          GestureDetector(
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.background,
                  fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ForgotPasswordPage()));
            },
          ),
          SizedBox(
            height: 16,
          ),
          RichText(
              text: TextSpan(
                  style: TextStyle(
                    color: Colors.pink,
                  ),
                  text: 'No account?',
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    text: 'Sign-Up',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.background))
              ])),
        ],
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
