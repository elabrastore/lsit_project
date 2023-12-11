import 'package:flutter/material.dart';

import 'package:list_fyp_project/screens/constant/image.dart';
import 'package:list_fyp_project/screens/widgets/bannercustom.dart';
import 'package:list_fyp_project/screens/widgets/customDrawer.dart';
import 'package:list_fyp_project/screens/widgets/heading_widgets.dart';
import 'package:velocity_x/velocity_x.dart';

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
          child: Container(
            child: Column(
              children: [
                BannerWidget(),
                HeadingWidgets(),
              ],
            ),
          ),
        ));
  }
}
