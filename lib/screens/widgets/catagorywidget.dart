import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:list_fyp_project/models/catagory_model.dart';
import 'package:list_fyp_project/screens/user_panel/single_Categories_product_screen.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('catageries').get(),
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
          return SizedBox(
            height: Get.height / 5.0,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                CategoriesModel categoriesModel = CategoriesModel(
                  categoryId: snapshot.data!.docs[index]['categoryId'],
                  catagoryImag: snapshot.data!.docs[index]['catagoryImag'],
                  catagoryName: snapshot.data!.docs[index]['catagoryName'],
                  createdAt: snapshot.data!.docs[index]['createdAt'],
                  updateAt: snapshot.data!.docs[index]['updateAt'],
                );
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => AllsingleCategoriesproductScreen(
                              categoryId: categoriesModel.categoryId,
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width / 4.0,
                            heightImage: Get.height / 10,
                            imageProvider: CachedNetworkImageProvider(
                              categoriesModel.catagoryImag,
                            ),
                            title: Center(
                              child: Text(
                                categoriesModel.catagoryName,
                                style: const TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}
