import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        buildAppbar(context),
      ],
    ));
  }

  SliverAppBar buildAppbar(BuildContext context) => SliverAppBar(
        flexibleSpace: FlexibleSpaceBar(),
        expandedHeight: MediaQuery.of(context).size.height * 0.05,
        stretch: true,
        title: Text('Statistics'),
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions: [],
      );
}
