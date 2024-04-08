// ignore_for_file: prefer_final_fields

import 'dart:developer';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:list_fyp_project/models/catagory_model.dart';
import 'package:list_fyp_project/screens/constant/image.dart';
import 'package:list_fyp_project/screens/user_panel/single_Categories_product_screen.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AllcategoriesScreen extends StatefulWidget {
  const AllcategoriesScreen({Key? key}) : super(key: key);

  @override
  State<AllcategoriesScreen> createState() => _AllcategoriesScreenState();
}

class _AllcategoriesScreenState extends State<AllcategoriesScreen> {
  late List<CategoriesModel> _categories;
  late List<CategoriesModel> _filteredCategories;
  var voiceSearch = "";
  var islistening = false;

  TextEditingController _voiceSearchController = TextEditingController();

  SpeechToText speechToText = SpeechToText();

  @override
  void initState() {
    super.initState();
    _categories = [];
    _filteredCategories = [];
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('catageries').get();
      List<CategoriesModel> categories = snapshot.docs.map((doc) {
        return CategoriesModel(
          categoryId: doc['categoryId'],
          catagoryImag: doc['catagoryImag'],
          catagoryName: doc['catagoryName'],
          createdAt: doc['createdAt'],
          updateAt: doc['updateAt'],
        );
      }).toList();

      setState(() {
        _categories = categories;
        _filteredCategories = categories;
      });
    } catch (ex) {
      log(ex.toString());
    }
  }

  // filteration functionality
  /*void filterCategories(String query) {
    List<CategoriesModel> filteredList = _categories.where((category) {
      return category.catagoryName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredCategories = filteredList;
    });
  }*/

  // Voice Search Functionality
  void filterVoiceCategories(String voiceSearch) {
    List<CategoriesModel> filteredList = _categories.where((category) {
      return category.catagoryName
          .toLowerCase()
          .contains(voiceSearch.toLowerCase());
    }).toList();

    setState(() {
      _filteredCategories = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AvatarGlow(
        animate: islistening,
        duration: const Duration(milliseconds: 2000),
        glowColor: Colors.orange,
        repeat: true,
        child: GestureDetector(
          onTapDown: (details) async {
            setState(() async {
              if (!islistening) {
                var available = await speechToText.initialize();
                if (available) {
                  setState(() {
                    islistening = true;
                    speechToText.listen(onResult: (result) {
                      setState(() {
                        voiceSearch = result.recognizedWords;
                        _voiceSearchController.text = voiceSearch;
                        filterVoiceCategories(voiceSearch);
                      });
                    });
                  });
                }
              }
            });
          },
          onTapUp: (details) {
            setState(() {
              islistening = false;
            });
            speechToText.stop();
          },
          child: CircleAvatar(
            backgroundColor: Colors.deepOrange,
            radius: 35,
            child: Icon(
              islistening ? Icons.mic : Icons.mic_none,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(backgruond1), fit: BoxFit.fill)),
        ),
        title: Align(
          alignment: Alignment.center,
          child: TextField(
            controller: _voiceSearchController,
            onChanged: (voiceSearch) {
              filterVoiceCategories(voiceSearch);
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  _voiceSearchController.clear(); // Clear the text field
                  filterVoiceCategories(''); // Clear the filtering
                },
                icon: const Icon(Icons.clear, color: Colors.white),
              ),
              hintText: "Search Categories",
              hintStyle: const TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            GridView.builder(
              itemCount: _filteredCategories.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                childAspectRatio: 1.19,
              ),
              itemBuilder: (context, index) {
                CategoriesModel category = _filteredCategories[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(
                        () => AllsingleCategoriesproductScreen(
                            categoryId: category.categoryId),
                        transition: Transition.fade,
                        duration: const Duration(seconds: 1));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FillImageCard(
                      borderRadius: 20.0,
                      width: Get.width / 2.4,
                      heightImage: Get.height / 10,
                      imageProvider:
                          CachedNetworkImageProvider(category.catagoryImag),
                      title: Center(
                        child: Text(
                          category.catagoryName,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}




// old code
/*class AllcategoriesScreen extends StatefulWidget {
  const AllcategoriesScreen({super.key});

  @override
  State<AllcategoriesScreen> createState() => _AllcategoriesScreenState();
}

class _AllcategoriesScreenState extends State<AllcategoriesScreen> {
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
          child: "All Categoreis"
              .text
              .fontWeight(FontWeight.bold)
              .color(Colors.white)
              .make(),
        ),
      ),
      body: FutureBuilder(
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
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 1.19),
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
                            categoryId: categoriesModel.categoryId));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FillImageCard(
                          borderRadius: 20.0,
                          width: Get.width / 2.4,
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
*/
