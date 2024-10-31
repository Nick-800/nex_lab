import 'package:flutter/material.dart';
import 'package:nex_lab/screens/profile_screens/change_password_screen.dart';
import 'package:nex_lab/screens/profile_screens/logout_screen.dart';
import 'privacy_screen.dart'; // Import PrivacyScreen

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blue.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              trailing: Switch(value: true, onChanged: (bool value) {}),
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy & Terms'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help & Support'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              iconColor: Colors.red,
              selectedColor: Colors.red,
              textColor: Colors.red,
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogoutScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
