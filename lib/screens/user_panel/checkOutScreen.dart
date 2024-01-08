// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';

import 'package:list_fyp_project/models/Card_model.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../controller/cardPrice_controller.dart';
import '../../controller/get-customer-device-token-controller.dart';
import '../constant/image.dart';
import '../services/placeOrder.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CardSceenState();
}

class _CardSceenState extends State<CheckOutScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? _validatePhoneNumber(value) {
    // Simple validation for a phone number starting with +92
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!value.startsWith('+92')) {
      return 'Phone number must start with +92';
    } else if (value.length != 13) {
      return "Please enter valid number";
    }
    return null; // Validation passed
  }

  String? _validateUsername(value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

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
          child: "CheckOut Screen"
              .text
              .fontWeight(FontWeight.bold)
              .color(Colors.white)
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
        margin: const EdgeInsets.only(bottom: 5.0),
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
                  backgroundColor: Colors.orange,
                  fixedSize: const Size(155, 50),
                ),
                onPressed: () {
                  bottomsheet();
                },
                child: "Confirm Order"
                    .text
                    .color(Colors.white)
                    .size(17)
                    .bold
                    .make(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void bottomsheet() {
    Get.bottomSheet(
        Container(
          height: Get.height * 0.5,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: TextFormField(
                            controller: nameController,
                            validator: _validateUsername,
                            decoration: const InputDecoration(
                                labelText: "User Name",
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 255, 136, 0)),
                                hintText: "Rao Anas",
                                isDense: true,
                                prefix: Icon(
                                  Icons.verified_user,
                                  size: 16,
                                  color: Color.fromARGB(255, 255, 136, 0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 136, 0),
                                )),
                                border: OutlineInputBorder(),
                                errorStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 15,
                                )),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: phoneController,
                            validator: _validatePhoneNumber,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                labelText: "Phone",
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 255, 136, 0)),
                                hintText: "+92306********507",
                                isDense: true,
                                prefix: Icon(
                                  Icons.phone,
                                  size: 16,
                                  color: Color.fromARGB(255, 255, 136, 0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 136, 0),
                                )),
                                border: OutlineInputBorder(),
                                errorStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 15,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: addressController,
                            validator: _validateUsername,
                            decoration: const InputDecoration(
                                labelText: "Address",
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 255, 136, 0)),
                                hintText: "Address",
                                isDense: true,
                                prefix: Icon(
                                  Icons.location_city,
                                  size: 16,
                                  color: Color.fromARGB(255, 255, 136, 0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 136, 0),
                                )),
                                border: OutlineInputBorder(),
                                errorStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 15,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width - 32, 50),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        if (nameController.text != "" &&
                            phoneController.text != "" &&
                            addressController.text != "") {
                          String name = nameController.text.trim();
                          String phone = phoneController.text.trim();
                          String address = addressController.text.trim();

                          String customerToken = await getCustomerDeviceToken();

                          // place order
                          placeOrder(
                              context: context,
                              customerName: name,
                              customerPhone: phone,
                              customeraddress: address,
                              customerdeviceToken: customerToken);
                        } else {
                          print("Fill the detail");
                        }
                      }
                    },
                    child: "Place Order".text.size(20).white.bold.make()),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        isDismissible: true,
        enableDrag: true,
        elevation: 4);
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