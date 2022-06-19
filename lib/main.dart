// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:globo_gym/auth/signuppage.dart';
import 'package:globo_gym/page/home_page.dart';
import 'package:globo_gym/page/welcome_splash_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Welcome(),
        routes: <String, WidgetBuilder>{
          '/landingpage': (BuildContext context) => new MyApp(),
          '/signup': (BuildContext context) => new SignUpPage(),
          '/homepage': (BuildContext context) => new HomePage(),
          '/landingpage': (BuildContext context) => new Welcome(),

          // Navigator.of(context).pushNamed('/signup);
        });
  }
}
