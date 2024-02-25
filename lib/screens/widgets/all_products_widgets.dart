import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import 'package:list_fyp_project/models/product-model.dart';
import 'package:list_fyp_project/screens/user_panel/product_detail_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class AllProductsWidget extends StatelessWidget {
  const AllProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('products')
          .where("isSale", isEqualTo: false)
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
            child: Text("No Product found!"),
          );
        }

        if (snapshot.data != null) {
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.90),
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
                      Get.to(() =>
                          ProductDetailScreen(productModel: productModel));
                    },
                    child: FillImageCard(
                      borderRadius: 20.0,
                      width: Get.width / 2.4,
                      heightImage: Get.height / 6,
                      imageProvider: CachedNetworkImageProvider(
                        productModel.productImages[0],
                      ),
                      title: Center(
                        child: Text(
                          productModel.productName,
                          style: const TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      footer: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          "Rs ${productModel.fullPrice}".text.make(),
                          const Icon(
                            CupertinoIcons.cart,
                            size: 20,
                            color: Colors.deepOrange,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }

        return Container();
      },
    );
  }
}
