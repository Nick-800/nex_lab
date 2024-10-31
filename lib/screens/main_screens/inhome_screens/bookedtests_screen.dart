import 'package:flutter/material.dart';
import 'package:nex_lab/models/booked_tests_model.dart';
import 'package:nex_lab/providers/booked_tests_provider.dart';
import 'package:nex_lab/providers/test_provider.dart';
import 'package:provider/provider.dart';

class BookedTestsScreen extends StatefulWidget {
  const BookedTestsScreen({super.key});

  @override
  _BookedTestsScreenState createState() => _BookedTestsScreenState();
}

class _BookedTestsScreenState extends State<BookedTestsScreen> {
  @override
  void initState() {
    // Call getResults when the screen is first displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookedTestsProvider>(context, listen: false).getBookedTests();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TestProvider, BookedTestsProvider>(
        builder: (context, tc, btc, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(' Booked Tests'),
          backgroundColor: Colors.blue.shade100,
        ),
        body: ListView.builder(
          itemCount: btc.bookedTests.length,
          itemBuilder: (context, index) {
            BookedTestModel bookedTest = btc.bookedTests[index];
            String bookedTestDate =
                bookedTest.bookedTime.toString().substring(0, 10);
            String bookedTestTime =
                bookedTest.bookedTime.toString().substring(11, 16);
            return Card(
              color: Colors.blue.shade50,
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(bookedTest.testName),
                subtitle:
                    Text("Booked for: $bookedTestTime  \n $bookedTestDate"),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // Handle tap on the booked test item
                  // You can navigate to a details screen or show more information
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => TestDetailsScreen(tm: bookedTest),
                  //   ),
                  // );
                },
              ),
            );
          },
        ),
      );
    });
  }
}
