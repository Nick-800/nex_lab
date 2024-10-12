import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/functions_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: formkey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getSize(context).height * 0.4,
              horizontal: getSize(context).width * 0.2),
          child: SingleChildScrollView(
              child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: Colors.red,
                width: 102,
                height: 102,
                child: Column(
                  
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
