import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/providers/authentication_provider.dart';
import 'package:nex_lab/screens/auth_screens/login_screen.dart';
import 'package:nex_lab/screens/main_screens/home_screen.dart';
import 'package:provider/provider.dart';

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}
class _ScreenRouterState extends State<ScreenRouter> {
  @override
  void initState() {
    Provider.of<AuthenticationProvider>(context, listen: false).initializeAuthProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
        builder: (context, authenticationConsumer, child) {
      return AnimatedSwitcher(
        duration: animationDuration,
        child: authenticationConsumer.isAuthed
            ? const HomeScreen()
            : const LoginScreen(),
      );
    });
  }
}
