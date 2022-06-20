import 'package:flutter/material.dart';
import 'package:globo_gym/data/exercise_set.dart';
import 'package:globo_gym/model/exercise_set.dart';
import 'package:globo_gym/widget/exercise_set_widget.dart';

import 'package:globo_gym/widget/navigation_drawer_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseVideos extends StatefulWidget {
  const ExerciseVideos({Key? key}) : super(key: key);

  @override
  State<ExerciseVideos> createState() => _ExerciseVideosState();
}

class _ExerciseVideosState extends State<ExerciseVideos> {
  ExerciseType selectedType = ExerciseType.low;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/alexsandra.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              buildAppbar(context),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 8),
                      Text(
                        'Exercise',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(height: 8),
                      buildDifficultyLevel(),
                      SizedBox(height: 8),
                      buildWorkouts(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildWorkouts() => GestureDetector(
        onHorizontalDragEnd: swipeFunction,
        child: Column(
          children: exerciseSets
              .where((element) => element.exerciseType == selectedType)
              .map(
                (exerciseSet) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ExerciseSetWidget(exerciseSet: exerciseSet)),
              )
              .toList(),
        ),
      );

  Widget buildDifficultyLevel() => Row(
        children: ExerciseType.values.map(
          (type) {
            final name = getExerciseName(type);
            final fontWeight =
                selectedType == type ? FontWeight.bold : FontWeight.normal;

            return Expanded(
              child: Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => selectedType = type),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      name,
                      style: TextStyle(fontWeight: fontWeight, fontSize: 16),
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList(),
      );

  void swipeFunction(DragEndDetails dragEndDetails) {
    final selectedIndex = ExerciseType.values.indexOf(selectedType);
    final hasNext = selectedIndex < ExerciseType.values.length;
    final hasPrevious = selectedIndex > 0;

    setState(() {
      if (dragEndDetails.primaryVelocity! < 0 && hasNext) {
        final nextType = ExerciseType.values[selectedIndex + 1];
        selectedType = nextType;
      }
      if (dragEndDetails.primaryVelocity! > 0 && hasPrevious) {
        final previousType = ExerciseType.values[selectedIndex - 1];
        selectedType = previousType;
      }
    });
  }

  SliverAppBar buildAppbar(BuildContext context) => SliverAppBar(
        expandedHeight: MediaQuery.of(context).size.height * 0.1,
        stretch: true,
        title: Text("Globo  Gym  Exercises",
            style: GoogleFonts.bebasNeue(
              fontSize: 32,
              color: Color(0xFF40D876),
              letterSpacing: 1.8,
            )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 7,
      );
}
