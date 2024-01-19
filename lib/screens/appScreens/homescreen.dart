import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_fyp_project/controller/googlesignIncontroller.dart';
import 'package:list_fyp_project/screens/appScreens/signIn/signin_screen.dart';
import 'package:list_fyp_project/screens/common_widgets/applogo.dart';
import 'package:list_fyp_project/screens/common_widgets/homescreen_common.dart';

import 'package:velocity_x/velocity_x.dart';

import '../constant/animation.dart';

class AfterSplash extends StatefulWidget {
  const AfterSplash({super.key});

  @override
  State<AfterSplash> createState() => _AfterSplashState();
}

class _AfterSplashState extends State<AfterSplash> {
  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              applogowidget(),
              const SizedBox(
                height: 30,
              ),
              50.heightBox,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Column(
                    children: [
                      homeScreencommon(
                          title1: "Sign in with Google",
                          animation1: emailsigin,
                          color1: Colors.white,
                          ontap1: () {
                            _googleSignInController.signInWithGoogle();
                          }),
                      20.heightBox,
                      homeScreencommon(
                          title1: "Sign in with E-mail",
                          animation1: googlesigin,
                          color1: Colors.white,
                          ontap1: () {
                            Get.to(() => const SigninScreen());
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
