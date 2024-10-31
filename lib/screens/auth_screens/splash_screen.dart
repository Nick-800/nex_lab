import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/screens/auth_screens/onbaording_screen.dart';
import 'package:nex_lab/screens/auth_screens/screen_router.dart';
// import 'package:nex_lab/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(animationDuration, () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>   NexLabBoardingScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/themes/Splash_Screen.png'), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
