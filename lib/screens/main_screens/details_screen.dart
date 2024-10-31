// ignore_for_file: non_constant_identifier_names


import 'package:flutter/material.dart';
import 'package:nex_lab/models/test_model.dart';
import 'package:nex_lab/providers/booked_tests_provider.dart';
import 'package:provider/provider.dart';

class TestDetailsScreen extends StatefulWidget {
  const TestDetailsScreen({super.key, required this.tm, required this.bookedDateTime});

  final DateTime bookedDateTime;
  final TestModel tm;

  @override
  _TestDetailsScreenState createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen> {
  void addBookedTest() {
    Provider.of<BookedTestsProvider>(context, listen: false).addBookedTest({
      "test_id": "${widget.tm.id}", "booked_time": "${widget.bookedDateTime}"
    }).then((added){
      if(added){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Test Booked Successfully"),
        ));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to book test"),
        ));
      }
    })
    
    
    ;
  }

  @override
  Widget build(BuildContext context) {
    var tm = widget.tm;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tm.testName),
        backgroundColor: Colors.blue.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
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
                'Details for ${widget.tm.testName}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Here are the details of this test',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Description:\n '
                '${tm.testDescription}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmation'),
                      content: Text(
                          'Are you sure you want to take the ${tm.testName} test?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            addBookedTest();
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Confirm Test'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
