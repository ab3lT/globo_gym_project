// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("You Are now loged In! !!"),
          OutlinedButton(
              child: Text("Logout"),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushReplacementNamed('/landingpage');
                });
              }),
        ],
      )),
    );
  }
}
