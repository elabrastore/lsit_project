// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:list_fyp_project/screens/appScreens/homescreen.dart';
import 'package:list_fyp_project/screens/constant/animation.dart';
import 'package:list_fyp_project/screens/user_panel/all_flash_sales_screen.dart';

import 'package:list_fyp_project/screens/user_panel/all_product_screen.dart';
import 'package:list_fyp_project/screens/user_panel/contactUs.dart';
import 'package:lottie/lottie.dart';

import 'package:velocity_x/velocity_x.dart';

import '../user_panel/orderScreen.dart';

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({
    super.key,
  });

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        backgroundColor: const Color.fromARGB(255, 255, 136, 0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 17,
            ),
            CircleAvatar(
              radius: 30, // Adjust the size of the avatar as needed
              backgroundColor:
                  Colors.grey[300], // Background color of the avatar
              child: const Icon(
                Icons.person, // Person icon
                size: 32, // Size of the person icon
                color: Colors.deepOrange, // Color of the person icon
              ),
            ),
            _currentUser != null
                ? ListTile(
                    title: Center(
                      child: Text(
                        _currentUser!.displayName ?? 'not found',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 5, 60, 104),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    subtitle: Center(
                      child: Text(
                        _currentUser!.email ?? 'not found',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 5, 60, 104),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 200, height: 200, child: Lottie.asset(profile)),
            "Version 2.0.0.1".text.bold.white.make(),
            Wrap(
              runSpacing: 10,
              children: [
                /* Padding(
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
                ),*/

                const Divider(
                  indent: 10,
                  endIndent: 10.0,
                  thickness: 1.5,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: "Flash Sale 📢 💯 🥳".text.white.make(),
                    onTap: () {
                      Get.to(() => const AllFlashsaleProductScreen(),
                          transition: Transition.fade,
                          duration: const Duration(seconds: 1));
                    },
                    leading: const Icon(
                      Icons.lock_clock,
                      color: Colors.white,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: "All Products".text.white.make(),
                    onTap: () {
                      Get.to(() => const AllProductScreen(),
                          transition: Transition.fade,
                          duration: const Duration(seconds: 1));
                    },
                    leading: const Icon(
                      Icons.production_quantity_limits,
                      color: Colors.white,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: "Your Orders".text.white.make(),
                    leading: const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Get.back();
                      Get.to(() => const OrderScreen(),
                          transition: Transition.fade,
                          duration: const Duration(seconds: 1));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: "contact 🤳".text.white.make(),
                    onTap: () {
                      Get.to(() => const ContactUs(),
                          transition: Transition.fade,
                          duration: const Duration(seconds: 1));
                    },
                    leading: const Icon(
                      Icons.help_center,
                      color: Colors.white,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListTile(
                        onTap: () async {
                          GoogleSignIn googleSignIn = GoogleSignIn();
                          FirebaseAuth _auth = FirebaseAuth.instance;
                          await _auth.signOut();
                          await googleSignIn.signOut();
                          Get.offAll(() => const AfterSplash(),
                              transition: Transition.fade,
                              duration: const Duration(seconds: 1));
                        },
                        titleAlignment: ListTileTitleAlignment.center,
                        title: "LogOut"
                            .text
                            .color(
                              const Color.fromARGB(255, 255, 136, 0),
                            )
                            .make(),
                        leading: const Icon(Icons.logout),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
