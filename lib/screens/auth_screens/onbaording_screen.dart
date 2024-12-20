import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/consts.dart';

import 'package:nex_lab/screens/auth_screens/terms_and_conditions.dart';
import 'package:nex_lab/widgets/clickables/buttons/main_button.dart';

class NexLabBoardingScreen extends StatefulWidget {
  const NexLabBoardingScreen({super.key});

  @override
  _NexLabBoardingScreenState createState() => _NexLabBoardingScreenState();
}

class _NexLabBoardingScreenState extends State<NexLabBoardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 370),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: mainColor),
        ),
        title: const Text(
          'Welcome to NexLab',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Colors.black54,
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.white,
            height: 4.0,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/themes/on_boarding_theme.png"),
                fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Your Trusted Medical Laboratory App',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0,
                        color: Colors.black54,
                      ),
                    ]),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                      if (index == 2) {
                        _animationController.forward();
                      } else {
                        _animationController.reset();
                      }
                    });
                  },
                  children: [
                    _buildServiceCard(
                      title: 'Blood Tests',
                      description:
                          'Comprehensive blood testing for all your needs.',
                      icon: Icons.bloodtype,
                    ),
                    _buildServiceCard(
                      title: 'COVID-19 Testing',
                      description:
                          'Reliable COVID-19 testing with quick results.',
                      icon: Icons.coronavirus,
                    ),
                    _buildServiceCard(
                      title: 'Genetic Testing',
                      description:
                          'Advanced genetic testing for health and ancestry.',
                      icon: Icons.biotech,
                    ),
                  ],
                ),
              ),
              Center(
                child: IconButton(
                  onPressed: _nextPage,
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  iconSize: 50,
                  padding: const EdgeInsets.all(10),
                  color: Colors.blue.shade50.withOpacity(0.8),
                  constraints:
                      const BoxConstraints(minWidth: 50, minHeight: 50),
                ),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Center(
                  child: MainButton(
                    btnColor: darkBlue,
                    txtColor: Colors.white,
                    borderColor: darkBlue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TermsAndConditionsScreen()),
                      );
                    },
                    text: 'Continue',
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
      {required String title,
      required String description,
      required IconData icon}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: Colors.blue.shade900),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }
}
