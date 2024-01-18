// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:list_fyp_project/screens/constant/colors.dart';
import 'package:lottie/lottie.dart';

import 'package:velocity_x/velocity_x.dart';

Widget homeScreencommon({color1, animation1, String? title1, ontap1}) {
  return Material(
    child: InkWell(
      onTap: ontap1,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: tOnBoardingPage3Color2,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2), // Change the offset as needed
              blurRadius: 5, // Change the blur radius as needed
              spreadRadius: 2, // Change the spread radius as needed
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Lottie.asset(animation1),
            ),
            "$title1".text.white.bold.size(20).make(),
          ],
        ),
      ),
    ),
  );
}
