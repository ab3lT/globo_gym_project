// ignore_for_file: unnecessary_import, library_private_types_in_public_api, unnecessary_new

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:globo_gym/page/sign_up.dart';

import 'package:google_fonts/google_fonts.dart';

class SingIn extends StatefulWidget {
  const SingIn({
    Key? key,
  }) : super(key: key);

  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final formKey = GlobalKey<FormState>(); //key for form
  String name = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            child: Center(
              child: Form(
                key: formKey, //key for form
                child: Column(
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
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFF40D876)),
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
                        }),
                    SizedBox(
                      height: height * 0.05,
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
                        }),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 30,
                        ),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF40D876),
                            minimumSize: Size.fromHeight(50),
                          ),
                          icon: Icon(Icons.lock_open, size: 32),
                          label: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 24),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              const snackBar = const SnackBar(
                                  content: Text('Submitting form'));
                              _scaffoldKey.currentState!.showSnackBar(snackBar);
                            }
                          },
                        )),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23),
                                text: "No account ?      ",
                                children: [
                              TextSpan(
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUp()),
                                          )
                                        },
                                  text: 'Sign Up',
                                  style: TextStyle(
                                      decorationStyle:
                                          TextDecorationStyle.dashed,
                                      decoration: TextDecoration.underline,
                                      color: Color(0xFF40D876)))
                            ])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
