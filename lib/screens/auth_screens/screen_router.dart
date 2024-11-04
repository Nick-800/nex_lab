import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/providers/authentication_provider.dart';
import 'package:nex_lab/screens/auth_screens/login_screen.dart';
import 'package:nex_lab/screens/auth_screens/onbaording_screen.dart';
import 'package:nex_lab/screens/main_screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  @override
  void initState() {
    Provider.of<AuthenticationProvider>(context, listen: false)
        .initializeAuthProvider();
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

class OnBoardRouter extends StatefulWidget {
  const OnBoardRouter({super.key});

  @override
  State<OnBoardRouter> createState() => _OnBoardRouterState();
}

class _OnBoardRouterState extends State<OnBoardRouter> {
  @override
  void initState() {
    _checkFirstLaunch();
    super.initState();
  }

  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const NexLabBoardingScreen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ScreenRouter()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
