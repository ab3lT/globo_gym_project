// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_constructors, deprecated_member_use, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:globo_gym/data/user_simple_preferences.dart';
import 'package:globo_gym/page/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  late String _password;
  final formKey = GlobalKey<FormState>(); //key for form
  String name = "";
  late String value;
  late bool loading;
  GoogleSignInAccount? _currentUser;
  String _contactText = '';
  @override
  void initState() {
    // TOD O: implement initState

    _email = UserSimplePreferences.getUserEmail() ?? '';
  }

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
                    initialValue: _email,
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
                        return "The email is empty";
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
                      labelText: "Enter your Passowrd",
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
                        return "The password is empty";
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
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    RaisedButton(
                        child: Text("Login"),
                        color: Color(0xFF40D876),
                        textColor: Colors.white,
                        elevation: 7.0,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            const snackBar =
                                SnackBar(content: Text('Submitting form'));
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _email, password: _password)
                                .then((UserCredential user) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/homepage');
                            }).catchError((e) {
                              print(e);
                            });
                            await UserSimplePreferences.setUserEmail(_email);

                            _scaffoldKey.currentState!.showSnackBar(snackBar);
                          }
                        }),
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RaisedButton(
                          child: Text("Sing in with Google"),
                          color: Color(0xFF40D876),
                          textColor: Colors.white,
                          elevation: 7.0,
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            final googleSignIn =
                                GoogleSignIn(scopes: ['email']);

                            try {
                              final googleSiginInAccount =
                                  await googleSignIn.signIn();
                              if (googleSiginInAccount == null) {
                                setState(() {
                                  loading = false;
                                });
                                return;
                              }
                              final googleSignInAuthentication =
                                  await googleSiginInAccount.authentication;
                              final credential = GoogleAuthProvider.credential(
                                accessToken:
                                    googleSignInAuthentication.accessToken,
                                idToken: googleSignInAuthentication.idToken,
                              );
                              await FirebaseAuth.instance
                                  .signInWithCredential(credential);
                              await FirebaseFirestore.instance
                                  .collection('userGoolge')
                                  .add({
                                'email': googleSiginInAccount.email,
                                'imageurl': googleSiginInAccount.photoUrl,
                                'name': googleSiginInAccount.displayName,
                              });

                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (_) => HomePage()),
                                  (route) => false);
                            } on FirebaseAuthException catch (e) {
                              var content = '';
                              switch (e.code) {
                                case "account-exists-with-different-credential":
                                  content =
                                      'This account exists with a different sign in provider';
                                  break;
                                case "Invalid-credential":
                                  content = 'Unknown error has occurred';
                                  break;
                                case "operation-not-allowed":
                                  content = 'This operation is not allowed';
                                  break;
                                case "user-disabled  ":
                                  content =
                                      'The user you tride to log into is disabled';
                                  break;
                                case "user-not-found  ":
                                  content =
                                      'The user you tride to log was not found';
                                  break;
                              }
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          title:
                                              Text('Log in with google failed'),
                                          content:
                                              Text('An unkonwn error occurred'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("ok"))
                                          ]));
                            } finally {
                              setState(() {
                                loading = false;
                              });
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
