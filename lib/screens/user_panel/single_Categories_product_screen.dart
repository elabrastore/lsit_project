// ignore_for_file: file_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:list_fyp_project/models/catagory_model.dart';
import 'package:list_fyp_project/models/product-model.dart';
import 'package:list_fyp_project/screens/constant/image.dart';
import 'package:velocity_x/velocity_x.dart';

class AllsingleCategoriesproductScreen extends StatefulWidget {
  String categoryId;
  AllsingleCategoriesproductScreen({super.key, required this.categoryId});

  @override
  State<AllsingleCategoriesproductScreen> createState() =>
      _AllcategoriesScreenState();
}

class _AllcategoriesScreenState
    extends State<AllsingleCategoriesproductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(backgruond1), fit: BoxFit.fill)),
        ),
        title: Align(
          alignment: Alignment.center,
          child: widget.categoryId.text
              .fontWeight(FontWeight.bold)
              .color(Colors.white)
              .make(),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('products')
            .where("categoryId", isEqualTo: widget.categoryId)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No category found!"),
            );
          }

          if (snapshot.data != null) {
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 1.19),
              itemBuilder: (context, index) {
                final ProductData = snapshot.data!.docs[index];
                ProductModel productModel = ProductModel(
                    productId: ProductData["productId"],
                    categoryId: ProductData["categoryId"],
                    productName: ProductData["productName"],
                    categoryName: ProductData["categoryName"],
                    salePrice: ProductData["salePrice"],
                    fullPrice: ProductData["fullPrice"],
                    productImages: ProductData["productImages"],
                    deliveryTime: ProductData["deliveryTime"],
                    isSale: ProductData["isSale"],
                    productDescription: ProductData["productDescription"],
                    createdAt: ProductData["createdAt"],
                    updatedAt: ProductData["updatedAt"]);

                /* CategoriesModel categoriesModel = CategoriesModel(
                  categoryId: snapshot.data!.docs[index]['categoryId'],
                  catagoryImag: snapshot.data!.docs[index]['catagoryImag'],
                  catagoryName: snapshot.data!.docs[index]['catagoryName'],
                  createdAt: snapshot.data!.docs[index]['createdAt'],
                  updateAt: snapshot.data!.docs[index]['updateAt'],
                );*/
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width / 2.4,
                            heightImage: Get.height / 10,
                            imageProvider: CachedNetworkImageProvider(
                              productModel.productImages[0],
                            ),
                            title: Center(
                              child: Text(
                                productModel.productName,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
            /*   Container(
            height: Get.height / 5.0,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              
            ),
          );*/
          }

          return Container();
        },
      ),
    );
  }
}
