import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:nex_lab/providers/authentication_provider.dart';
import 'package:nex_lab/screens/profile_screens/about_screen.dart';
import 'package:nex_lab/screens/profile_screens/logout_screen.dart';
import 'package:nex_lab/screens/profile_screens/privacy_screen.dart';
import 'package:nex_lab/screens/profile_screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthenticationProvider>(context, listen: false).getUser();
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
        builder: (context, authProvider, child) {
      if (authProvider.isLoading) {
        return const Center(child: CircularProgressIndicator(
              color: darkBlue,
              strokeWidth: 5,
            ));
      }
      if (authProvider.isFailed) {
        return const Center(child: Text('Failed to load user data'));
      }

      if (authProvider.user == null) {
        return const Center(child: Text('No user found'));
      }

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
                    backgroundImage: const AssetImage('assets/profile.png'),
                    backgroundColor: Colors.blue.shade100,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    authProvider.user!.name, // Display user name
                    style: TextStyle(
                      fontSize: 24, // Reduced size
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Text(
                    authProvider.user!.email, // Display user email
                    style: TextStyle(
                      fontSize: 16, // Reduced size
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.blue.shade900),
                    title: const Text(
                      'Edit Profile',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Colors.blue.shade900),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  EditProfileScreen(user: authProvider.user! ,)),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    leading: Icon(Icons.settings, color: Colors.blue.shade900),
                    title: const Text(
                      'Settings',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    collapsedBackgroundColor: Colors.transparent, 
                    backgroundColor: Colors.transparent, 
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide.none, // Add this line
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide.none, // Add this line
                    ),
                    children: [
                      ListTile(
                        leading: const Icon(Icons.notifications),
                        title: const Text('Notifications'),
                        trailing:
                            Switch(value: true, onChanged: (bool value) {}),
                      ),
                      ListTile(
                        leading: const Icon(Icons.language),
                        title: const Text('Language'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          push(context, const SettingsScreen());
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.privacy_tip),
                        title: const Text('Privacy'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PrivacyScreen()),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.help),
                        title: const Text('Help & Support'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                         
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.info),
                        title: const Text('About'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutUsScreen()),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Logout'),
                        iconColor: Colors.red,
                        textColor: Colors.red,
                        selectedColor: Colors.red,
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogoutScreen()),
                          );
                         
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    leading: Icon(Icons.payment, color: Colors.blue.shade900),
                    title: const Text(
                      'Payment Methods',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    collapsedBackgroundColor: Colors.transparent, 
                    backgroundColor: Colors.transparent, 
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide.none, // Add this line
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide.none, // Add this line
                    ),
                    children: [
                      SizedBox(
                        height: 200, 
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
    });
  }

  Widget _buildPaymentCard(
      BuildContext context, String assetPath, String title, String method) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetPath,
              width: 100, height: 100), // Adjust image size as needed
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
