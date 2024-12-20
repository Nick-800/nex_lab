import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:nex_lab/models/booked_tests_model.dart';
import 'package:nex_lab/providers/booked_tests_provider.dart';
import 'package:nex_lab/providers/test_provider.dart';
import 'package:nex_lab/screens/main_screens/booked_test_details_screen.dart';
import 'package:provider/provider.dart';

class BookedTestsScreen extends StatefulWidget {
  const BookedTestsScreen({super.key, this.testId});
  final int? testId;

  @override
  _BookedTestsScreenState createState() => _BookedTestsScreenState();
}

class _BookedTestsScreenState extends State<BookedTestsScreen> {
 

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.testId != null) {
        Provider.of<BookedTestsProvider>(context, listen: false)
            .deleteBookedTest(widget.testId!);
      }
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
        body: 
        btc.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 5,
                ),
              )
            : btc.isFailed
                ? const Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        size: 90,
                        color: Colors.red,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Failed to load tests",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ))
                : btc.bookedTests.isEmpty
                    ? const Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            size: 90,
                            color: Colors.red,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "No tests booked",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ))
                    :

        
        ListView.builder(
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
                subtitle: Text(
                    "Booked for: $bookedTestTime  \n $bookedTestDate   ${bookedTest.testId}"),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  push(
                      context,
                      BookedTestDetailsScreen(
                          testId: bookedTest.testId,
                          bookedTestId: bookedTest.id));
                },
              ),
            );
          },
        ),
      );
    });
  }
}
