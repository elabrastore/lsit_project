// ignore_for_file: non_constant_identifier_names, prefer_final_fields, file_names

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_fyp_project/screens/constant/animation.dart';
import 'package:list_fyp_project/screens/constant/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class InternetConnectivity extends GetxController {
  Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(Netstatus);
  }

  void Netstatus(List<ConnectivityResult> results) {
    var cr = results.isNotEmpty ? results.last : ConnectivityResult.none;
    if (cr == ConnectivityResult.none) {
      Get.rawSnackbar(
        titleText: Container(
          width: double.infinity,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Container(
                height: 100,
                width: 100,
                child: Lottie.asset(internetError, fit: BoxFit.cover),
              )),
              "No internet Connection".text.color(Colors.white).size(25).make()
            ],
          ),
        ),
        messageText: Container(
          child: ElevatedButton(
            onPressed: () {
              _connectivity.checkConnectivity(); // Retry internet connectivity
            },
            child: const Text('Retry'),
          ),
        ),
        backgroundColor: tOnBoardingPage3Color2,
        isDismissible: false,
        duration: const Duration(days: 1),
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
