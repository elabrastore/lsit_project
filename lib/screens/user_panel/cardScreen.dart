// ignore_for_file: file_names, avoid_print, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';

import 'package:list_fyp_project/models/Card_model.dart';
import 'package:list_fyp_project/screens/user_panel/checkOutScreen.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../controller/cardPrice_controller.dart';

class CardSceen extends StatefulWidget {
  const CardSceen({super.key});

  @override
  State<CardSceen> createState() => _CardSceenState();
}

class _CardSceenState extends State<CardSceen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(),
        title: Align(
          alignment: Alignment.center,
          child: "Card"
              .text
              .fontWeight(FontWeight.bold)
              .color(Colors.black)
              .make(),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('card')
            .doc(user!.uid)
            .collection("cardorders")
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
                CartModel cartModel = CartModel(
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
                    productTotalPrice: productsData["productTotalPrice"]);

                // Fetch value from cardprice controller (Calculate value)
                productPriceController.fetchProductPrice();
                return SwipeActionCell(
                  key: ObjectKey(cartModel.productId),
                  trailingActions: [
                    SwipeAction(
                        title: "Remove",
                        forceAlignmentToBoundary: true,
                        performsFirstActionWithFullSwipe: true,
                        onTap: (CompletionHandler handler) async {
                          print("Remove");

                          await FirebaseFirestore.instance
                              .collection("card")
                              .doc(user!.uid)
                              .collection("cardorders")
                              .doc(cartModel.productId)
                              .delete();
                        })
                  ],
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      title: Column(
                        children: [
                          "Product Quantiy: ${cartModel.productQuantity}"
                              .text
                              .make(),
                          cartModel.productName.text.make(),
                        ],
                      ),
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(cartModel.productImages[0]),
                        backgroundColor: Colors.orange,
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: "${cartModel.productTotalPrice} : PKR"
                                .toString()
                                .text
                                .make(),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (cartModel.productQuantity > 1) {
                                await FirebaseFirestore.instance
                                    .collection("card")
                                    .doc(user!.uid)
                                    .collection("cardorders")
                                    .doc(cartModel.productId)
                                    .update({
                                  "productQuantity":
                                      cartModel.productQuantity - 1,
                                  "productTotalPrice":
                                      (double.parse(cartModel.fullPrice) *
                                          (cartModel.productQuantity - 1))
                                });
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: "-".text.white.make(),
                              radius: 14,
                            ),
                          ),
                          8.widthBox,
                          GestureDetector(
                            onTap: () async {
                              if (cartModel.productQuantity > 0) {
                                await FirebaseFirestore.instance
                                    .collection("card")
                                    .doc(user!.uid)
                                    .collection("cardorders")
                                    .doc(cartModel.productId)
                                    .update({
                                  "productQuantity":
                                      cartModel.productQuantity + 1,
                                  "productTotalPrice":
                                      double.parse(cartModel.fullPrice) +
                                          double.parse(cartModel.fullPrice) *
                                              (cartModel.productQuantity)
                                });
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: "+".text.white.bold.make(),
                              radius: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 15.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              " Total".text.size(16).bold.make(),
              15.widthBox,
              Obx(
                () =>
                    "${productPriceController.totalPrice.toStringAsFixed(1)} PKR"
                        .text
                        .size(16)
                        .bold
                        .make(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 161, 9),
                  fixedSize: const Size(155, 50),
                ),
                onPressed: () {
                  Get.to(() => const CheckOutScreen());
                },
                child: "CheckOut".text.color(Colors.white).size(17).bold.make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}











 /*Container(
          child: ListView.builder(
        itemCount: 20,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: ListTile(
              title: "new dress for men".text.make(),
              leading: CircleAvatar(
                child: "Rao".text.white.make(),
                backgroundColor: Colors.orange,
              ),
              subtitle: Row(
                children: [
                  "2000".text.make(),
                  CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: "+".text.white.make(),
                    radius: 14,
                  ),
                  8.widthBox,
                  CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: "-".text.white.bold.make(),
                    radius: 14,
                  )
                ],
              ),
            ),
          );
        },
      )),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              " Total".text.size(16).bold.make(),
              15.widthBox,
              "RS 12000".text.size(16).bold.make(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  fixedSize: const Size(155, 50),
                ),
                onPressed: () {},
                child: "CheckOut".text.color(Colors.white).size(17).bold.make(),
              ),
            ],
          ),
        ),
      ),
    );*/