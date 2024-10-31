import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Terms'),
        backgroundColor: Colors.blue.shade50,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              """
1. Introduction
Welcome to the Nexlab app. These terms and conditions outline the rules and regulations for the use of our services.

2. Acceptance of Terms
By accessing and using the Nexlab app, you accept and agree to be bound by these terms. If you do not agree with any part of these terms, you must not use our app.

3. User Accounts
To use certain features of our app, you may be required to create an account. You must provide accurate and complete information and keep your account information updated. You are responsible for maintaining the confidentiality of your account and password.

4. Privacy Policy
Your use of the Nexlab app is also subject to our Privacy Policy, which explains how we collect, use, and protect your personal information. By using our app, you consent to the collection and use of your information as described in the Privacy Policy.

5. User Conduct
You agree to use the Nexlab app only for lawful purposes and in accordance with these terms. You must not:
- Violate any applicable laws or regulations.
- Engage in any fraudulent or harmful activities.
- Impersonate any person or entity.
- Interfere with the proper working of the app.

6. Intellectual Property
All content, features, and functionality on the Nexlab app, including text, graphics, logos, and images, are the property of Nexlab or its licensors. You may not reproduce, distribute, or otherwise exploit any content without our prior written consent.

7. Termination
We may terminate or suspend your account and access to the Nexlab app at our sole discretion, without prior notice, for conduct that we believe violates these terms or is harmful to other users.

8. Limitation of Liability
The Nexlab app is provided "as is" without any warranties of any kind. We do not guarantee the accuracy, completeness, or reliability of any content on the app. To the fullest extent permitted by law, we disclaim all warranties and shall not be liable for any damages arising from your use of the app.

9. Changes to Terms
We reserve the right to modify or replace these terms at any time. Your continued use of the app after any changes constitutes acceptance of the new terms. It is your responsibility to review these terms periodically.

10. Governing Law
These terms shall be governed by and construed in accordance with the laws of [Your Country/State], without regard to its conflict of law principles.

11. Contact Us
If you have any questions or concerns about these terms, please contact us at [Contact Information].
              """,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
