import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:list_fyp_project/screens/constant/image.dart';
import 'package:list_fyp_project/screens/user_panel/all_categories_screen.dart';
import 'package:list_fyp_project/screens/user_panel/all_flash_sales_screen.dart';
import 'package:list_fyp_project/screens/user_panel/all_product_screen.dart';
import 'package:list_fyp_project/screens/widgets/all_products_widgets.dart';
import 'package:list_fyp_project/screens/widgets/bannercustom.dart';
import 'package:list_fyp_project/screens/widgets/catagorywidget.dart';
import 'package:list_fyp_project/screens/widgets/customDrawer.dart';
import 'package:list_fyp_project/screens/widgets/flash_sale.dart';
import 'package:list_fyp_project/screens/widgets/heading_widgets.dart';
import 'package:velocity_x/velocity_x.dart';

import 'user_panel/CardScreen.dart';

class AfterGoogleSignIn extends StatefulWidget {
  const AfterGoogleSignIn({super.key});

  @override
  State<AfterGoogleSignIn> createState() => _AfterGoogleSignInState();
}

class _AfterGoogleSignInState extends State<AfterGoogleSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(() => const CardSceen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
            child: "E-Labra"
                .text
                .fontWeight(FontWeight.bold)
                .color(Colors.white)
                .make(),
          ),
        ),
        drawer: const DrawerCustom(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const BannerWidget(),
              const SizedBox(
                height: 10,
              ),
              HeadingWidget(
                buttonText: "Show More",
                headingTitle: "Catagories",
                headingSubTitle: "low Budgets",
                onTap: () {
                  Get.to(() => const AllcategoriesScreen());
                },
              ),
              const CategoriesWidget(),
              HeadingWidget(
                buttonText: "Show More",
                headingTitle: "Flash Sale",
                headingSubTitle: "Mega Sale in E-labra",
                onTap: () {
                  Get.to(() => const AllFlashsaleProductScreen());
                },
              ),
              const FlashSale(),
              HeadingWidget(
                buttonText: "Show More",
                headingTitle: "All Categories",
                headingSubTitle: "According to your Budget",
                onTap: () {
                  Get.to(() => const AllProductScreen());
                },
              ),
              const AllProductsWidget(),
            ],
          ),
        ));
  }
}
