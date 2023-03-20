import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_music_app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/utils.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const SignUpWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
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
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hey This is Sign-Up Page',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black87),
                controller: emailController,
                // cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Enter Email"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => val!.isEmpty || !val.contains("@")
                    ? "enter a valid eamil"
                    : null,
              ),
              SizedBox(
                height: 4,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black87),
                controller: passwordController,
                // cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Enter Password"),
                validator: (value) => value != null && value.length < 6
                    ? 'Enter min 6 Characters'
                    : null,
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)),
                  onPressed: signUp,
                  icon: Icon(
                    Icons.lock_open,
                    size: 32,
                  ),
                  label: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 24),
                  )),
              SizedBox(
                height: 25.0,
              ),
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: Colors.pink,
                      ),
                      text: 'Already have an account?',
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: 'Log In',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.background))
                  ])),
            ],
          ),
        ));
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message.toString());
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
