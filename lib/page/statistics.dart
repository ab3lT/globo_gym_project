// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:globo_gym/widget/excercise_widget.dart';
import 'package:globo_gym/widget/line_chart_widget.dart';
import 'package:globo_gym/widget/navigation_drawer_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/alexsandra.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              buildAppbar(context),
              ExercisesWidget(),
            ],
          ),
        ));
  }

  SliverAppBar buildAppbar(BuildContext context) => SliverAppBar(
        flexibleSpace: FlexibleSpaceBar(background: LineCharWidget()),
        expandedHeight: MediaQuery.of(context).size.height * 0.5,
        stretch: true,
        title: Text("Globo  Gym  Statistics",
            style: GoogleFonts.bebasNeue(
              fontSize: 32,
              color: Color(0xFF40D876),
              letterSpacing: 1.8,
            )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 7,
        actions: [
          Icon(Icons.person, size: 28),
          SizedBox(
            width: 12,
          )
        ],
      );
}
