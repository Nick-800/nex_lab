// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:nex_lab/providers/authentication_provider.dart';
import 'package:nex_lab/screens/auth_screens/screen_router.dart';
import 'package:nex_lab/widgets/clickables/buttons/main_button.dart';
import 'package:nex_lab/widgets/statics/custom_form_card.dart';
import 'package:nex_lab/widgets/statics/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final PageController pageController = PageController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female'];

  void register(formKey) {
    if (formKey.currentState!.validate()) {
      Provider.of<AuthenticationProvider>(context, listen: false).register({
        "name": "${firstNameController.text} ${lastNameController.text}",
        "email": emailController.text,
        "password": passwordController.text,
        "phone": phoneController.text,
        "gender": selectedGender!.toLowerCase(),
        "DOB": dobController.text,
        "location": locationController.text,
      }).then((loggedIn) {
        if (loggedIn) {
          pushAndRemoveUntil(context, const ScreenRouter());
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Registered Successfully"),
          ));
        } else {

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Register Failed"),
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
                width: getSize(context).width * 1,
                height: getSize(context).height * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 48),
                      SizedBox(
                        height: getSize(context).height * 0.5,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints.loose(Size(
                                    getSize(context).width * 0.8,
                                    getSize(context).height * 0.48)),
                                child: PageView.builder(
                                  controller: pageController,
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      color: Colors.white,
                                      child: index == 0
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: CustomTextField(
                                                            icon: const Icon(
                                                                Icons.tag),
                                                            label: "Name",
                                                            textEditingController:
                                                                firstNameController,
                                                            validate: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Required field';
                                                              }
                                                              return null;
                                                            }),
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Expanded(
                                                        child: CustomTextField(
                                                            icon: const Icon(
                                                                Icons.tag),
                                                            label: "Surname",
                                                            textEditingController:
                                                                lastNameController,
                                                            validate: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Required field';
                                                              }
                                                              return null;
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                  CustomTextField(
                                                    icon:
                                                        const Icon(Icons.email),
                                                    label: "Email",
                                                    textEditingController:
                                                        emailController,
                                                    validate: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your email';
                                                      }
                                                      if (!RegExp(
                                                              r'^[^@]+@[^@]+\.[^@]+')
                                                          .hasMatch(value)) {
                                                        return 'Please enter a valid email';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  CustomTextField(
                                                    icon:
                                                        const Icon(Icons.lock),
                                                    secureText: true,
                                                    label: "Password",
                                                    textEditingController:
                                                        passwordController,
                                                    validate: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your password';
                                                      }
                                                      if (value.length < 8) {
                                                        return 'Password must be at least 8 characters long';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  CustomTextField(
                                                      icon: const Icon(
                                                          Icons.lock),
                                                      label: "Confirm Password",
                                                      textEditingController:
                                                          confirmPasswordController,
                                                      validate: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter your password';
                                                        }
                                                        if (value !=
                                                            passwordController
                                                                .text) {
                                                          return 'Password does not match';
                                                        }
                                                        return null;
                                                      }),
                                                ],
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                children: [
                                                  CustomTextField(
                                                    icon:
                                                        const Icon(Icons.phone),
                                                    label: "Phone",
                                                    textEditingController:
                                                        phoneController,
                                                    validate: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your phone number';
                                                      }
                                                      if (value.length != 10) {
                                                        return 'Phone number must be exactly 10 digits';
                                                      }
                                                      return null;
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 24,
                                                  ),
                                                  TextFormField(
                                                    controller: dobController,
                                                    decoration: InputDecoration(
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .never,
                                                      icon: const Icon(
                                                          Icons.date_range),
                                                      labelText: 'DOB',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.black
                                                          .withOpacity(0.08),
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 15.0,
                                                              horizontal: 10.0),
                                                    ),
                                                    readOnly: true,
                                                    onTap: () async {
                                                      DateTime? pickedDate =
                                                          await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(1900),
                                                        lastDate:
                                                            DateTime.now(),
                                                      );

                                                      if (pickedDate != null) {
                                                        String formattedDate =
                                                            DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(
                                                                    pickedDate);
                                                        setState(() {
                                                          dobController.text =
                                                              formattedDate;
                                                        });
                                                      }
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your date of birth';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 24,
                                                  ),
                                                  DropdownButtonFormField<
                                                      String>(
                                                    decoration: InputDecoration(
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .never,
                                                      icon: const Icon(
                                                          Icons.people),
                                                      labelText: 'Gender',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.black
                                                          .withOpacity(0.08),
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 15.0,
                                                              horizontal: 10.0),
                                                    ),
                                                    value: selectedGender,
                                                    items: genderOptions
                                                        .map((String gender) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: gender,
                                                        child: Text(gender),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        selectedGender =
                                                            newValue;
                                                      });
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please select your gender';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                    );
                                  },
                                ),
                              ),
                              SmoothPageIndicator(
                                controller: pageController,
                                count: 2,
                                effect: const WormEffect(
                                  dotColor: Colors.grey,
                                  activeDotColor: mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      isLoading
                          ? const CircularProgressIndicator()
                          : MainButton(
                              text: "Register",
                              onPressed: () => register(formKey)),
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
