import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class emailVerification extends StatefulWidget {
  @override
  _emailVerificationState createState() => _emailVerificationState();
}

class _emailVerificationState extends State<emailVerification> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  bool _success;
  String _userEmail;
  String _userID;

  Future<void> _signInWithEmailAndLink() async {
    _userEmail = emailController.text;
    return await _auth.sendSignInLinkToEmail(
      email: _userEmail,
      actionCodeSettings: ActionCodeSettings(
        url: 'https://flutterauth.page.link/',
        androidPackageName: 'com.google.firebase.flutterauth',
        handleCodeInApp: true,
        iOSBundleId: 'com.google.firebase.flutterauth',
        androidMinimumVersion: "1",
        androidInstallApp: true,
      ),
      // handleCodeInApp: true,
      // iOSBundleID: 'com.google.firebase.flutterauth',
      // androidInstallIfNotAvailable: true,
      // androidMinimumVersion: "1",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter Email Id";
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: "Email"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MaterialButton(
                    elevation: 10.0,
                    minWidth: 120.0,
                    height: 40.0,
                    color: Colors.blue,
                    child: Text(
                      "Email Verify",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        _signInWithEmailAndLink();
                        emailController.clear();
                      }
                    }),
              )
            ],
          )),
    );
  }
}
