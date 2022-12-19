// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:globo_gym/auth/signuppage.dart';
import 'package:globo_gym/data/user_simple_preferences.dart';
import 'package:globo_gym/page/home_page.dart';
import 'package:globo_gym/page/welcome_splash_page.dart';
import 'package:globo_gym/provider/navigation_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //for provider
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await UserSimplePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,

          title: 'Flutter Demo',
          theme: ThemeData(primaryColor: Color(0xFF40D876)),
          home: const Welcome(),
          routes: <String, WidgetBuilder>{
            '/landingpage': (BuildContext context) => new MyApp(),
            '/signup': (BuildContext context) => new SignUpPage(),
            '/homepage': (BuildContext context) => new HomePage(),
// Navigator.of(context).pushNamed('/signup);
          }));
}
