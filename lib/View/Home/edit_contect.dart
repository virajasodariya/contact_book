import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raj_contact_book/Constants/color.dart';
import 'package:raj_contact_book/Controller/variable.dart';
import 'package:raj_contact_book/View/Home/all_contact.dart';
import 'package:raj_contact_book/View/Widget/snack_bar.dart';
import 'package:raj_contact_book/View/Widget/text_form_field.dart';

class EditContect extends StatefulWidget {
  const EditContect({
    super.key,
    required this.documentId,
  });
  final String documentId;

  @override
  State<EditContect> createState() => _EditContectState();
}

class _EditContectState extends State<EditContect> {
  String countryCode = "91";

  final box = GetStorage();
  final formKey = GlobalKey<FormState>();

  DocumentReference? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseFirestore.instance
        .collection('User')
        .doc('${box.read('userId')}')
        .collection('Number')
        .doc(widget.documentId); // Use the provided documentId here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PickColor.kBlack,
      appBar: AppBar(
        backgroundColor: PickColor.kBlack,
        title: const Text(
          "Edit Contect",
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                try {
                  setState(() {
                    user!.update({
                      "firstName": AddContactVariable.firstnameController.text,
                      "lastName": AddContactVariable.lastnameController.text,
                      "phoneNumber":
                          "$countryCode ${AddContactVariable.numberController.text}",
                    });
                  });
                } catch (error) {
                  log('ERROR---------->>>>>>>>>>$error');
                  showSnackBar('$error');
                } finally {
                  Get.offAll(() => const AllContactScreen());
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
      body: FutureBuilder<DocumentSnapshot>(
        future: user!.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.hasData) {
            Map<String, dynamic> contactData =
                snapshot.data!.data() as Map<String, dynamic>;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CommonTextFormField(
                        keyboardType: TextInputType.name,
                        hintText: "${contactData["firstName"]} ",
                        controller: AddContactVariable.firstnameController,
                        title: "First Name"),
                    CommonTextFormField(
                        keyboardType: TextInputType.name,
                        hintText: "${contactData["lastName"]}",
                        controller: AddContactVariable.lastnameController,
                        title: "Last Name"),
                    CommonTextFormField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        hintText: "+ ${contactData["phoneNumber"]}",
                        controller: AddContactVariable.numberController,
                        title: "Mobile Number"),
                  ],
                ),
              ),
            );
          }

          return const Text('Contact not found');
        },
      ),
    );
  }
}
