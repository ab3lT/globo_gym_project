// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_constructors, deprecated_member_use, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email;
  late String _password;
  final formKey = GlobalKey<FormState>(); //key for form
  String name = "";
  late String value;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Container(
            height: height,
            padding: const EdgeInsets.all(25.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image1.png"),
                  fit: BoxFit.cover),
            ),
            child: Form(
              key: formKey, //key for form
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),
                  const Text(
                    "Welcome To ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 253, 253, 253)),
                  ),
                  const Text(
                    "Globo Gym !",
                    style: TextStyle(fontSize: 30, color: Color(0xFF40D876)),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Color(0xFF40D876)),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        iconColor: Color(0xFF40D876),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF40D876)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF40D876)),
                        ),
                        prefixIcon: Icon(Icons.email),
                        prefixIconColor: Color(0xFF40D876),
                        border: OutlineInputBorder(),
                        labelText: "Enter Email",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF40D876),
                        )),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return "The email is empity";
                      } else if (value!.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)[\w]{2,4}')
                              .hasMatch(value)) {
                        return "Enter Corrent email";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Color(0xFF40D876)),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      labelText: "Enter yout Passowrd",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF40D876),
                      ),
                      prefixIconColor: Color(0xFF40D876),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF40D876)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF40D876)),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return "The password is empity";
                      } else if (value != null && value.length < 7) {
                        return "Enter minmum length is 7 Characters";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                          child: Text("Login"),
                          color: Color(0xFF40D876),
                          textColor: Colors.white,
                          elevation: 7.0,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              const snackBar = const SnackBar(
                                  content: Text('Submitting form'));
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _email, password: _password)
                                  .then((UserCredential user) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/homepage');
                              }).catchError((e) {
                                print(e);
                              });
                              _scaffoldKey.currentState!.showSnackBar(snackBar);
                            }
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 26.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Don\'t Have an account?",
                        style: TextStyle(color: Colors.white30),
                      ),
                      RaisedButton(
                          child: Text("Sign Up"),
                          color: Colors.white12,
                          textColor: Colors.black45,
                          elevation: 7.0,
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/signup');
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            )),
      ),
    ));
  }
}
