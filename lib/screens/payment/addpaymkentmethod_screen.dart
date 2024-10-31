import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nex_lab/screens/payment/confirmpay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPaymentMethodScreen extends StatefulWidget {
  final String method;

  const AddPaymentMethodScreen({required this.method, super.key});

  @override
  _AddPaymentMethodScreenState createState() => _AddPaymentMethodScreenState();
}

class _AddPaymentMethodScreenState extends State<AddPaymentMethodScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _cardNumberController;
  late TextEditingController _expiryDateController;
  late TextEditingController _cvvController;
  late TextEditingController _mobiCashPinController;
  late TextEditingController _edfalyAccountController;

  @override
  void initState() {
    super.initState();
    _cardNumberController = TextEditingController();
    _expiryDateController = TextEditingController();
    _cvvController = TextEditingController();
    _mobiCashPinController = TextEditingController();
    _edfalyAccountController = TextEditingController();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _mobiCashPinController.dispose();
    _edfalyAccountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Text(
          'Add ${widget.method}',
          style: const TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: widget.method == 'Visa Card'
                      ? Image.asset(
                          'Assets/card_placeholder.jpg',
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : widget.method == 'Mobicash'
                          ? Image.asset('Assets/mobi2.png')
                          : widget.method == 'Cash'
                              ? const Icon(
                                  FontAwesomeIcons.moneyBill1Wave,
                                  size: 100,
                                  color: Colors.green,
                                )
                              : Image.asset(
                                  'Assets/Edfaly.png',
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                ),
                const SizedBox(height: 20),
                if (widget.method == 'Visa Card') ...[
                  _buildTextField(
                      label: 'Card Number',
                      hint: '1234 5678 9012 3456',
                      icon: Icons.credit_card,
                      controller: _cardNumberController),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: _buildTextField(
                              label: 'Expiry Date',
                              hint: 'MM/YY',
                              icon: Icons.calendar_today,
                              controller: _expiryDateController)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _buildTextField(
                              label: 'CVV',
                              hint: '123',
                              icon: Icons.lock,
                              controller: _cvvController)),
                    ],
                  ),
                ] else if (widget.method == 'Mobicash') ...[
                  _buildTextField(
                      label: 'Mobicash PIN',
                      hint: '6 digits',
                      icon: Icons.lock,
                      maxLength: 6,
                      controller: _mobiCashPinController),
                ] else if (widget.method == 'Edfaly') ...[
                  _buildTextField(
                      label: 'Edfaly Account',
                      hint: '123456789',
                      icon: Icons.account_balance,
                      controller: _edfalyAccountController),
                ] else if (widget.method == 'Cash') ...[
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.moneyBill1Wave, size: 40, color: Colors.green),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Please provide cash at the front desk.',
                          style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (widget.method == 'Mobicash') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Confirm_Payment_Screen(mobiCashPin: _mobiCashPinController.text)),
                          );
                        } else {
                          await _savePaymentMethod(widget.method);
                          _showSuccessMessage(context, widget.method);
                          Navigator.pop(context); // Go back to the previous screen
                        }
                      }
                    },
                    child: Text('Add ${widget.method}'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessMessage(BuildContext context, String method) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    String message;
    switch (method) {
      case 'Visa Card':
        message = 'Visa Card added successfully!';
        break;
      case 'Mobicash':
        message = 'Mobicash added successfully!';
        break;
      case 'Edfaly':
        message = 'Edfaly account added successfully!';
        break;
      case 'Cash':
        message = 'Cash payment method added successfully!';
        break;
      default:
        message = '$method added successfully!';
    }
    scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildTextField(
      {required String label,
      required String hint,
      required IconData icon,
      int maxLength = 20,
      required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon, color: Colors.blue.shade900),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade900),
        ),
        labelStyle: TextStyle(color: Colors.blue.shade900),
        hintStyle: TextStyle(color: Colors.grey.shade600),
        counterText: "",
      ),
      maxLength: maxLength,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.blue.shade900),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
          return 'Please enter valid numbers';
        }
        return null;
      },
    );
  }

  Future<void> _savePaymentMethod(String method) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? paymentMethods = prefs.getStringList('payment_methods') ?? [];
    paymentMethods.add(method);
    await prefs.setStringList('payment_methods', paymentMethods);
  }
}
