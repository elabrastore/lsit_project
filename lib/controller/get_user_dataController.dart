// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class GetUserDataController extends GetxController {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Object?>>> getUserdata(String uId) async {
    final QuerySnapshot userData =
        await _firebase.collection("users").where("uId", isEqualTo: uId).get();
    return userData.docs;
  }
}
