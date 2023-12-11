import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HeadingWidgets extends StatefulWidget {
  const HeadingWidgets({super.key});

  @override
  State<HeadingWidgets> createState() => _HeadingWidgetsState();
}

class _HeadingWidgetsState extends State<HeadingWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Categories"
                    .text
                    .fontWeight(FontWeight.bold)
                    .color(Colors.black)
                    .size(17)
                    .make(),
                "Low Budgets"
                    .text
                    .fontWeight(FontWeight.w500)
                    .size(12)
                    .color(Colors.grey)
                    .make(),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: const Color.fromARGB(
                      255,
                      255,
                      136,
                      0,
                    ),
                    width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: "See more"
                    .text
                    .fontWeight(FontWeight.bold)
                    .color(
                      const Color.fromARGB(
                        255,
                        255,
                        136,
                        0,
                      ),
                    )
                    .make(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
