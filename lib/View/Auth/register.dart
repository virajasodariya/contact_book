import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raj_contact_book/Constants/color.dart';
import 'package:raj_contact_book/Constants/text_style.dart';
import 'package:raj_contact_book/Controller/variable.dart';
import 'package:raj_contact_book/View/Auth/login.dart';
import 'package:raj_contact_book/View/Widget/snack_bar.dart';
import 'package:raj_contact_book/View/Widget/text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PickColor.kBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 75.h),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Text(
                    "SIGN UP",
                    style: FontTextStyle.kWhite30W500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Let us know about yourself",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CommonTextFormField(
                  keyboardType: TextInputType.name,
                  hintText: "Enter your name",
                  controller: RegisterVariable.nameController,
                  title: "Name",
                ),
                SizedBox(
                  height: 10.h,
                ),
                CommonTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Enter your email address",
                  controller: RegisterVariable.emailController,
                  title: "Email",
                ),
                SizedBox(
                  height: 10.h,
                ),
                CommonTextFormField(
                  keyboardType: TextInputType.number,
                  hintText: "Enter your password",
                  controller: RegisterVariable.passwordController,
                  title: "Password",
                ),
                SizedBox(
                  height: 10.h,
                ),
                CommonTextFormField(
                  keyboardType: TextInputType.number,
                  hintText: "Confirm your password",
                  controller: RegisterVariable.repeatPasswordController,
                  title: "Confirm Password",
                ),
                SizedBox(
                  height: 30.h,
                ),
                Visibility(
                  visible: !isLoading,
                  child: OutlinedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading =
                            true; // Show the loading indicator when the button is pressed.
                      });
                      if (formKey.currentState!.validate()) {
                        if (RegisterVariable.passwordController.text ==
                            RegisterVariable.repeatPasswordController.text) {
                          try {
                            UserCredential userCredential =
                                await auth.createUserWithEmailAndPassword(
                              email: RegisterVariable.emailController.text,
                              password:
                                  RegisterVariable.passwordController.text,
                            );

                            log('email---------->>>>>>>>>>${userCredential.user!.email}');
                            log('uid---------->>>>>>>>>>${userCredential.user!.uid}');

                            Get.offAll(const LogInScreen());
                          } on FirebaseAuthException catch (error) {
                            log('ERROR---------->>>>>>>>>>${error.message}');
                            showSnackBar(error.code);
                          } finally {
                            setState(() {
                              isLoading =
                                  false; // Hide the loading indicator when the task is done.
                            });
                          }
                        } else {
                          showSnackBar("Password doesn't match");
                          setState(() {
                            isLoading =
                                false; // Hide the loading indicator when the task is done.
                          });
                        }
                      } else {
                        setState(() {
                          isLoading =
                              false; // Hide the loading indicator when the task is done.
                        });
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(360.w, 38.h),
                      side: const BorderSide(
                        color: PickColor.k7B7B7B,
                        width: 2.50,
                      ),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: PickColor.kWhite,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: isLoading,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: PickColor.kWhite,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offAll(() => const LogInScreen());
                        },
                        child: Text(
                          "Log in.",
                          style: TextStyle(
                            color: PickColor.kOrange,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
