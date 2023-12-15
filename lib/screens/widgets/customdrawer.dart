// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:list_fyp_project/screens/appScreens/homescreen.dart';

import 'package:velocity_x/velocity_x.dart';

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({super.key});

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: "waris".text.make(),
                subtitle: "version 1.1.0.1".text.make(),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: Colors.black,
                  child: "w".text.make(),
                ),
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: "Home".text.make(),
                leading: Icon(Icons.home),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: "Products".text.make(),
                leading: Icon(Icons.production_quantity_limits),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: "orders".text.make(),
                leading: Icon(Icons.shopping_bag),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: "contact".text.make(),
                leading: const Icon(Icons.help_center),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListTile(
                onTap: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  await googleSignIn.signOut();
                  Get.offAll(() => const AfterSplash());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: "LogOut".text.make(),
                leading: Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
