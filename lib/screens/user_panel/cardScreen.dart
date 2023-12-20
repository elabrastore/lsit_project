// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constant/image.dart';

class CardSceen extends StatefulWidget {
  const CardSceen({super.key});

  @override
  State<CardSceen> createState() => _CardSceenState();
}

class _CardSceenState extends State<CardSceen> {
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
          child: "Card"
              .text
              .fontWeight(FontWeight.bold)
              .color(Colors.white)
              .make(),
        ),
      ),
      body: Container(
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
    );
  }
}
