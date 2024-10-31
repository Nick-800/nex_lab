import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Confirm_Payment_Screen extends StatelessWidget {
  final String mobiCashPin;

  Confirm_Payment_Screen({required this.mobiCashPin});

  @override
  Widget build(BuildContext context) {
    final TextEditingController otpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Text(
          'Payment Verification',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Lottie.asset(
                'Assets/icon/Success (1).json', // Replace with your Lottie animation file
                width: 360,
                height: 150,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Enter the code sent to your MobiCash registered mobile number:',
              style: TextStyle(fontSize: 18, color: Colors.blue.shade900),
            ),
            SizedBox(height: 20),
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                labelText: 'Enter Code',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock, color: Colors.blue.shade900),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade900),
                ),
                labelStyle: TextStyle(color: Colors.grey.shade600),
                hintStyle: TextStyle(color: Colors.grey.shade600),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Perform OTP verification logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Code verified successfully!')),
                  );
                  Navigator.pop(context); // Go back to the previous screen
                },
                child: Text('Verify Code'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
