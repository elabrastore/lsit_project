// ignore_for_file: must_be_immutable, deprecated_member_use, prefer_const_declarations, non_constant_identifier_names, avoid_print

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

      await documentReference.update(
          {"productQuantity": updateQuantity, "productTotalPrice": totalPrice});

      EasyLoading.dismiss();

      Get.showSnackbar(
        const GetSnackBar(
          backgroundColor: Colors.orange,
          title: "product exist in card",
          message: "Product exist",
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

      Get.showSnackbar(
        const GetSnackBar(
          backgroundColor: Colors.orange,
          title: "Product added into cart Please check",
          message: "Check card",
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  static Future<void> sendMessageOnWhatsApp(
      {required ProductModel productModel}) async {
    EasyLoading.show(status: "Wait...");
    final phoneNumber = "+923064279507"; // Include the country code
    final message =
        "Hello\nWelcome to E-Labra store\nI want to know about this product\n${productModel.productName}\n${productModel.fullPrice}";

    final url =
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw "Could not launch URL";
      }
    } catch (e) {
      print("Error launching URL: $e");
      EasyLoading.dismiss();
    } finally {
      EasyLoading.dismiss();
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
                          fit: BoxFit.cover,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.productModel.isSale == true &&
                                      widget.productModel.salePrice != ""
                                  ? "RS: ${widget.productModel.salePrice}"
                                      .text
                                      .fontWeight(FontWeight.bold)
                                      .make()
                                  : "RS: ${widget.productModel.fullPrice}"
                                      .text
                                      .fontWeight(FontWeight.bold)
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
                              const TextGradient(
                                data: "Product Description:",
                                weight: FontWeight.bold,
                                size: 17,
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
                          child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                  widget.productModel.productImages[0]),
                              fit: BoxFit.cover),
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InstaImageViewer(
                          child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                  widget.productModel.productImages[1]),
                              fit: BoxFit.cover),
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InstaImageViewer(
                          child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                  widget.productModel.productImages[2]),
                              fit: BoxFit.cover),
                        ),
                      )),
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
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
                                "Add To Card"
                                    .text
                                    .color(Colors.white)
                                    .size(14)
                                    .bold
                                    .make(),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 5, 211, 36),
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
                                "Whatsapp"
                                    .text
                                    .color(Colors.white)
                                    .size(15)
                                    .bold
                                    .make(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
