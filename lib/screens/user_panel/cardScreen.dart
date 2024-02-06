// ignore_for_file: file_names, avoid_print, sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import 'package:list_fyp_project/models/Card_model.dart';
import 'package:list_fyp_project/screens/constant/animation.dart';
import 'package:list_fyp_project/screens/user_panel/all_categories_screen.dart';
import 'package:list_fyp_project/screens/user_panel/checkOutScreen.dart';
import 'package:list_fyp_project/screens/widgets/textGredient.dart';
import 'package:lottie/lottie.dart';

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
  bool get isCardNotEmpty => productPriceController.totalPrice > 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(),
        title: const Align(
          alignment: Alignment.center,
          child: TextGradient(
            data: "Cart",
            size: 25,
            weight: FontWeight.bold,
          ),
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No Product found!"),
                  SizedBox(
                      width: 200, height: 200, child: Lottie.asset(emptyBox)),
                ],
              ),
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

                          // Fetch value from cardprice controller (Calculate value)
                          productPriceController.fetchProductPrice();
                        })
                  ],
                  child: Card(
                    elevation: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 128, 1),
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
                                      imageUrl: cartModel.productImages[0],
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
                                      imageUrl: cartModel.productImages[1],
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
                                      imageUrl: cartModel.productImages[2],
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
                                "Product Quantiy :".text.white.bold.make(),
                                7.widthBox,
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.red,
                                  child: Center(
                                    child: "${cartModel.productQuantity}"
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
                                "Product Name : ${cartModel.productName}"
                                    .text
                                    .white
                                    .bold
                                    .make(),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                "${cartModel.productTotalPrice} : PKR"
                                    .toString()
                                    .text
                                    .white
                                    .bold
                                    .make(),
                                // Product decrement button
                                SizedBox(
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          if (cartModel.isSale == true) {
                                            if (cartModel.productQuantity > 1) {
                                              await FirebaseFirestore.instance
                                                  .collection("card")
                                                  .doc(user!.uid)
                                                  .collection("cardorders")
                                                  .doc(cartModel.productId)
                                                  .update({
                                                "productQuantity":
                                                    cartModel.productQuantity -
                                                        1,
                                                "productTotalPrice": (double
                                                        .parse(cartModel
                                                            .salePrice) *
                                                    (cartModel.productQuantity -
                                                        1))
                                              });
                                            }
                                          } else {
                                            if (cartModel.productQuantity > 1) {
                                              await FirebaseFirestore.instance
                                                  .collection("card")
                                                  .doc(user!.uid)
                                                  .collection("cardorders")
                                                  .doc(cartModel.productId)
                                                  .update({
                                                "productQuantity":
                                                    cartModel.productQuantity -
                                                        1,
                                                "productTotalPrice": (double
                                                        .parse(cartModel
                                                            .fullPrice) *
                                                    (cartModel.productQuantity -
                                                        1))
                                              });
                                            }
                                          }
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: "-".text.white.size(18).make(),
                                          radius: 17,
                                        ),
                                      ),
                                      8.widthBox,

                                      // Product increment button
                                      GestureDetector(
                                        onTap: () async {
                                          if (cartModel.isSale == true) {
                                            if (cartModel.productQuantity > 0) {
                                              await FirebaseFirestore.instance
                                                  .collection("card")
                                                  .doc(user!.uid)
                                                  .collection("cardorders")
                                                  .doc(cartModel.productId)
                                                  .update({
                                                "productQuantity":
                                                    cartModel.productQuantity +
                                                        1,
                                                "productTotalPrice": double
                                                        .parse(cartModel
                                                            .salePrice) +
                                                    double.parse(cartModel
                                                            .salePrice) *
                                                        (cartModel
                                                            .productQuantity)
                                              });
                                            }
                                          } else {
                                            if (cartModel.productQuantity > 0) {
                                              await FirebaseFirestore.instance
                                                  .collection("card")
                                                  .doc(user!.uid)
                                                  .collection("cardorders")
                                                  .doc(cartModel.productId)
                                                  .update({
                                                "productQuantity":
                                                    cartModel.productQuantity +
                                                        1,
                                                "productTotalPrice": double
                                                        .parse(cartModel
                                                            .fullPrice) +
                                                    double.parse(cartModel
                                                            .fullPrice) *
                                                        (cartModel
                                                            .productQuantity)
                                              });
                                            }
                                          }
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: "+"
                                              .text
                                              .white
                                              .size(18)
                                              .bold
                                              .make(),
                                          radius: 17,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
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
              const TextGradient(
                data: "Total",
                size: 20,
                weight: FontWeight.bold,
              ),
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
                  backgroundColor: const Color.fromARGB(255, 255, 136, 0),
                  fixedSize: const Size(155, 50),
                ),
                onPressed: () {
                  if (isCardNotEmpty) {
                    Get.to(() => const CheckOutScreen());
                  } else {
                    // Display an error message or handle the case where the card is empty
                    Get.snackbar(
                      "Empty Card",
                      "Your card is empty! Place order Now",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    Get.defaultDialog(
                        title: "Empty Cart",
                        titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                        middleText: "Your cart is empty! Place order Now",
                        middleTextStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        backgroundColor: Colors.red,
                        radius: 10,
                        textCancel: "Cancel",
                        cancelTextColor: Colors.white,
                        onConfirm: () {
                          Get.to(() => const AllcategoriesScreen());
                        },
                        confirmTextColor: Colors.red,
                        buttonColor: Colors.white,
                        textConfirm: "Buy Now");
                  }
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