import 'package:flutter/material.dart';
import 'package:list_fyp_project/screens/constant/colors.dart';

import 'package:velocity_x/velocity_x.dart';

Widget homeScreencommon({color1, image, String? title1, ontap1}) {
  return Material(
    child: Container(
      decoration: BoxDecoration(
        color: tOnBoardingPage3Color2,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton.icon(
        icon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Image(image: AssetImage(image)),
        ),
        label: "$title1"
            .text
            .size(17)
            .fontWeight(FontWeight.bold)
            .color(color1)
            .make(),
        onPressed: ontap1,
      ),
    ),
  );
}
