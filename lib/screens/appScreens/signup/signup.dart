// ignore_for_file: unused_local_variable

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

  TextEditingController username = TextEditingController();
  TextEditingController phone1 = TextEditingController();
  TextEditingController email2 = TextEditingController();
  TextEditingController passwordT = TextEditingController();
  TextEditingController conformPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          child: "SignUp"
              .text
              .fontWeight(FontWeight.bold)
              .color(Colors.white)
              .make(),
        ),
      ),
      body: ListView(children: [
        Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              applogowidget(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: username,
                  autofocus: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter User Name";
                    } else {
                      return "Please Enter User Name";
                    }
                  },
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
                  autofocus: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Phone No";
                    } else {
                      return "Please Enter Valid Phone No";
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: "Phone",
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 136, 0)),
                      hintText: "0306********507",
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
                  controller: email2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "pleas enter Email";
                    } else if (!value.contains("@gmail.com")) {
                      return "please enter valid email";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "pleas enter Password";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "pleas enter ConformPassword";
                    }
                    return null;
                  },
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
                                ? const Color.fromARGB(255, 255, 136, 0)
                                : Colors.grey),
                        onPressed: () async {
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
                            Get.snackbar("Error", "Missing Creditials",
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
                        },
                        child: const Text("Create an Account"))
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
