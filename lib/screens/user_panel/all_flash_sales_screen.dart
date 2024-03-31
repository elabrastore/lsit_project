import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:list_fyp_project/models/product-model.dart';
import 'package:list_fyp_project/screens/constant/image.dart';

import 'package:velocity_x/velocity_x.dart';

import 'product_detail_screen.dart';

class AllFlashsaleProductScreen extends StatefulWidget {
  const AllFlashsaleProductScreen({super.key});

  @override
  State<AllFlashsaleProductScreen> createState() =>
      _AllFlashsaleProductScreenState();
}

class _AllFlashsaleProductScreenState extends State<AllFlashsaleProductScreen> {
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
          child: "Flash Sales Products"
              .text
              .fontWeight(FontWeight.bold)
              .color(Colors.white)
              .make(),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('products')
            .where("isSale", isEqualTo: true)
            .get(),
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
              child: Text("No category found!"),
            );
          }

          if (snapshot.data != null) {
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
              ),
              itemBuilder: (context, index) {
                final productsData = snapshot.data!.docs[index];
                ProductModel productModel = ProductModel(
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
                );
                /* CategoriesModel categoriesModel = CategoriesModel(
                    categoryId: snapshot.data!.docs[index]['categoryId'],
                    catagoryImag: snapshot.data!.docs[index]['catagoryImag'],
                    catagoryName: snapshot.data!.docs[index]['catagoryName'],
                    createdAt: snapshot.data!.docs[index]['createdAt'],
                    updateAt: snapshot.data!.docs[index]['updateAt'],
                  );*/
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(
                            () => ProductDetailScreen(
                                  productModel: productModel,
                                ),
                            transition: Transition.fade,
                            duration: const Duration(seconds: 1));
                      },
                      child: FillImageCard(
                        borderRadius: 20.0,
                        width: Get.width / 2.4,
                        heightImage: Get.height / 8,
                        imageProvider: CachedNetworkImageProvider(
                          productModel.productImages[0],
                        ),
                        title: Center(
                          child: Text(
                            productModel.productName,
                            style: const TextStyle(fontSize: 12.0),
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
