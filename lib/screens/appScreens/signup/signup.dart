// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_fyp_project/controller/sigin_up_controller.dart';

import 'package:list_fyp_project/screens/appScreens/signIn/signin_screen.dart';
import 'package:list_fyp_project/screens/common_widgets/applogo.dart';
import 'package:list_fyp_project/screens/constant/colors.dart';

import 'package:velocity_x/velocity_x.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final SignUpController signUpController = Get.put(SignUpController());
  bool? ischeck = false;
  bool passwordVisible = true;
  bool confirmpassVisible = true;

  //form validation
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? _validationEmail(value) {
    if (value == null || value.isEmpty) {
      return "Please enter email";
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!emailRegExp.hasMatch(value)) {
      return "Please Enter a valid Email";
    }

    return null;
  }

  String? _validatePhoneNumber(value) {
    // Simple validation for a phone number starting with +92
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!value.startsWith('+92')) {
      return 'Phone number must start with +92';
    } else if (value.length != 13) {
      return "Please enter valid number";
    }
    return null; // Validation passed
  }

  String? _validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(
            r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(value)) {
      return 'Password must contain at least one lowercase letter, one uppercase letter, one digit, and one special character';
    }
    return null;
  }

  String? _validateUsername(value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  TextEditingController username = TextEditingController();
  TextEditingController phone1 = TextEditingController();
  TextEditingController email2 = TextEditingController();
  TextEditingController passwordT = TextEditingController();
  TextEditingController conformPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.fill)),
        ),
        title: Align(
          alignment: Alignment.center,
          child: "SignUp"
              .text
              .fontWeight(FontWeight.bold)
              .color(Colors.white)
              .make(),
        ),
      ),
      body: ListView(children: [
        Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              applogowidget(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: username,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  validator: _validateUsername,
                  decoration: const InputDecoration(
                      labelText: "User Name",
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 136, 0)),
                      hintText: "Rao Anas",
                      isDense: true,
                      prefix: Icon(
                        Icons.verified_user,
                        size: 16,
                        color: Color.fromARGB(255, 255, 136, 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 136, 0),
                      )),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: phone1,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  autofocus: false,
                  validator: _validatePhoneNumber,
                  decoration: const InputDecoration(
                      labelText: "Phone",
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 136, 0)),
                      hintText: "+92306********507",
                      isDense: true,
                      prefix: Icon(
                        Icons.phone,
                        size: 16,
                        color: Color.fromARGB(255, 255, 136, 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 136, 0),
                      )),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  controller: email2,
                  validator: _validationEmail,
                  decoration: const InputDecoration(
                      labelText: "Email",
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 136, 0)),
                      hintText: "Anas@gmail.com",
                      isDense: true,
                      prefix: Icon(
                        Icons.mail,
                        size: 16,
                        color: Color.fromARGB(255, 255, 136, 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 136, 0),
                      )),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: passwordT,
                  obscureText: passwordVisible,
                  validator: _validatePassword,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 255, 136, 0)),
                      hintText: "********Anas",
                      border: const OutlineInputBorder(),
                      suffixIcon: InkWell(
                        child: Icon(
                          passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onTap: () {
                          if (passwordVisible == true) {
                            passwordVisible = false;
                          } else {
                            passwordVisible = true;
                          }
                          setState(() {});
                        },
                      ),
                      isDense: true,
                      prefix: const Icon(Icons.password),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 136, 0),
                      )),
                      errorStyle: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: conformPassword,
                  obscureText: confirmpassVisible,
                  textInputAction: TextInputAction.next,
                  validator: _validatePassword,
                  decoration: InputDecoration(
                      labelText: "ConformPassword",
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 255, 136, 0)),
                      hintText: "********Anas",
                      isDense: true,
                      prefix: const Icon(Icons.security),
                      suffixIcon: InkWell(
                        child: Icon(
                          confirmpassVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onTap: () {
                          if (confirmpassVisible == true) {
                            confirmpassVisible = false;
                          } else {
                            confirmpassVisible = true;
                          }
                          setState(() {});
                        },
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 136, 0),
                      )),
                      border: const OutlineInputBorder(),
                      errorStyle: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    "Do not have an account?"
                        .text
                        .fontWeight(FontWeight.bold)
                        .color(Colors.black)
                        .make(),
                    6.widthBox,
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const SigninScreen());
                      },
                      child: "Sign In"
                          .text
                          .size(16)
                          .fontWeight(FontWeight.bold)
                          .color(tOnBoardingPage3Color2)
                          .make(),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(
                      activeColor: Colors.white,
                      checkColor: const Color.fromARGB(255, 255, 136, 0),
                      value: ischeck,
                      onChanged: (newValue) {
                        ischeck = newValue;
                        setState(() {});
                      }),
                  Expanded(
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: "I agree to the",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text: " Terms and Conditions",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 136, 0))),
                      TextSpan(
                          text: " &",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 136, 0))),
                      TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 136, 0)))
                    ])),
                  )
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: context.screenWidth - 50,
                height: 50,
                child: ischeck == true
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ischeck == true
                                ? const Color(0xFFFF6D00)
                                : Colors.grey),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            String name = username.text.trim();
                            String phone = phone1.text.trim();
                            String email = email2.text.trim();
                            String password = passwordT.text.trim();
                            String cpassword = conformPassword.text.trim();
                            String userDeviceToken = "";

                            if (email == "" ||
                                password == "" ||
                                cpassword == "" ||
                                name == "" ||
                                phone == "") {
                              Get.snackbar("Error", "Missing Credential!!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                            } else if (password != cpassword) {
                              Get.snackbar("Error ",
                                  "Password and ConfirmPassword do not Match",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                            } else {
                              UserCredential? userCredential =
                                  await signUpController.signUpMethod(
                                      name,
                                      phone,
                                      email,
                                      password,
                                      cpassword,
                                      userDeviceToken);
                              if (userCredential != null) {
                                Get.snackbar("verification Email send ",
                                    "Please Check your Email",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);

                                FirebaseAuth.instance.signOut();
                                Get.offAll(() => const SigninScreen());
                              }
                            }
                          }
                        },
                        child: const Text(
                          "Create an Account",
                          style: TextStyle(color: Colors.white),
                        ))
                    : Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        child: const Center(
                          child: Text(
                            " Note : Please Tickmark the CheckBox and then create an account",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
