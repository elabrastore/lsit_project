import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_fyp_project/controller/get_user_dataController.dart';
import 'package:list_fyp_project/screens/aftergooglesignin.dart';
import 'package:list_fyp_project/screens/appScreens/adminScreen/admin_screen.dart';
import 'package:list_fyp_project/screens/appScreens/homescreen.dart';
import 'package:lottie/lottie.dart';

import 'package:velocity_x/velocity_x.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override

  // initstate called only once in statefull widget

  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      loggin(context);
      // Get.offAll(() => const AfterSplash());
    });
  }

  Future<void> loggin(BuildContext context) async {
    if (user != null) {
      final GetUserDataController getUserDataController =
          Get.put(GetUserDataController());
      var userdata = await getUserDataController.getUserdata(user!.uid);
      if (userdata[0]["isAdmin"] == true) {
        Get.offAll(() => const AdminScreen());
      } else {
        Get.offAll(() => const AfterGoogleSignIn());
      }
    } else {
      Get.offAll(() => const AfterSplash());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/splash_animation.json')
              .box
              .size(700, 700)
              .make(),
        ],
      ),
    );
  }
}
