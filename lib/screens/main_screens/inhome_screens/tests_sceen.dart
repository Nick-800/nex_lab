// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nex_lab/models/test_model.dart';
import 'package:nex_lab/providers/test_provider.dart';
import 'package:nex_lab/screens/main_screens/details_screen.dart';
import 'package:provider/provider.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({
    super.key,
  });

  @override
  _TestsScreenState createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  DateTime? selectedDateTime;

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

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TestProvider>(
      builder: (context, testConsumer, _) {
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
                await _selectDateTime(context);
                if (selectedDateTime != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TestDetailsScreen(
                            tm: test, bookedDateTime: selectedDateTime!)),
                  );
                }
              },
              child: Card(
                color: Colors.blue.shade50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(iconDataList[test.iconId],
                        size: 50, color: colorList[index]),
                    const SizedBox(height: 8),
                    Text(test.testName),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
