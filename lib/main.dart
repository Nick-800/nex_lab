import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nex_lab/providers/authentication_provider.dart';
import 'package:nex_lab/providers/result_provider.dart';
import 'package:nex_lab/providers/test_provider.dart';
import 'package:nex_lab/screens/auth_screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
            create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider<ResultProvider>(create: (_) => ResultProvider()),
        ChangeNotifierProvider<TestProvider>(create: (_)=> TestProvider())
      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.cairo().fontFamily,
         
         

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
