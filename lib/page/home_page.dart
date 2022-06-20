// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globo_gym/widget/navigation_drawer_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Globo  Gym ",
            style: GoogleFonts.bebasNeue(
              fontSize: 32,
              color: Color(0xFF40D876),
              letterSpacing: 1.8,
            )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: NavigationDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/image3.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: Center(
                        child: Text(
                          "HARD  ",
                          style: GoogleFonts.bebasNeue(
                            fontSize: 32,
                            color: Colors.white,
                            letterSpacing: 1.8,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: Text(
                        "ELEMENT",
                        style: GoogleFonts.bebasNeue(
                          fontSize: 32,
                          color: Color(0xFF40D876),
                          letterSpacing: 1.8,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "You Are now loged In! !!",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )),
      ),
    );
  }
}
