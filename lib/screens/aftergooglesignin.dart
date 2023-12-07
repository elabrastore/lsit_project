import 'package:flutter/material.dart';
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
      body: Container(
        color: Colors.orange,
        child: Center(child: "AfterGoogleSignIn".text.make()),
      ),
    );
  }
}
