// ignore_for_file: file_names, avoid_print

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:list_fyp_project/controller/get_device_token_cotroller.dart';
import 'package:list_fyp_project/models/usermodel.dart';
import 'package:list_fyp_project/screens/aftergooglesignin.dart';

class GoogleSignInController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
    final GetDeviceTokenController getDeviceTokenController =
        Get.put(GetDeviceTokenController());

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        //loading on

        EasyLoading.show(status: "Please wait");
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        final User? user = userCredential.user;

        if (user != null) {
          UserModel userModel = UserModel(
              uId: user.uid,
              username: user.displayName.toString(),
              email: user.email.toString(),
              phone: user.phoneNumber.toString(),
              userimage: user.photoURL.toString(),
              userDevicetoken: getDeviceTokenController.deviceToken.toString(),
              street: "",
              country: "",
              useraddress: "",
              isAdmin: false,
              isActive: true,
              createdOn: DateTime.now());

          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .set(userModel.toMap());

          // loading off
          EasyLoading.dismiss();

          Get.to(() => const AfterGoogleSignIn());
        }
      }
    } catch (e) {
      log(e.toString());
      EasyLoading.dismiss();
      Get.snackbar("$e", "Please check your internet!! ",
          icon: const Icon(Icons.network_cell, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
