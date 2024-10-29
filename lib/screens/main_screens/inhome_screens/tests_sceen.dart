// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nex_lab/models/bookedtest.dart';
import 'package:nex_lab/models/test_model.dart';
import 'package:nex_lab/providers/test_provider.dart';
import 'package:nex_lab/screens/details_screen.dart';
import 'package:provider/provider.dart';


class Tests_Screen extends StatefulWidget {
  final Function(BookedTest) onTestBooked;

  const Tests_Screen({super.key, required this.onTestBooked});

  @override
  _Tests_ScreenState createState() => _Tests_ScreenState();
}

class _Tests_ScreenState extends State<Tests_Screen> {

  @override
  void initState() {
    // Call getResults when the screen is first displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TestProvider>(context, listen: false).getTests();
    });
    super.initState();
  }


  final List<IconData> iconDataList = [
    FontAwesomeIcons.solidHeart,
    FontAwesomeIcons.heartPulse,
    FontAwesomeIcons.cannabis,
    FontAwesomeIcons.lungs,
    FontAwesomeIcons.brain,
    FontAwesomeIcons.virus,
    FontAwesomeIcons.handHoldingHeart,
    FontAwesomeIcons.microscope,
    FontAwesomeIcons.dna,
    FontAwesomeIcons.pills,
    FontAwesomeIcons.syringe,
    FontAwesomeIcons.virusCovid,
    FontAwesomeIcons.thermometer,
    FontAwesomeIcons.bacteria,
  ];

  final List<String> textList = [
    'Heart',
    'Pulse',
    'Drug Test',
    'Lungs',
    'Brain',
    'Virus',
    'Heart Care',
    'Microscope',
    'DNA',
    'Pills',
    'Syringe',
    'Virus',
    'Thermometer',
    'Allergies',
  ];

  final List<Color> colorList = [
    Colors.red.withOpacity(0.5),
    Colors.pink.withOpacity(0.5),
    Colors.green.withOpacity(0.5),
    Colors.teal.withOpacity(0.5),
    Colors.blue.withOpacity(0.5),
    Colors.purple.withOpacity(0.5),
    Colors.orange.withOpacity(0.5),
    Colors.brown.withOpacity(0.5),
    Colors.cyan.withOpacity(0.5),
    Colors.yellow.withOpacity(0.5),
    Colors.deepPurple.withOpacity(0.5),
    Colors.lime.withOpacity(0.5),
    Colors.indigo.withOpacity(0.5),
    Colors.amber.withOpacity(0.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TestProvider>(
      builder: (context, testConsumer,_) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
          ),
          itemCount: testConsumer.tests.length,
          itemBuilder: (context, index) {
            TestModel test = testConsumer.tests[index];
            return GestureDetector(
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (selectedTime != null) {
                    final bookedTest = BookedTest(
                      name: textList[index],
                      dateTime: DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      ),
                    );
                    widget.onTestBooked(bookedTest);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TestDetailsScreen(tm: test)),
                    );
                  }
                }
              },
              child: Card(
                color: Colors.blue.shade50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(iconDataList[test.iconId], size: 50, color: colorList[index]),
                    const SizedBox(height: 8),
                    Text(test.testName),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}
