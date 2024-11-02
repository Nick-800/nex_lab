
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectPaymentMethodScreen extends StatefulWidget {
  const SelectPaymentMethodScreen({super.key});

  @override
  _SelectPaymentMethodScreenState createState() => _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  List<String> _paymentMethods = [];

  @override
  void initState() {
    super.initState();
    _loadPaymentMethods();
  }

  Future<void> _loadPaymentMethods() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _paymentMethods = prefs.getStringList('payment_methods') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          'Select Payment Method',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _paymentMethods.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.payment, color: Colors.blue.shade900),
            title: Text(
              _paymentMethods[index],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue.shade900),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue.shade900),
            onTap: () {
            
            },
          );
        },
      ),
    );
  }
}
