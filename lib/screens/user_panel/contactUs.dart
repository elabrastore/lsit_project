// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(),
        title: Align(
          alignment: Alignment.center,
          child: "Contact Screen"
              .text
              .fontWeight(FontWeight.bold)
              .color(Colors.black)
              .make(),
        ),
      ),
    );
  }
}
