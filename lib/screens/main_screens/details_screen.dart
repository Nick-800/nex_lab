// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/models/test_model.dart';
import 'package:nex_lab/providers/booked_tests_provider.dart';
import 'package:nex_lab/widgets/clickables/buttons/cancel_button.dart';
import 'package:nex_lab/widgets/clickables/buttons/main_button.dart';
import 'package:provider/provider.dart';

class TestDetailsScreen extends StatefulWidget {
  const TestDetailsScreen({super.key, required this.tm});

  final TestModel tm;

  @override
  _TestDetailsScreenState createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen> {
  DateTime? selectedDateTime;

  void addBookedTest() {
    Provider.of<BookedTestsProvider>(context, listen: false).addBookedTest({
      "test_id": "${widget.tm.id}",
      "booked_time": "$selectedDateTime",
    }).then((added) {
      if (added) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Test Booked Successfully"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to book test"),
        ));
      }
    });
  }

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
            pickedTime.minute,
          );
        });
      }
    }
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Icon(
                        iconDataList[tm.iconId],
                        size: 100,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        tm.testName,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildDetailRow('Description', tm.testDescription),
                _buildDetailRow('Type', tm.testType),
                _buildDetailRow('Price', '\$${tm.price}'),
                _buildDetailRow('Duration', '${tm.duration} minutes'),
                _buildDetailRow('Available Slots', '${tm.availableSlots}'),
                _buildDetailRow('Test Code', tm.testCode),
                _buildDetailRow('Instructions', tm.instructions),
                _buildDetailRow('Preparation Required', tm.preparationRequired),
                _buildDetailRow('Status', tm.status),
                _buildDetailRow('Max Bookings Per Slot', '${tm.maxBookingsPerSlot}'),
                const SizedBox(height: 20),
                MainButton(
                  text: "Select Date & time",
                  onPressed: () {
                    _selectDateTime(context);
                  },
                ),
                const SizedBox(height: 10),
                MainButton(
                  btnColor:
                      selectedDateTime == null ? Colors.grey : Colors.blue,
                  borderColor:
                      selectedDateTime == null ? Colors.grey : Colors.blue,
                  onPressed: () {
                    if (selectedDateTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please select a date and time"),
                      ));
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirmation'),
                          content: Text(
                              'Are you sure you want to book the ${tm.testName} test for ${selectedDateTime.toString().substring(0, 16)}?'),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CancelButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  text: 'Cancel',
                                ),
                                MainButton(
                                  onPressed: () async {
                                    addBookedTest();
                                    Navigator.of(context).pop();
                                  },
                                  text: 'Confirm',
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                  },
                  text: 'Confirm Booking',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
