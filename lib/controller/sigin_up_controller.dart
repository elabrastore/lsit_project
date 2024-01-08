// ignore_for_file: unused_field, body_might_complete_normally_nullable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:list_fyp_project/controller/get_device_token_cotroller.dart';
import 'package:list_fyp_project/models/usermodel.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetDeviceTokenController getDeviceTokenController =
      Get.put(GetDeviceTokenController());

  Future<UserCredential?> signUpMethod(
    String userName,
    String userPhone,
    String userEmail,
    String userPasswrod,
    String userConformPassword,
    String userDeviceToken,
  ) async {
    try {
      //loading is start in create users
      EasyLoading.show(status: " Wait a seconds");

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: userEmail, password: userPasswrod);

      // send email verification to users
      await userCredential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
          uId: userCredential.user!.uid,
          username: userName,
          email: userEmail,
          phone: userPhone,
          userimage: "",
          userDevicetoken: userDeviceToken,
          street: "",
          country: "",
          useraddress: "",
          isAdmin: false,
          isActive: true,
          createdOn: DateTime.now());

      // add data in database

      _firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());

      //loading is created then loading end
      EasyLoading.dismiss();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      log(e.code.toString());
      EasyLoading.dismiss();
      if (e.code == 'weak-password') {
        Get.snackbar("Weak Password", "The password provided is too weak.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } else if (e.code == "network-request-failed") {
        Get.snackbar("Internet error", "Please check your internet",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("email-already-in-use", "try another email",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Error: $e",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    }
  }
}
