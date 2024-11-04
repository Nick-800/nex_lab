// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<TestProvider>(
      builder: (context, testConsumer, _) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: testConsumer.isLoading
                ? const Center(child: CircularProgressIndicator())
                : testConsumer.isFailed
                    ? const Center(child: Text('Failed to load tests'))
                    : testConsumer.tests.isEmpty
                        ? const Center(child: Text('No tests found'))
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2,
                            ),
                            itemCount: testConsumer.tests.length,
                            itemBuilder: (context, index) {
                              TestModel test = testConsumer.tests[index];
                              return GestureDetector(
                                onTap: () {
                                  push(context, TestDetailsScreen(tm: test));
                                },
                                child: Card(
                                  shadowColor: greyColor,
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(iconDataList[test.iconId],
                                          size: 47, color: colorList[index]),
                                      const SizedBox(height: 8),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(test.testName),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                test.status == "available"
                                                    ? const Icon(
                                                        FontAwesomeIcons
                                                            .circlePlus,
                                                        color: Colors.green)
                                                    : const Icon(Icons.cancel,
                                                        color: Colors.red),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
          ),
        );
      },
    );
  }
}
