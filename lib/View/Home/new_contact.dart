import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raj_contact_book/Constants/color.dart';
import 'package:raj_contact_book/Constants/text_style.dart';
import 'package:raj_contact_book/Controller/variable.dart';
import 'package:raj_contact_book/View/Home/all_contact.dart';
import 'package:raj_contact_book/View/Widget/snack_bar.dart';
import 'package:raj_contact_book/View/Widget/text_form_field.dart';

class NewContactScreen extends StatefulWidget {
  const NewContactScreen({super.key});

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  String countryCode = "91";

  final box = GetStorage();
  final formKey = GlobalKey<FormState>();

  DocumentReference? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseFirestore.instance
        .collection('User')
        .doc('${box.read('userId')}')
        .collection('Number')
        .doc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PickColor.kBlack,
      appBar: AppBar(
        backgroundColor: PickColor.kBlack,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18.sp,
            color: PickColor.kWhite,
          ),
        ),
        title: const Text("New Contacts",
            style: TextStyle(fontFamily: "JosefinSans")),
        titleTextStyle: FontTextStyle.kWhite30W500.copyWith(
          fontSize: 18.sp,
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                try {
                  user!.set({
                    "firstName": AddContactVariable.firstnameController.text,
                    "lastName": AddContactVariable.lastnameController.text,
                    "phoneNumber":
                        "$countryCode ${AddContactVariable.numberController.text}",
                  });

                  Get.offAll(() => const AllContactScreen());
                } catch (error) {
                  log('ERROR---------->>>>>>>>>>$error');
                  showSnackBar('$error');
                }
              }
            },
            icon: Icon(
              Icons.check,
              color: PickColor.kWhite,
              size: 25.sp,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                CommonTextFormField(
                  keyboardType: TextInputType.name,
                  hintText: "Enter First Name",
                  prefixIcon: const Icon(Icons.person_2_outlined),
                  controller: AddContactVariable.firstnameController,
                  title: "First Name",
                ),
                SizedBox(
                  height: 10.h,
                ),
                CommonTextFormField(
                  keyboardType: TextInputType.name,
                  hintText: "Enter Last Name",
                  prefixIcon: const Icon(Icons.person_2_outlined),
                  controller: AddContactVariable.lastnameController,
                  title: "Last Name",
                ),
                SizedBox(
                  height: 10.h,
                ),
                CommonTextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  hintText: "Enter Mobile Number",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.phone),
                        InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              countryListTheme: CountryListThemeData(
                                flagSize: 25.sp,
                                backgroundColor: Colors.white,
                                textStyle: const TextStyle(
                                    fontSize: 16, color: Colors.blueGrey),
                                bottomSheetHeight:
                                    500, // Optional. Country list modal height
                                //Optional. Sets the border radius for the bottomsheet.
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                                //Optional. Styles the search field.
                                inputDecoration: InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'Start typing to search',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(0xFF8C98A8)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                              ),
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                setState(() {
                                  countryCode = country.phoneCode;
                                });
                              },
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("+$countryCode",
                                  style: FontTextStyle.kBlack16W500
                                      .copyWith(fontSize: 18.sp)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  controller: AddContactVariable.numberController,
                  title: "Mobile Number",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
