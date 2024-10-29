// booked_tests_screen.dart
import 'package:flutter/material.dart';
import 'package:nex_lab/models/bookedtest.dart';
import 'package:nex_lab/models/test_model.dart';
import 'package:nex_lab/providers/test_provider.dart';
import 'package:nex_lab/screens/details_screen.dart';
import 'package:provider/provider.dart';
 // Import the BookedTest class


// booked_tests_screen.dart

class BookedTestsScreen extends StatelessWidget {
  final List<BookedTest> bookedTests; // Receive the booked tests

  const BookedTestsScreen({super.key, required this.bookedTests});

  @override
  Widget build(BuildContext context) {
    return Consumer<TestProvider>(
      builder: (context, tc, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(' Booked Tests'),
            backgroundColor: Colors.blue.shade100,
          ),
          body: ListView.builder(
            itemCount: bookedTests.length,
            itemBuilder: (context, index) {
              TestModel test = tc.tests[index];
              return Card(
                color: Colors.blue.shade50,
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(test.testName),
                  subtitle: Text(
                    '${bookedTests[index].dateTime.day}/${bookedTests[index].dateTime.month}/${bookedTests[index].dateTime.year} ${bookedTests[index].dateTime.hour}:${bookedTests[index].dateTime.minute}',
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // Handle tap on the booked test item
                    // You can navigate to a details screen or show more information
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestDetailsScreen(tm: test),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      }
    );
  }
}