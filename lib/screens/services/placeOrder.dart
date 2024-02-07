// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:list_fyp_project/models/order_model.dart';
import 'package:list_fyp_project/screens/constant/animation.dart';
import 'package:list_fyp_project/screens/user_panel/orderScreen.dart';
import 'package:lottie/lottie.dart';

import '../aftergooglesignin.dart';
import 'generate-OrderId-service.dart';

void placeOrder(
    {required BuildContext context,
    required String customerName,
    required String customerPhone,
    required String customeraddress,
    required String customerdeviceToken}) async {
  final user = FirebaseAuth.instance.currentUser;

  EasyLoading.show(status: "Please wait...");

  if (user != null) {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("card")
          .doc(user.uid)
          .collection("cardorders")
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

        String orderId = generateOrderId();

        OrderModel cartModel = OrderModel(
          productId: data["productId"],
          categoryId: data["categoryId"],
          productName: data['productName'],
          categoryName: data["categoryName"],
          salePrice: data['salePrice'],
          fullPrice: data['fullPrice'],
          productImages: data['productImages'],
          deliveryTime: data['deliveryTime'],
          isSale: data['isSale'],
          productDescription: data['productDescription'],
          createdAt: DateTime.now(),
          updatedAt: data['updatedAt'],
          productQuantity: data["productQuantity"],
          productTotalPrice: data["productTotalPrice"],
          customerId: user.uid,
          status: false,
          customerName: customerName,
          customerPhone: customerPhone,
          customerAddress: customeraddress,
          customerDeviceToken: customerdeviceToken,
        );

        for (var x = 0; x < documents.length; x++) {
          await FirebaseFirestore.instance
              .collection("orders")
              .doc(user.uid)
              .set({
            "uId": user.uid,
            "customerName": customerName,
            "customerPhone": customerPhone,
            "customerAddress": customeraddress,
            "customerdeviceToken": customerdeviceToken,
            "orderStatus": false,
            "createdAt": DateTime.now()
          });

          //orders uploaded

          await FirebaseFirestore.instance
              .collection("orders")
              .doc(user.uid)
              .collection("confirmOrder")
              .doc(orderId)
              .set(cartModel.toMap());

          //cart product deleted

          await FirebaseFirestore.instance
              .collection("card")
              .doc(user.uid)
              .collection("cardorders")
              .doc(cartModel.productId.toString())
              .delete()
              .then((value) => print(
                  "deleted card product  $cartModel.productId.toString()"));
        }
      }
      print("order conformed");

      EasyLoading.dismiss();
      Get.offAll(() => const AfterGoogleSignIn());
      Get.defaultDialog(
          content:
              SizedBox(height: 100, width: 100, child: Lottie.asset(orderC)),
          title: "Order Confirmed",
          titleStyle: const TextStyle(
              color: Color.fromARGB(255, 4, 127, 68),
              fontWeight: FontWeight.bold,
              fontSize: 17),
          middleText: "Your Order is confirmed",
          middleTextStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          backgroundColor: Colors.white,
          radius: 10,
          textCancel: "Cancel",
          cancelTextColor: Colors.black,
          onConfirm: () {
            Get.offAll(() => const OrderScreen());
          },
          confirmTextColor: Colors.white,
          buttonColor: const Color.fromARGB(255, 4, 127, 68),
          textConfirm: "Order Status");
    } catch (e) {
      print("error $e");
    }
  }
}
