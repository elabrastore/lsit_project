import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

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
                          image: AssetImage("assets/images/login.jpeg"))
                      : applogowidget(),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
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
                      onPressed: () {},
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 136, 0),
                      ),
                      onPressed: () {},
                      child: "Log in"
                          .text
                          .color(Colors.white)
                          .minFontSize(16)
                          .make(),
                    ),
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
