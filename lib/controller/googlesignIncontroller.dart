// ignore_for_file: file_names, unused_local_variable, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:list_fyp_project/models/usermodel.dart';
import 'package:list_fyp_project/screens/aftergooglesignin.dart';

class GoogleSignInController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
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
              userDevicetoken: "",
              street: "",
              country: "",
              useraddress: "",
              isAdmin: false,
              isActive: true,
              createdOn: DateTime.now());

          await FirebaseFirestore.instance
              .collection("user")
              .doc(user.uid)
              .set(userModel.toMap());

          // loading off
          EasyLoading.dismiss();

          Get.to(() => const AfterGoogleSignIn());
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      print(e.hashCode);
    }
  }
}
