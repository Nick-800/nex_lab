// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:nex_lab/models/test_model.dart';
import 'package:nex_lab/providers/test_provider.dart';
import 'package:nex_lab/screens/main_screens/inhome_screens/bookedtests_screen.dart';
import 'package:provider/provider.dart';

class BookedTestDetailsScreen extends StatefulWidget {
  const BookedTestDetailsScreen({
    super.key,
    this.bookedTestId,
    
    required this.testId,
  });

  final int testId;
  final int? bookedTestId;

  @override
  _BookedTestDetailsScreenState createState() =>
      _BookedTestDetailsScreenState();
}

class _BookedTestDetailsScreenState extends State<BookedTestDetailsScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TestProvider>(context, listen: false)
          .getTestById(widget.testId)
          .then((_) {
        if (Provider.of<TestProvider>(context, listen: false).testById == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Test not found')),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TestProvider>(builder: (context, tc, child) {
      if (tc.testById == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      TestModel test = tc.testById!;
      return Scaffold(
        appBar: AppBar(
          title: Text('Details for ${test.testName}'),
          backgroundColor: Colors.blue.shade50,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: 
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  test.testName,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Here are the details of this test',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'Description:\n '
                  '${test.testDescription}',
                  style: const TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirmation'),
                        content: Text(
                            'Are you sure you want to delete the ${test.testName} test?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: ()  {
                              push(context, BookedTestsScreen(testId: widget.bookedTestId));
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Delete Booked Test'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
