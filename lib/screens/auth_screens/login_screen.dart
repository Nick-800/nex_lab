// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:nex_lab/providers/authentication_provider.dart';
import 'package:nex_lab/screens/auth_screens/register_screen.dart';
import 'package:nex_lab/screens/auth_screens/screen_router.dart';
import 'package:nex_lab/widgets/clickables/buttons/main_button.dart';
import 'package:nex_lab/widgets/statics/custom_form_card.dart';
// import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:nex_lab/widgets/statics/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void login(formkey) {
    if (formkey.currentState!.validate()) {
      Provider.of<AuthenticationProvider>(context, listen: false).login({
        "email": emailController.text,
        "password": passwordController.text
      }).then((loggedIn) {
        if (loggedIn) {
          printDebug("55555555555555555555555555555555");
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => const ScreenRouter()),
              (route) => false);
        } else {
          printDebug("444444444444444444444444444444444444444");

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Login Failed"),
          ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/themes/Theme.png'), fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: CustomFormCard(
                width: getSize(context).width * 0.85,
                height: getSize(context).height * 0.65,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 48),
                      CustomTextField(
                        icon: const Icon(Icons.email),
                        label: "",
                        textEditingController: emailController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        icon: const Icon(Icons.lock),
                        secureText: true,
                        label: "Password",
                        textEditingController: passwordController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      isLoading
                          ? const CircularProgressIndicator()
                          : MainButton(
                              text: "Login",
                              onPressed: () => login(formKey),
                              inProgress: isLoading),
                      MainButton(
                        text: "Register",
                        onPressed: () => push(context, const RegisterScreen()),
                        btnColor: Colors.white,
                        txtColor: mainColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
