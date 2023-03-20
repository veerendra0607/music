import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../widgets/utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Reset Passworld'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Recive an Email to\n reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 20,
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
                  height: 20,
                ),
                ElevatedButton.icon(
                    onPressed: resetPassword,
                    icon: Icon(Icons.email_outlined),
                    label: Text(
                      'Reset Passworld',
                      style: TextStyle(fontSize: 24),
                    ))
              ],
            )),
      ),
    );
  }
  
Future resetPassword() async {
    try{
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('password Reset sent with email');
    }
    catch(e){

    }

}
}
