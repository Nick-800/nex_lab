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
import 'package:nex_lab/screens/main_screens/result_screen.dart';
import 'package:nex_lab/screens/profile_screens/profile_screen.dart';
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
    final icons = [Icons.science, Icons.bookmark];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.grey[300]!, Colors.grey[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: List.generate(titles.length, (index) {
          final isSelected = _currentSwappableIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _currentSwappableIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.blueAccent,
                            Colors.lightBlue
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.4),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(index == 0 ? 16 : 0),
                    right: Radius.circular(index == titles.length - 1 ? 16 : 0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icons[index],
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      titles[index],
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
                  Provider.of<AuthenticationProvider>(context, listen: false)
                      .logout()
                      .then((loggedOut) {
                    if (loggedOut) {
                      push(context, const ScreenRouter());
                    }
                  });
                },
        
        child: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
      ),
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Image.asset('assets/icons/nexlab_logo.png',
            width: 189, height: 33, fit: BoxFit.contain),
        actions: [
          const Icon(Icons.notifications, color: Colors.black, size: 40)
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: _selectedIndex == 1
          ? Column(
              children: [
                _buildSwappableRow(),
                Expanded(
                  child: IndexedStack(
                    index: _currentSwappableIndex,
                    children: [const TestsScreen(), const BookedTestsScreen()],
                  ),
                ),
              ],
            )
          : (_selectedIndex == 0
              ? const ResultScreen()
              : const Center(
                  child: ProfileScreen())), // Placeholder for Profile screen
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
