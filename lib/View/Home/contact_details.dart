import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raj_contact_book/Constants/color.dart';
import 'package:raj_contact_book/View/Home/all_contact.dart';
import 'package:raj_contact_book/View/Home/edit_contect.dart';
import 'package:raj_contact_book/View/Widget/snack_bar.dart';

class ContactDetail extends StatefulWidget {
  const ContactDetail({
    super.key,
    required this.contactReference,
  });
  final DocumentReference contactReference;

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => const AllContactScreen());
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Contect Details", textScaleFactor: 1.02),
        backgroundColor: PickColor.kBlack,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await widget.contactReference.delete();
                Get.offAll(() => const AllContactScreen());
              } catch (error) {
                log('Error deleting document: $error');
                showSnackBar('$error');
              }
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => EditContect(
                    documentId:
                        widget.contactReference.id, // Pass the document ID
                  ));
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      backgroundColor: PickColor.kBlack,
      body: FutureBuilder<DocumentSnapshot>(
        future: widget.contactReference.get(),
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
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 20.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 180.h,
                      width: 180.w,
                      decoration: const BoxDecoration(
                        color: PickColor.kWhite,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://img.freepik.com/free-photo/stylish-handsome-indian-man-tshirt-pastel-wall_496169-1571.jpg?w=1060&t=st=1691819625~exp=1691820225~hmac=03811a07e808a95412fbc7960177e1d3af09894186258bec3a80c2f95d57ffe8",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.person, color: PickColor.kWhite),
                      SizedBox(
                        width: 18.sp,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${contactData["firstName"]} ${contactData["lastName"]}",
                                style: TextStyle(
                                  color: PickColor.kWhite,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Text(
                            "+ ${contactData["phoneNumber"]}",
                            style: TextStyle(
                              color: PickColor.kWhite,
                              fontSize: 21.sp,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.call_rounded,
                            color: Colors.green,
                          ))
                    ],
                  ),
                  const Divider(
                    color: PickColor.k8B8B8B,
                  ),
                  Text(
                    "Call Log",
                    style: TextStyle(
                      color: PickColor.kWhite,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "+ ${contactData["phoneNumber"]}",
                                  style: TextStyle(
                                    color: PickColor.k7B7B7B,
                                    fontSize: 25.sp,
                                  ),
                                ),
                                const Spacer(),
                                Flexible(
                                  child: Text(
                                    "${DateTime.now()}",
                                    style: TextStyle(
                                      color: PickColor.k7B7B7B,
                                      fontSize: 22.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }

          return const Text('Contact not found');
        },
      ),
    );
  }
}
