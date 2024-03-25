// ignore_for_file: camel_case_types, file_names, unnecessary_overrides, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class bannerController extends GetxController {
  RxList<String> bannerUrls = RxList<String>(
      []); // This variable is a reactive list that holds strings. Reactive means that when this list changes, it automatically updates any part of the user interface that depends on it.

  @override
  void onInit() {
    super.onInit();
    fetchBannersUrls();
  }

  //fetch banners
  Future<void> fetchBannersUrls() async {
    try {
      QuerySnapshot bannersSnapshot =
          await FirebaseFirestore.instance.collection('banners').get();

      if (bannersSnapshot.docs.isNotEmpty) {
        bannerUrls.value = bannersSnapshot.docs
            .map((doc) => doc['imagesUrl'] as String)
            .toList();
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
