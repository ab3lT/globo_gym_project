import 'package:flutter/material.dart';
import 'package:globo_gym/widget/navigation_drawer_widget.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({Key? key}) : super(key: key);

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  final TextEditingController txtHeight = TextEditingController();
  final TextEditingController txtweight = TextEditingController();
  final double fontSize = 18;
  String result = '';
  bool isMetric = true;
  bool isImperial = false;
  double? heignt;
  double? weight;
  late List<bool> isSelected;
  String heightMessage = '';
  String weightMessage = '';
  @override
  void initState() {
    isSelected = [isMetric, isImperial];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightMessage =
        'Please insert your height in ' + ((isMetric) ? 'meters' : 'inches');
    weightMessage =
        'Please insert your weight in ' + ((isMetric) ? 'kilos' : 'pounds');
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      drawer: NavigationDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ToggleButtons(
                splashColor: Color.fromARGB(255, 88, 30, 9),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Metic', style: TextStyle(fontSize: fontSize)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child:
                        Text('Imperial', style: TextStyle(fontSize: fontSize)),
                  ),
                ],
                isSelected: isSelected,
                onPressed: toggleMeasure,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                controller: txtHeight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: heightMessage),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextField(
                controller: txtweight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: weightMessage),
              ),
            ),
            ElevatedButton(
              child:
                  Text('Calculate BMI', style: TextStyle(fontSize: fontSize)),
              onPressed: findBMI,
            ),
            Text(
              result,
              style: TextStyle(fontSize: fontSize),
            )
          ],
        ),
      ),
    );
  }

  void toggleMeasure(value) {
    if (value == 0) {
      isMetric = true;
      isImperial = false;
    } else {
      isMetric = false;
      isImperial = true;
    }
    setState(() {
      isSelected = [isMetric, isImperial];
    });
  }

  void findBMI() {
    double bmi = 0;
    double height = double.tryParse(txtHeight.text) ?? 0;
    double weight = double.tryParse(txtweight.text) ?? 0;
    if (isMetric) {
      bmi = (weight / (height * height));
    } else {
      bmi = weight * 703 / (height * height);
    }
    setState(() {
      result = 'your BMI is ' + bmi.toStringAsFixed(2);
    });
  }
}
