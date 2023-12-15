// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:list_fyp_project/controller/get_user_dataController.dart';

import 'package:list_fyp_project/controller/sigin_controller.dart';
import 'package:list_fyp_project/screens/aftergooglesignin.dart';
import 'package:list_fyp_project/screens/appScreens/adminScreen/admin_screen.dart';
import 'package:list_fyp_project/screens/appScreens/forget_password/forgetpassword.dart';

import 'package:list_fyp_project/screens/appScreens/signup/signup.dart';

import 'package:list_fyp_project/screens/common_widgets/applogo.dart';
import 'package:list_fyp_project/screens/constant/colors.dart';

import 'package:velocity_x/velocity_x.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  bool passwordVisible2 = true;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, iskeyboardVisibile) {
      return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.jpg"),
                    fit: BoxFit.fill)),
          ),
          title: Align(
            alignment: Alignment.center,
            child: "Sigin"
                .text
                .fontWeight(FontWeight.bold)
                .color(Colors.white)
                .make(),
          ),
        ),
        body: ListView(children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iskeyboardVisibile
                      ? const Image(
                          image: AssetImage("assets/images/login.png"))
                      : applogowidget(),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: userEmail,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Pleas Enter Email";
                      } else if (!value.contains("@gmail.com")) {
                        return "Please Enter Valid Email";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Email",
                        prefix: Icon(
                          Icons.email,
                          size: 15,
                          color: Color.fromARGB(255, 255, 136, 0),
                        ),
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 255, 136, 0)),
                        hintText: "Anas@gmail.com",
                        isDense: true,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 136, 0),
                        )),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15,
                        )),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: userPassword,
                    obscureText: passwordVisible2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Pleas Enter Password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "  Password",
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 136, 0)),
                        hintText: "********Anas",
                        prefix: const Icon(Icons.security),
                        border: const OutlineInputBorder(),
                        suffixIcon: InkWell(
                          onTap: () {
                            if (passwordVisible2 == true) {
                              passwordVisible2 = false;
                            } else {
                              passwordVisible2 = true;
                            }
                            setState(() {});
                          },
                          child: Icon(
                            passwordVisible2
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        isDense: true,
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 136, 0),
                        )),
                        errorStyle: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => const ForgetPassword());
                      },
                      child: "Forget Password"
                          .text
                          .color(const Color.fromARGB(255, 255, 0, 0))
                          .minFontSize(14)
                          .make(),
                    ),
                  ),
                  SizedBox(
                    width: context.screenWidth - 50,
                    height: 50,
                    child: TextButton(
                      child: const Text(
                        "SIGN IN",
                        style:
                            TextStyle(color: Color.fromARGB(255, 255, 136, 0)),
                      ),
                      onPressed: () async {
                        String email = userEmail.text.trim();
                        String password = userPassword.text.trim();

                        if (email.isEmpty || password.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please enter all details",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor:
                                const Color.fromARGB(255, 255, 136, 0),
                            colorText: Colors.white,
                          );
                        } else {
                          UserCredential? userCredential =
                              await signInController.signInMethod(
                                  email, password);

                          var userData = await getUserDataController
                              .getUserdata(userCredential!.user!.uid);

                          if (userCredential != null) {
                            if (userCredential.user!.emailVerified) {
                              //
                              if (userData[0]['isAdmin'] == true) {
                                Get.snackbar(
                                  "Success Admin Login",
                                  "login Successfully!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 136, 0),
                                  colorText: Colors.white,
                                );
                                Get.offAll(() => AdminScreen());
                              } else {
                                Get.offAll(() => AfterGoogleSignIn());
                                Get.snackbar(
                                  "Success User Login",
                                  "login Successfully!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 136, 0),
                                  colorText: Colors.white,
                                );
                              }
                            } else {
                              Get.snackbar(
                                "Error",
                                "Please verify your email before login",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 136, 0),
                                colorText: Colors.white,
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Error",
                              "Please try again",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 136, 0),
                              colorText: Colors.white,
                            );
                          }
                        }
                      },
                    ),

                    /* ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 136, 0),
                      ),
                      onPressed: () async {
                        String email = userEmail.text.trim();
                        String password2 = userPassword.text.trim();

                        if (email.isEmpty || password2.isEmpty) {
                          Get.snackbar("Error", "Missing Creditials",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        } else {
                          UserCredential? userCredential =
                              await signInController.signInMethod(
                                  email, password2);

                          var userData = await getUserDataController
                              .getUserdata(userCredential!.user!.uid);

                          if (userCredential != null) {
                            if (userCredential.user!.emailVerified) {
                              if (userData[0]["isadmin"] == true) {
                                Get.offAll(() => const AdminScreen());
                                Get.snackbar(
                                    "Success Admin Pannel", "login Success",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              } else {
                                Get.offAll(() => const AfterGoogleSignIn());
                                Get.snackbar(
                                    "Success User Login", "login Success",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              }
                            } else {
                              Get.snackbar("Error",
                                  "Please verifiy your email before login",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                            }
                          } else {
                            Get.snackbar("Error", "Please try again",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        }
                      },
                      child: "Log in"
                          .text
                          .color(Colors.white)
                          .minFontSize(16)
                          .make(),
                    ),*/
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Do not have an account?".text.color(Colors.black).make(),
                      6.widthBox,
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const Signup());
                        },
                        child: "Sign Up"
                            .text
                            .size(16)
                            .fontWeight(FontWeight.bold)
                            .color(tOnBoardingPage3Color2)
                            .make(),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ]),
      );
    });
  }
}
