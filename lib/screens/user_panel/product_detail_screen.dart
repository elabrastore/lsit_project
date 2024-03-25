// ignore_for_file: must_be_immutable, deprecated_member_use, prefer_const_declarations, non_constant_identifier_names, avoid_print

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:list_fyp_project/models/product-model.dart';
import 'package:list_fyp_project/screens/constant/image.dart';
import 'package:list_fyp_project/screens/user_panel/cardScreen.dart';
import 'package:list_fyp_project/screens/user_panel/checkOutScreen.dart';
import 'package:list_fyp_project/screens/widgets/textGredient.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/Card_model.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailScreen({super.key, required this.productModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> checkProduct(
      {required String uId, int Quantityincrement = 1}) async {
    try {
      EasyLoading.show(status: "Please Wait..");
      final DocumentReference documentReference = FirebaseFirestore.instance
          .collection("card")
          .doc(uId)
          .collection("cardorders")
          .doc(widget.productModel.productId.toString());
      DocumentSnapshot snapshot = await documentReference.get();

      if (snapshot.exists) {
        int currentQuantity = snapshot["productQuantity"];
        int updateQuantity = currentQuantity + Quantityincrement;
        double totalPrice = double.parse(widget.productModel.isSale == true
                ? widget.productModel.salePrice
                : widget.productModel.fullPrice) *
            updateQuantity;

        await documentReference.update({
          "productQuantity": updateQuantity,
          "productTotalPrice": totalPrice
        });

        EasyLoading.dismiss();

        Get.defaultDialog(
            title: "Product Already Exist ",
            titleStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
            middleText: "Product already exist in the cart and Add One More ",
            middleTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            backgroundColor: const Color.fromARGB(255, 255, 136, 0),
            radius: 10,
            textCancel: "Cancel",
            onConfirm: () {
              Get.to(() => const CheckOutScreen());
            },
            textConfirm: "CheckOut");

        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: Colors.red,
            title: "Product Already Exist ",
            message: "Product already exist in the cart and Add One More ",
            icon: Icon(Icons.refresh),
            duration: Duration(seconds: 3),
          ),
        );

        print("product exist in card");
      } else {
        await FirebaseFirestore.instance
            .collection("card")
            .doc(uId)
            .set({"uId": uId, "createdAt": DateTime.now()});

        EasyLoading.show(status: "plaese wait");

        CartModel cartModel = CartModel(
            productId: widget.productModel.productId,
            categoryId: widget.productModel.categoryId,
            productName: widget.productModel.productName,
            categoryName: widget.productModel.categoryName,
            salePrice: widget.productModel.salePrice,
            fullPrice: widget.productModel.fullPrice,
            productImages: widget.productModel.productImages,
            deliveryTime: widget.productModel.deliveryTime,
            isSale: widget.productModel.isSale,
            productDescription: widget.productModel.productDescription,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            productQuantity: 1,
            productTotalPrice: double.parse(widget.productModel.isSale == true
                ? widget.productModel.salePrice
                : widget.productModel.fullPrice));
        await documentReference.set(cartModel.toMap());

        EasyLoading.dismiss();

        Get.defaultDialog(
            title: "Cart Now",
            titleStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
            middleText: "Product added into cart",
            middleTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            backgroundColor: const Color.fromARGB(255, 255, 136, 0),
            radius: 10,
            textCancel: "Cancel",
            onConfirm: () {
              Get.to(() => const CardSceen());
            },
            textConfirm: "Cart");

        /* Get.showSnackbar(
        const GetSnackBar(
          backgroundColor: Colors.orange,
          title: "Product added into cart Please check",
          message: "Check card",
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
        ),
      );*/
      }
    } catch (e) {
      log(e.toString());
      EasyLoading.dismiss();
      Get.snackbar(
        'Internet Issue',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  static Future<void> sendMessageOnWhatsApp({
    required ProductModel productModel,
  }) async {
    EasyLoading.show(status: "Wait...");
    final number = "+923064279507";
    final message =
        "Hello \n Welcome to ANAS Store \n I want to know about this product \n ${productModel.productName} \n ${productModel.productId}";

    final url = 'https://wa.me/$number?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      EasyLoading.dismiss();
      throw 'Could not launch $url';
    }
  }

  /*static Future<void> sendMessageonWhatsapp(
      {required ProductModel productModel}) async {
    EasyLoading.show(status: "Wait...");
    final number = "03064279507";
    final message =
        "Hello \n Welcome to E-Labra store \n i want to know about this product \n ${productModel.productName} \n ${productModel.fullPrice} ";

    final url = "https://wa.me/$number?text=${Uri.encodeComponent(message)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not lanuch url";
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => const CardSceen());
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add_shopping_cart_outlined),
            ),
          )
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(backgruond1), fit: BoxFit.fill)),
        ),
        title: Align(
          alignment: Alignment.center,
          child: "Product Detail"
              .text
              .fontWeight(FontWeight.bold)
              .color(Colors.white)
              .make(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            10.heightBox,
            CarouselSlider(
                items: widget.productModel.productImages
                    .map(
                      (imageUrls) => ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          imageUrl: imageUrls,
                          fit: BoxFit.fill,
                          width: Get.width - 10,
                          placeholder: (context, url) => const ColoredBox(
                            color: Colors.white,
                            child: Center(
                              child: CupertinoActivityIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  aspectRatio: 2.5,
                  height: 300.0,
                  viewportFraction: 1,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              widget.productModel.isSale == true &&
                                      widget.productModel.salePrice != ""
                                  ? "PKR ${widget.productModel.salePrice} 🎉🎉"
                                      .text
                                      .fontWeight(FontWeight.bold)
                                      .size(20)
                                      .make()
                                  : "PKR ${widget.productModel.fullPrice} "
                                      .text
                                      .fontWeight(FontWeight.bold)
                                      .size(20)
                                      .make(),
                              10.widthBox,
                              widget.productModel.isSale == true
                                  ? Text(
                                      "${widget.productModel.fullPrice} PKR",
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 15,
                                        color: Colors.deepOrange,
                                      ),
                                    )
                                  : "Hurry Up!! buy Now 🎉🎊"
                                      .text
                                      .bold
                                      .color(Colors.deepOrangeAccent)
                                      .make(),
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 200,
                      child: Divider(
                        color: Colors.orange,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: TextGradient(
                            data: widget.productModel.productName,
                            size: 25,
                            weight: FontWeight.bold,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: "Category: ${widget.productModel.categoryName}"
                              .text
                              .bold
                              .make()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  TextGradient(
                                    data: "Product Description:",
                                    weight: FontWeight.bold,
                                    size: 20,
                                  ),
                                ],
                              ),
                              " ${widget.productModel.productDescription}"
                                  .text
                                  .make(),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InstaImageViewer(
                        child: CachedNetworkImage(
                          imageUrl: widget.productModel.productImages[0],
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                            backgroundColor: Colors.orange,
                            valueColor:
                                AlwaysStoppedAnimation(Colors.deepOrangeAccent),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InstaImageViewer(
                            child: CachedNetworkImage(
                                imageUrl: widget.productModel.productImages[1],
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                      backgroundColor: Colors.orange,
                                      valueColor: AlwaysStoppedAnimation(
                                          Colors.deepOrangeAccent),
                                    )))),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InstaImageViewer(
                            child: CachedNetworkImage(
                                imageUrl: widget.productModel.productImages[2],
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                      backgroundColor: Colors.orange,
                                      valueColor: AlwaysStoppedAnimation(
                                          Colors.deepOrangeAccent),
                                    )))),
                    10.heightBox,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius
                    .zero, // Set border radius to zero for a square button
              ),
              fixedSize: const Size(155, 50),
            ),
            onPressed: () async {
              await checkProduct(uId: user!.uid);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                ),
                "Add To Card".text.color(Colors.white).size(14).bold.make(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius
                      .zero, // Set border radius to zero for a square button
                ),
                backgroundColor: const Color.fromARGB(255, 5, 211, 36),
                fixedSize: const Size(147, 50),
              ),
              onPressed: () {
                sendMessageOnWhatsApp(
                  productModel: widget.productModel,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                  "Whatsapp".text.color(Colors.white).size(15).bold.make(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
