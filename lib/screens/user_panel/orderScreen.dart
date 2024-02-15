// ignore_for_file: file_names, avoid_print, sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import 'package:list_fyp_project/models/order_model.dart';
import 'package:list_fyp_project/screens/constant/animation.dart';
import 'package:lottie/lottie.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../controller/cardPrice_controller.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(user!.uid)
            .collection("confirmOrder")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: Get.height / 5,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No Product found!"),
            );
          }

          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final productsData = snapshot.data!.docs[index];
                OrderModel orderModel = OrderModel(
                  productId: productsData["productId"],
                  categoryId: productsData["categoryId"],
                  productName: productsData['productName'],
                  categoryName: productsData["categoryName"],
                  salePrice: productsData['salePrice'],
                  fullPrice: productsData['fullPrice'],
                  productImages: productsData['productImages'],
                  deliveryTime: productsData['deliveryTime'],
                  isSale: productsData['isSale'],
                  productDescription: productsData['productDescription'],
                  createdAt: productsData['createdAt'],
                  updatedAt: productsData['updatedAt'],
                  productQuantity: productsData["productQuantity"],
                  productTotalPrice: productsData["productTotalPrice"],
                  customerId: productsData["customerId"],
                  status: productsData["status"],
                  customerName: productsData["customerName"],
                  customerPhone: productsData["customerPhone"],
                  customerAddress: productsData["customerAddress"],
                  customerDeviceToken: productsData["customerDeviceToken"],
                );

                // Fetch value from cardprice controller (Calculate value)
                productPriceController.fetchProductPrice();
                return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 255, 128, 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InstaImageViewer(
                                  child: SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: CachedNetworkImage(
                                      imageUrl: orderModel.productImages[0],
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.orange,
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.deepOrangeAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InstaImageViewer(
                                  child: SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: CachedNetworkImage(
                                      imageUrl: orderModel.productImages[1],
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.orange,
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.deepOrangeAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InstaImageViewer(
                                  child: SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: CachedNetworkImage(
                                      imageUrl: orderModel.productImages[2],
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.orange,
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.deepOrangeAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            10.heightBox,
                            Row(
                              children: [
                                "Product Quantiy:".text.white.bold.make(),
                                5.widthBox,
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: orderModel.status == true
                                      ? Colors.green
                                      : Colors.red,
                                  child: Center(
                                    child: "${orderModel.productQuantity}"
                                        .text
                                        .white
                                        .bold
                                        .make(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                "Product Name: ${orderModel.productName}"
                                    .text
                                    .white
                                    .bold
                                    .make(),
                              ],
                            ),
                            Row(
                              children: [
                                "Delivery Time: ${orderModel.deliveryTime}"
                                    .text
                                    .bold
                                    .white
                                    .make(),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                "${orderModel.productTotalPrice} PKR"
                                    .toString()
                                    .text
                                    .white
                                    .bold
                                    .make(),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: orderModel.status == true
                                              ? Lottie.asset(
                                                  orderC,
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                )
                                              : Lottie.asset(
                                                  process,
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        orderModel.status == true
                                            ? Container(
                                                color: Colors.green,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: "Delived"
                                                      .text
                                                      .color(Colors.white)
                                                      .bold
                                                      .make(),
                                                ),
                                              )
                                            : Container(
                                                color: Colors.red,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: "Order in Process..."
                                                      .text
                                                      .bold
                                                      .size(16)
                                                      .color(Colors.white)
                                                      .make(),
                                                ),
                                              ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
