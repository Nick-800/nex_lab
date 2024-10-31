// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/providers/booked_tests_provider.dart';
import 'package:nex_lab/providers/test_provider.dart';
import 'package:nex_lab/screens/main_screens/inhome_screens/bookedtests_screen.dart';
import 'package:nex_lab/screens/main_screens/inhome_screens/tests_sceen.dart';
import 'package:nex_lab/screens/main_screens/result_screen.dart';
import 'package:nex_lab/screens/profile_screens/profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookedTestsProvider>(context, listen: false).getBookedTests();
      Provider.of<TestProvider>(context, listen: false).getTests();
    });
  }

  bool isDarkMode = false;
  int _selectedIndex = 0;
  int _currentSwappableIndex = 0;

  Widget _buildSwappableRow() {
    final titles = ['Tests', 'Booked Tests'];
    final icons = [Icons.science, Icons.bookmark];
    return Container(
      decoration: BoxDecoration(
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
              onTap: () {
                setState(() => _currentSwappableIndex = index);
                initializeData();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                decoration: BoxDecoration(
                  color: isSelected ? darkBlue : Colors.transparent,
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
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: Image.asset('assets/icons/nexlab_logo.png',
            width: 189, height: 33, fit: BoxFit.contain),
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
