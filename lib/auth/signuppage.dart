import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:globo_gym/services/usermanagement.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String _email;
  late String _password;
  final formKey = GlobalKey<FormState>(); //key for form
  String name = "";
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
                        Text(
                          "Sign Up to Register",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text("Globo Gym")
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Email"),
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Password"),
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                        child: Text("Sign Up"),
                        color: Colors.blue,
                        textColor: Colors.white,
                        elevation: 7.0,
                        onPressed: () {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _email, password: _password)
                              .then((SignedInUser) {
                            UserManagement()
                                .storeNewUser(SignedInUser, context);
                          }).catchError((e) {
                            print(e);
                          });
                        }),
                  ],
                ),
              )),
        ));
  }
}
