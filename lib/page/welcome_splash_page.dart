import 'dart:async';

import 'package:flutter/material.dart';
import 'package:globo_gym/auth/loginpage.dart';

import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/image1.png"),
        fit: BoxFit.cover,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 160,
            width: 160,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/FG GF Logo.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          richText(30),
        ],
      ),
    ));
  }

  Widget logo(double height_, double width_) {
    return Image.asset(
      'assets/images/FG GF Logo.jpg',
      height: height_,
      width: width_,
    );
  }

  Widget richText(double fontSize) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: fontSize,
          color: const Color.fromARGB(255, 254, 255, 255),
          letterSpacing: 3,
          height: 1.03,
        ),
        children: const [
          TextSpan(
            text: 'Welcome to ',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: 'Globo Gym ',
            style: TextStyle(
              color: Color(0xFF40D876),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
