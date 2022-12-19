// ignore_for_file: prefer_const_constructors, prefer_function_declarations_over_variables, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globo_gym/auth/login.dart';
import 'package:globo_gym/auth/phoneAuth.dart';
import 'package:globo_gym/data/drawer_items.dart';
import 'package:globo_gym/model/drawer_item.dart';
import 'package:globo_gym/page/bmi_calculator.dart';
import 'package:globo_gym/page/exercise_page.dart';
import 'package:globo_gym/page/exercise_videos.dart';
import 'package:globo_gym/page/home_page.dart';
import 'package:globo_gym/page/statistics.dart';
import 'package:globo_gym/page/weather_screen.dart';
import 'package:globo_gym/provider/navigation_provider.dart';
import 'package:globo_gym/services/makingPhoneCall.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawerWidget extends StatelessWidget {
  NavigationDrawerWidget({Key? key}) : super(key: key);
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    final provider = Provider.of<NavigationProvider>(context);
    final isCollapsed = provider.isCollapsed;
    return Container(
        width: isCollapsed ? MediaQuery.of(context).size.width * 0.2 : null,
        child: Drawer(
          child: Container(
              color: Color.fromARGB(255, 12, 11, 11),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 24).add(safeArea),
                      width: double.infinity,
                      color: Color.fromARGB(31, 223, 201, 201),
                      child: buildHeader(isCollapsed)),
                  const SizedBox(height: 24),
                  buildList(items: itemsFirst, isCollapsed: isCollapsed),
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildList(
                    indexOffset: itemsFirst.length,
                    items: itemsSecond,
                    isCollapsed: isCollapsed,
                  ),
                  Spacer(),
                  buildCollapseIcon(context, isCollapsed),
                  const SizedBox(height: 12),
                ],
              )),
        ));
  }

  Widget buildList({
    required bool isCollapsed,
    required List<DrawerItem> items,
    int indexOffset = 0,
  }) =>
      ListView.separated(
        padding: isCollapsed ? EdgeInsets.zero : padding,
        shrinkWrap: true,
        primary: false,
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = items[index];

          return buildMenuItem(
            isCollapsed: isCollapsed,
            text: item.title,
            icon: item.icon,
            onClicked: () => selectItem(context, indexOffset + index),
          );
        },
      );

  void selectItem(BuildContext context, int index) {
    final navigateTo = (page) => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => page,
        ));

    Navigator.of(context).pop();

    switch (index) {
      case 0:
        navigateTo(HomePage());
        break;
      case 1:
        navigateTo(Statistics());
        break;
      case 2:
        navigateTo(ExerciseVideos());
        break;
      case 3:
        navigateTo(LoginScreen());
        break;
      case 4:
        navigateTo(BmiCalculator());
        break;
      case 5:
        navigateTo(WeatherScreen());
        break;
      case 6:
        navigateTo(CallSupport());
        break;
      case 7:
        navigateTo(HomePage());
        break;
      case 8:
        navigateTo(FirebaseAuth.instance.signOut().then((value) {
          Navigator.of(context).pushReplacementNamed('/landingpage');
        }));
        break;
    }
  }

  Widget buildMenuItem({
    required bool isCollapsed,
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Color(0xFF40D876);
    final leading = Icon(icon, color: color);

    return Material(
      color: Color.fromARGB(0, 49, 49, 49),
      child: isCollapsed
          ? ListTile(
              title: leading,
              onTap: onClicked,
            )
          : ListTile(
              leading: leading,
              title: Text(text, style: TextStyle(color: color, fontSize: 16)),
              onTap: onClicked,
            ),
    );
  }

  Widget buildCollapseIcon(BuildContext context, bool isCollapsed) {
    const double size = 52;
    final icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    final alignment = isCollapsed ? Alignment.center : Alignment.centerRight;
    final margin = isCollapsed ? null : EdgeInsets.only(right: 16);
    final width = isCollapsed ? double.infinity : size;

    return Container(
      alignment: alignment,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: width,
            height: size,
            child: Icon(icon, color: Colors.white),
          ),
          onTap: () {
            final provider =
                Provider.of<NavigationProvider>(context, listen: false);

            provider.toggleIsCollapsed();
          },
        ),
      ),
    );
  }

  Widget logo(double height_, double width_) {
    return Image.asset(
      'assets/images/FG GF Logo.jpg',
      height: height_,
      width: width_,
    );
  }

  Widget buildHeader(bool isCollapsed) => isCollapsed
      ? logo(48, 48)
      : Row(
          children: [
            const SizedBox(width: 24),
            logo(48, 48),
            const SizedBox(width: 16),
            Text(
              'Globo Gym',
              style: TextStyle(fontSize: 32, color: Color(0xFF40D876)),
            ),
          ],
        );

  Widget Call() {
    return ElevatedButton(
      onPressed: _makingPhoneCall,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(5.0)),
        textStyle: MaterialStateProperty.all(
          const TextStyle(color: Colors.black),
        ),
      ),
      child: const Text('Here'),
    );
  }

  Widget Calldialog() {
    return AlertDialog(
      title: Text('Insert Training Session'),
      content: SingleChildScrollView(
        child: Column(
          children: [Text("Call To Support")],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              _makingPhoneCall();
            },
            child: const Text('cancel')),
        ElevatedButton(child: const Text('Save'), onPressed: _makingPhoneCall())
      ],
    );
  }
}

_makingPhoneCall() async {
  var url = Uri.parse("tel:943317021");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
