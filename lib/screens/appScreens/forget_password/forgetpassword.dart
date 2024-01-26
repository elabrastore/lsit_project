import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:get/get.dart';
import 'package:list_fyp_project/controller/forgetcontroller.dart';

import 'package:list_fyp_project/screens/common_widgets/applogo.dart';
import 'package:lottie/lottie.dart';

import '../../constant/animation.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formkey = GlobalKey<FormState>();
  final ForgerPasswordController forgetpasswordController1 =
      Get.put(ForgerPasswordController());

  TextEditingController userEmail2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, iskeyboardVisibile3) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.jpg"),
                    fit: BoxFit.fill)),
          ),
          title: const Center(
              child: Text(
            "Forgot Password",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
        body: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iskeyboardVisibile3
                  ? const SizedBox(
                      height: 300,
                      width: 300,
                      child: Image(image: AssetImage("assets/images/Anas.png")))
                  : applogowidget(),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formkey,
                  child: TextFormField(
                    controller: userEmail2,
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
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6D00),
                    fixedSize: Size(MediaQuery.of(context).size.width - 32, 50),
                  ),
                  onPressed: () async {
                    String email = userEmail2.text.trim();

                    /* if (email.isEmpty) {
                    Get.snackbar("Error", "Missing Creditials",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white);
                  } else {
                    String email = userEmail2.text.trim();
                    forgetpasswordController1.forgetPasswordT(email);
                  }*/

                    if (email.isEmpty) {
                      Get.snackbar(
                        "Error",
                        "Please enter all details",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else {
                      String email = userEmail2.text.trim();
                      forgetpasswordController1.forgetPasswordT(email);
                    }
                  },
                  child: Row(
                    children: [
                      SizedBox(child: Lottie.asset(forgotpass)),
                      const Padding(
                        padding: EdgeInsets.only(left: 35),
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      );
    });
  }
}
