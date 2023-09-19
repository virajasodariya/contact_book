import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:raj_contact_book/Constants/color.dart';
import 'package:raj_contact_book/Constants/image_path.dart';
import 'package:raj_contact_book/Constants/text_style.dart';
import 'package:raj_contact_book/View/Auth/login.dart';
import 'package:raj_contact_book/View/Home/all_contact.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(
        () => box.read('userId') == null
            ? const LogInScreen()
            : AllContactScreen(userId: box.read('userId')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PickColor.kBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagePath.appLogo, height: 120),
            SizedBox(
              height: 20.sp,
            ),
            Text(
              "CallBlocker",
              style: FontTextStyle.kWhite30W500,
            ),
            SizedBox(height: 10.h),
            Text(
              "Ultimate Call Protection App",
              style: FontTextStyle.kWhite30W500,
            ),
          ],
        ),
      ),
    );
  }
}
