// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_fyp_project/screens/user_panel/all_categories_screen.dart';
import 'package:list_fyp_project/screens/user_panel/all_flash_sales_screen.dart';
import 'package:list_fyp_project/screens/user_panel/all_product_screen.dart';
import 'package:list_fyp_project/screens/widgets/all_products_widgets.dart';
import 'package:list_fyp_project/screens/widgets/catagorywidget.dart';
import 'package:list_fyp_project/screens/widgets/flash_sale.dart';

import '../widgets/bannercustom.dart';
import '../widgets/heading_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Get.to(() => const AllcategoriesScreen(),
                    transition: Transition.fade,
                    duration: const Duration(seconds: 1));
              },
            ),
            const CategoriesWidget(),
            HeadingWidget(
              buttonText: "Show More",
              headingTitle: "Flash Sale",
              headingSubTitle: "Mega Sale in E-labra",
              onTap: () {
                Get.to(() => const AllFlashsaleProductScreen(),
                    transition: Transition.fade,
                    duration: const Duration(seconds: 1));
              },
            ),
            const FlashSale(),
            HeadingWidget(
              buttonText: "Show More",
              headingTitle: "All Categories",
              headingSubTitle: "According to your Budget",
              onTap: () {
                Get.to(() => const AllProductScreen(),
                    transition: Transition.fade,
                    duration: const Duration(seconds: 1));
              },
            ),
            const AllProductsWidget(),
          ],
        ),
      ),
    );
  }
}
