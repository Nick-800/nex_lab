import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:nex_lab/screens/auth_screens/screen_router.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final PageController _pageController = PageController();
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          'About Us',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Nexlab',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Empowering Your Health Journey',
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'At Nexlab, our mission is to revolutionize healthcare by providing innovative solutions that enhance the patient experience and improve health outcomes. We strive to empower individuals to take control of their health through easy access to cutting-edge diagnostic services and personalized care.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
              ),
              const SizedBox(height: 30),
              Text(
                'Our Vision',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We envision a world where healthcare is seamless, personalized, and accessible to all. Our vision is to lead the way in healthcare innovation, using the latest technology to provide accurate diagnostics and comprehensive care, ensuring better health for everyone, everywhere.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
              ),
              const SizedBox(height: 30),
              Text(
                'Our Values',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '1. Innovation: We embrace cutting-edge technology to deliver the best healthcare solutions.\n\n2. Integrity: We are committed to maintaining the highest ethical standards in all we do.\n\n3. Compassion: We prioritize empathy and understanding in our patient care.\n\n4. Excellence: We strive for excellence in every aspect of our work.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
              ),
              const SizedBox(height: 30),
              Text(
                'Associated Labs',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200, // Adjust height as needed
                child: PageView(
                  controller: _pageController,
                  children: [
                    _buildLabCard('assets/lab1.jpg', 'Alakeed Lab'),
                    _buildLabCard('assets/lab2.jpg', 'Alsaleem Lab'),
                    _buildLabCard('assets/lab3.jpg', 'Al-Razi Lab'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Email: support@nexlab.global\nPhone: +218 92 472 7452\nAddress: Vanicia Street, Benghazi',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    pushAndRemoveUntil(context, const ScreenRouter());
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.blue.shade100),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Get Started'),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabCard(String assetPath, String labName) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                assetPath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              labName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
