// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:nex_lab/providers/authentication_provider.dart';
import 'package:nex_lab/screens/auth_screens/login_screen.dart';
import 'package:nex_lab/screens/auth_screens/register_screen.dart';
import 'package:nex_lab/screens/auth_screens/screen_router.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _swiperController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size(
                  MediaQuery.of(context).size.width * 0.8,
                  MediaQuery.of(context).size.height * 0.8)),
              child: PageView.builder(
                controller: _swiperController,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    color: index.isEven ? Colors.red : Colors.blue,
                    child: index == 0
                        ? const LoginScreen()
                        : const RegisterScreen(),
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: _swiperController,
              count: 2,
              effect: const WormEffect(
                dotColor: Colors.grey,
                activeDotColor: mainColor,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  // Your button action here
                },
                child: const Text("Button")),
            ElevatedButton(
                onPressed: () {
                  Provider.of<AuthenticationProvider>(context, listen: false)
                      .logout()
                      .then((loggedOut) => push(context, const ScreenRouter()));
                },
                child: const Text("Logout")),
          ],
        ),
      ),
    );
  }
}
