// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:list_fyp_project/screens/appScreens/homescreen.dart';

import 'package:list_fyp_project/screens/constant/image.dart';
import 'package:list_fyp_project/screens/user_panel/HomeScreen.dart';

import 'package:list_fyp_project/screens/user_panel/contactUs.dart';
import 'package:list_fyp_project/screens/user_panel/orderScreen.dart';

import 'package:list_fyp_project/screens/widgets/customDrawer.dart';

import 'package:velocity_x/velocity_x.dart';

import 'user_panel/CardScreen.dart';

class AfterGoogleSignIn extends StatefulWidget {
  const AfterGoogleSignIn({super.key});

  @override
  State<AfterGoogleSignIn> createState() => _AfterGoogleSignInState();
}

class _AfterGoogleSignInState extends State<AfterGoogleSignIn> {
  final items = const [
    Icon(
      Icons.home,
      size: 25,
    ),
    Icon(
      Icons.history,
      size: 25,
    ),
    Icon(
      Icons.add_shopping_cart_outlined,
      size: 25,
    ),
    Icon(
      Icons.support_agent_outlined,
      size: 25,
    ),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();
                FirebaseAuth _auth = FirebaseAuth.instance;
                await _auth.signOut();
                await googleSignIn.signOut();
                Get.offAll(() => const AfterSplash(),
                    transition: Transition.fade,
                    duration: const Duration(seconds: 1));
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.power_settings_new,
                  size: 25,
                ),
              )),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(backgruond1), fit: BoxFit.fill)),
        ),
        title: Align(
          alignment: Alignment.center,
          child: "ANAS SHOP"
              .text
              .fontWeight(FontWeight.bold)
              .color(Colors.white)
              .make(),
        ),
      ),
      drawer: const DrawerCustom(),
      body: getSelectedWidget(index: index),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              spreadRadius: 1,
              blurRadius: 100,
            ),
          ]),
          child: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: const Color.fromARGB(255, 255, 128, 1),
            animationDuration: const Duration(milliseconds: 300),
            height: 70,
            items: const [
              Icon(Icons.home, size: 25),
              Icon(Icons.history, size: 25),
              Icon(Icons.add_shopping_cart_outlined, size: 25),
              Icon(Icons.support_agent_outlined, size: 25),
            ],
            index: index,
            onTap: (selectedIndex) {
              setState(() {
                index = selectedIndex;
              });
            },
          ),
        ),
      ),

      /* SingleChildScrollView(
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
      ),*/
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const HomeScreen();
        break;
      case 1:
        widget = const OrderScreen();
        break;
      case 2:
        widget = const CardSceen();
        break;
      default:
        widget = const ContactUs();
        break;
    }

    return widget;
  }
}
