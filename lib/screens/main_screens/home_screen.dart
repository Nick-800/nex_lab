// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:nex_lab/providers/authentication_provider.dart';
import 'package:nex_lab/screens/auth_screens/screen_router.dart';
import 'package:nex_lab/screens/main_screens/inhome_screens/bookedtests_screen.dart';
import 'package:nex_lab/screens/main_screens/inhome_screens/tests_sceen.dart';
// import 'package:nex_lab/main_screens/inhome_screens/bookedtests_screen.dart';
// import 'package:nex_lab/screens/inhome_screens/tests_sceen.dart';
import 'package:nex_lab/screens/result_screen.dart';
import 'package:nex_lab/widgets/clickables/buttons/main_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkMode = false;
  int _selectedIndex = 0;
  int _currentSwappableIndex = 0;

  

  Widget _buildSwappableRow() {
    final titles = ['Tests', 'Booked Tests'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(titles.length, (index) {
        return GestureDetector(
          onTap: () => setState(() => _currentSwappableIndex = index),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _currentSwappableIndex == index
                  ? Colors.blue.withOpacity(0.5)
                  : greyColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                titles[index],
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: _currentSwappableIndex == index
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Image.asset('assets/icons/nexlab_logo.png',
            width: 189, height: 33, fit: BoxFit.contain),
        actions: [
          const Icon(Icons.circle_notifications, color: Colors.black, size: 40)
        ],
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade50),
              child: const Text('Nexlab',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              title: const Text('Darkmode'),
              trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) => setState(() => isDarkMode = value)),
            ),
            ListTile(
                title: const Text('About'),
                onTap: () => Navigator.pop(context)),
            ListTile(
                title: const Text('Contact'),
                onTap: () => Navigator.pop(context)),
            MainButton(
                onPressed: () {
                  Provider.of<AuthenticationProvider>(context, listen: false)
                      .logout()
                      .then((loggedOut) {
                    if (loggedOut) {
                      push(context, const ScreenRouter());
                    }
                  });
                },
                text: "Logout")
          ],
        ),
      ),
      body: _selectedIndex == 1
          ? Column(
              children: [
                _buildSwappableRow(),
                Expanded(
                  child: IndexedStack(
                    index: _currentSwappableIndex,
                    children: [
                      const TestsScreen(),
                      const BookedTestsScreen()
                      // const BookedTestsScreen(),
                    ],
                  ),
                ),
              ],
            )
          : (_selectedIndex == 0
              ? const ResultScreen()
              : const Center(
                  child: Text(
                      'Profile Screen'))), // Placeholder for Profile screen
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        unselectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Results'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }
}
