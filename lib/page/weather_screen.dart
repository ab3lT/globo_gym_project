// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:globo_gym/data/weather.dart';
import 'package:globo_gym/widget/navigation_drawer_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/http_helper.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController txtPlace = TextEditingController();
  Weather result = Weather('', '', 0, 0, 0, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      controller: txtPlace,
                      decoration: InputDecoration(
                          hintText: 'Enter City',
                          suffixIcon: IconButton(
                              icon: Icon(Icons.search), onPressed: getData)),
                    ),
                  ),
                  weatherRow('place: ', result.name),
                  weatherRow('Description: ', result.description),
                  weatherRow(
                      'Temprature: ', result.temprature.toStringAsFixed(2)),
                  weatherRow('Percived: ', result.perceived.toStringAsFixed(2)),
                  weatherRow('pressure: ', result.pressure.toString()),
                  weatherRow('Humidity: ', result.humidity.toString()),
                ],
              ),
            ),
          ),
        ));
  }

  Future getData() async {
    HttpHelper helper = HttpHelper();
    result = await helper.getWather(txtPlace.text);
    setState(() {});
  }

  Widget weatherRow(String lable, String value) {
    Widget row = Padding(
      padding: EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(lable,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).hintColor,
                  ))),
          Expanded(
              flex: 4,
              child: Text(value,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ))),
        ],
      ),
    );
    return row;
  }
}
