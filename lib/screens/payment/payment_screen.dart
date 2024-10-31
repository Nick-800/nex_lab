import 'package:flutter/material.dart';
import 'package:nex_lab/screens/payment/addpaymkentmethod_screen.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        backgroundColor: Colors.blue.shade50,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose a Payment Method',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),  
              SizedBox(
                height: 500,  
                child: Align(
                  alignment: Alignment.center,
                  child: PageView(
                    children: [
                      _buildPaymentCard(
                        context,
                        'Assets/Visa Card2.png',
                        'Visa Card',
                        'Visa Card',
                      ),
                      _buildPaymentCard(
                        context,
                        'Assets/mobi2.png',
                        'Mobicash',
                        'Mobicash',
                      ),
                      _buildPaymentCard(
                        context,
                        'Assets/Edfaly.png',
                        'Edfaly',
                        'Edfaly',
                      ),
                      _buildPaymentCard(
                        context,
                        'Assets/Cash.jpg',
                        'Cash',
                        'Cash',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20), 
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentCard(BuildContext context, String assetPath, String title, String method) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Container(
        width: 150,
        height: 300,   
        padding: const EdgeInsets.all(10),  
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetPath, width: 300),   
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 16)),  
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPaymentMethodScreen(method: method)),
                );
              },
              child: const Text('Select'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),   
                textStyle: const TextStyle(
                  fontSize: 16,   
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
