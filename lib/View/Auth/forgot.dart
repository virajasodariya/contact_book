import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raj_contact_book/Constants/color.dart';
import 'package:raj_contact_book/Constants/text_style.dart';
import 'package:raj_contact_book/Controller/variable.dart';
import 'package:raj_contact_book/View/Widget/text_form_field.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final formKey = GlobalKey<FormState>();

  void openLink() async {
    if (formKey.currentState!.validate()) {
      const linkUrl =
          "https://contact-book-35d44.firebaseapp.com/__/auth/action?mode=action&oobCode=code";
      if (await canLaunch(linkUrl)) {
        await launch(linkUrl);
      } else {
        throw 'Could not launch $linkUrl';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PickColor.kBlack,
      body: Padding(
        padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 75.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Text(
                  "FORGOT PASSWORD",
                  style: FontTextStyle.kWhite30W500,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Unlock Your World: Rediscover Your Password!",
                style: FontTextStyle.k8B8B8B14W500.copyWith(fontSize: 15.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              Form(
                key: formKey,
                child: CommonTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Enter your email address",
                  controller: ForgotPasswordVariable.emailController,
                  title: "Email",
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              // CommonTextFormField(
              //   keyboardType: TextInputType.emailAddress,
              //   hintText: "Enter New Password",
              //   controller: ForgotPasswordVariable.newPasswordController,
              //   title: "New Password",
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // CommonTextFormField(
              //   keyboardType: TextInputType.emailAddress,
              //   hintText: "Enter Confirm Password",
              //   controller: ForgotPasswordVariable.newConfirmPasswordController,
              //   title: "Confirm Password",
              // ),
              SizedBox(
                height: 30.h,
              ),
              ElevatedButton(
                onPressed: openLink,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  fixedSize: Size(400.w, 50.h),
                  side: BorderSide(
                    color: PickColor.k7B7B7B,
                    width: 2.50.sp,
                  ),
                ),
                child: Text(
                  "login your account with a new password",
                  style: FontTextStyle.kWhite22W400.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
