import 'package:flutter/material.dart';
import 'package:nex_lab/screens/profile_screens/about_screen.dart';
import 'package:nex_lab/screens/profile_screens/logout_screen.dart';
import 'package:nex_lab/screens/profile_screens/privacy_screen.dart';
import 'edit_profile_screen.dart'; // Import EditProfileScreen

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Monther';
  String email = 'monther69@example.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50, // Reduced size
                  backgroundImage: AssetImage('assets/profile.jpg'),
                  backgroundColor: Colors.blue.shade100,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 24, // Reduced size
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  email,
                  style: TextStyle(
                    fontSize: 16, // Reduced size
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.person, color: Colors.blue.shade900),
                  title: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue.shade900),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfileScreen()),
                    );
                    if (result != null) {
                      setState(() {
                        name = result['name'] ?? name;
                        email = result['email'] ?? email;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpansionTile(
                  leading: Icon(Icons.settings, color: Colors.blue.shade900),
                  title: Text(
                    'Settings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  children: [
                    ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text('Notifications'),
                      trailing: Switch(value: true, onChanged: (bool value) {}),
                    ),
                    ListTile(
                      leading: Icon(Icons.language),
                      title: Text('Language'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to Language Settings Screen
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.privacy_tip),
                      title: Text('Privacy'),
                      trailing: Icon(Icons.arrow_forward_ios),
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
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to Help & Support Screen
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text('About'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutUsScreen()),
                        );                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      iconColor: Colors.red,
                      textColor: Colors.red,
                      selectedColor: Colors.red,
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LogoutScreen()),
                        );
                        // Handle Logout
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpansionTile(
                  leading: Icon(Icons.payment, color: Colors.blue.shade900),
                  title: Text(
                    'Payment Methods',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  children: [
                    SizedBox(
                      height: 200, // Adjust height as needed
                      child: PageView(
                        children: [
                          _buildPaymentCard(
                            context,
                            'assets/Visa Card2.png',
                            'Visa Card',
                            'Visa Card',
                          ),
                          _buildPaymentCard(
                            context,
                            'assets/mobi2.png',
                            'Mobicash',
                            'Mobicash',
                          ),
                          _buildPaymentCard(
                            context,
                            'assets/Edfaly.png',
                            'Edfaly',
                            'Edfaly',
                          ),
                          _buildPaymentCard(
                            context,
                            'assets/Cash.jpg',
                            'Cash',
                            'Cash',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentCard(BuildContext context, String assetPath, String title, String method) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetPath, width: 100, height: 100), // Adjust image size as needed
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
          ),
          SizedBox(height: 10),
        
        ],
      ),
    );
  }
}
