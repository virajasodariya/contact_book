import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String title) {
  Get.snackbar(
    title,
    '',
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.white.withOpacity(0.5),
    colorText: Colors.black,
  );
}
