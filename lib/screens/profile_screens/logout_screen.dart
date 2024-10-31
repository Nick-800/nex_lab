import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:nex_lab/providers/authentication_provider.dart';
import 'package:nex_lab/screens/auth_screens/screen_router.dart';
import 'package:nex_lab/widgets/clickables/buttons/cancel_button.dart';
import 'package:nex_lab/widgets/clickables/buttons/main_button.dart';
import 'package:provider/provider.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  String? _userName;

  @override
  void initState() {
    super.initState();
    _retrieveUser();
  }

  void _retrieveUser() {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    setState(() {
      _userName =
          authProvider.user?.name; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
        backgroundColor: Colors.blue.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_userName != null)
                Text(
                  'Hello, $_userName',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 20),
              const Text(
                'Are you sure you want to log out?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainButton(
                    onPressed: () => Navigator.pop(context),
                    text: 'Cancel',
                  ),
                  CancelButton(
                    onPressed: () {
                      Provider.of<AuthenticationProvider>(context,
                              listen: false)
                          .logout()
                          .then((loggedOut) {
                        if (loggedOut) {
                          push(context, const ScreenRouter());
                        }
                      });
                    },
                    text: 'Logout',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
