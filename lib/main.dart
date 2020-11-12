import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:save_data/emailVerification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(myApp());
}

class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: emailVerification(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final dbRef = FirebaseDatabase.instance.reference().child("Users");
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController ageController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  bool send = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save Data"),
        centerTitle: true,
      ),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: firstNameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter First Name";
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: "First Name"),
              ),
              TextFormField(
                controller: lastNameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter Last Name";
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: "Last Name"),
              ),
              TextFormField(
                controller: ageController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter Age";
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: "Age"),
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter Email";
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: "Email "),
              ),
              MaterialButton(
                  elevation: 20.0,
                  minWidth: 120.0,
                  height: 40.0,
                  color: Colors.blue,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      send = true;
                      dbRef.push().set({
                        "Fist Name": firstNameController.text,
                        "Last Name": lastNameController.text,
                        "Age": ageController.text,
                        "Email": emailController.text
                      }).then((_) {
                        print("Data Added");

                        firstNameController.clear();
                        lastNameController.clear();
                        ageController.clear();
                        emailController.clear();
                      }).catchError((onError) {
                        print(onError);
                      });
                    }
                  }),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(send ? "Data Added Successfully" : " "),
              )
            ],
          )),
    );
  }
}
