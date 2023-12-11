import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:list_fyp_project/controller/forgetcontroller.dart';

import 'package:list_fyp_project/screens/common_widgets/applogo.dart';
import 'package:velocity_x/velocity_x.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 136, 0),
        title: const Center(child: Text("Login")),
      ),
      body: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            applogowidget(),
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
            SizedBox(
              width: context.screenWidth - 50,
              child: ElevatedButton(
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
                child: const Text("Send ResetPs mail"),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
