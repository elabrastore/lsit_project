import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Center(child: "Admin Panel".text.make()),
      ),
    );
  }
}
