// ignore_for_file: file_names

import 'dart:math';

String generateOrderId() {
  DateTime now = DateTime.now();

  int randomnumber = Random().nextInt(99999);
  String id = "${now.microsecondsSinceEpoch}_ $randomnumber";

  return id;
}
