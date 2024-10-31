import 'package:flutter/material.dart';
import 'package:nex_lab/screens/profile_screens/about_screen.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  @override
  _TermsAndConditionsScreenState createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool _isAccepted = false;

  void _acceptTerms() {
    setState(() {
      _isAccepted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade900],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('Terms and Conditions'),
              _buildSection(
                'Introduction',
                'Welcome to NexLab. By using our app, you agree to comply with and be bound by the following terms and conditions. Please review them carefully.',
              ),
              _buildSection(
                'Privacy Policy',
                'Your use of our app is also subject to our Privacy Policy, which explains how we collect, use, and protect your personal information. By using our app, you consent to the collection and use of your information as described in the Privacy Policy.',
              ),
              // Add more sections here as needed
              const SizedBox(height: 20),
              _buildCheckboxRow(),
              const SizedBox(height: 20),
              _buildAcceptButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxRow() {
    return Row(
      children: [
        Checkbox(
          value: _isAccepted,
          onChanged: (bool? value) {
            setState(() {
              _isAccepted = value ?? false;
            });
          },
          activeColor: Colors.blue.shade900,
        ),
        const Expanded(
          child: Text(
            'I have read and agree to the Terms and Conditions',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildAcceptButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _isAccepted
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: _isAccepted ? Colors.blue.shade900 : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: const Text('Accept and Continue'),
      ),
    );
  }
}
