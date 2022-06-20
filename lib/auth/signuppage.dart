// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:globo_gym/data/user_simple_preferences.dart';
import 'package:globo_gym/services/usermanagement.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String _email;
  late String _password;
  late String _name;
  late String _phone;
  final formKey = GlobalKey<FormState>(); //key for form
  String name = "";
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
              height: height,
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 50),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/image1.png"),
                    fit: BoxFit.cover),
              ),
              child: Form(
                key: formKey, //key for form
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Sign Up ",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text("Globo Gym",
                            style: TextStyle(
                                fontSize: 30, color: Color(0xFF40D876)))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 15, color: Color(0xFF40D876)),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: "Enter Full Name",
                          prefixIcon: Icon(Icons.adobe),
                          prefixIconColor: Color(0xFF40D876),
                          iconColor: Color(0xFF40D876),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF40D876)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF40D876)),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(
                              fontSize: 20, color: Color(0xFF40D876))),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "The Name is empity";
                        } else if (value!.isEmpty ||
                            !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                          return "Enter Corrent name";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 15, color: Color(0xFF40D876)),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Enter Phone Number",
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Color(0xFF40D876),
                          iconColor: Color(0xFF40D876),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF40D876)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF40D876)),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(
                              fontSize: 20, color: Color(0xFF40D876))),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "The Phone Number is empity";
                        } else if (value != null && value.length < 13) {
                          return "Enter the corrent phone number by begin with +251";
                        } else if (value!.isEmpty ||
                            !RegExp(r'^[+]*[(]{0,1}[0-9]{1,9}[)]{0,1}[-\s\./0-9]+$')
                                .hasMatch(value)) {
                          return "Enter Corrent phone number";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          _phone = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 15, color: Color(0xFF40D876)),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Enter Email",
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Color(0xFF40D876),
                          iconColor: Color(0xFF40D876),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF40D876)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF40D876)),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(
                              fontSize: 20, color: Color(0xFF40D876))),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "The email is empity";
                        } else if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)[\w]{2,4}')
                                .hasMatch(value)) {
                          return "Enter correct your email";
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
                      decoration: InputDecoration(
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
                      height: 50.0,
                    ),
                    ElevatedButton(
                        child: Text("Sign Up"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // background
                          onPrimary: Color(0xFF40D876), // foreground
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            const snackBar =
                                const SnackBar(content: Text('Sinning Up'));
                            Navigator.of(context)
                                .pushReplacementNamed('/homepage');
                            _scaffoldKey.currentState!.showSnackBar(snackBar);
                          }
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _email, password: _password)
                              .then((SignedInUser) {
                            UserManagement()
                                .storeNewUser(SignedInUser, context);
                            FirebaseFirestore.instance
                                .collection('UserData')
                                .doc(SignedInUser.user!.uid)
                                .set(
                              {"email": SignedInUser.user!.email},
                            );

                            //{"Full Name": SignedInUser.user!.phoneNumber}
                            FirebaseFirestore.instance
                                .collection('UserData')
                                .doc(SignedInUser.user!.uid)
                                .set(
                              {"phone": SignedInUser.user!.phoneNumber},
                            );
                            FirebaseFirestore.instance
                                .collection('UserData')
                                .doc(SignedInUser.user!.uid)
                                .set(
                              {"Name": SignedInUser.user!.displayName},
                            );
                          }).catchError((e) {
                            print(e);
                          });
                          _firebaseAuth
                              .createUserWithEmailAndPassword(
                                  email: _email, password: _password)
                              .then((value) {
                            FirebaseFirestore.instance
                                .collection('UserData')
                                .doc(value.user!.uid)
                                .set(
                              {"email": value.user!.email},
                            );
                          });
                        }),
                  ],
                ),
              )),
        ));
  }
}
