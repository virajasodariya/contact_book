import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raj_contact_book/Constants/color.dart';
import 'package:raj_contact_book/Constants/image_path.dart';
import 'package:raj_contact_book/Constants/text_style.dart';
import 'package:raj_contact_book/View/Auth/login.dart';
import 'package:raj_contact_book/View/Home/contact_details.dart';
import 'package:raj_contact_book/View/Home/new_contact.dart';
import 'package:raj_contact_book/View/Home/search_screen.dart';

class AllContactScreen extends StatefulWidget {
  const AllContactScreen({
    super.key,
    this.userId,
  });
  final String? userId;

  @override
  State<AllContactScreen> createState() => _AllContactScreenState();
}

class _AllContactScreenState extends State<AllContactScreen> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PickColor.kBlack,
      appBar: AppBar(
        backgroundColor: PickColor.kBlack,
        title: const Text(
          "Contacts",
        ),
        titleTextStyle: FontTextStyle.kWhite30W500,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const SearchScreen());
            },
            icon: Icon(
              Icons.search,
              color: PickColor.k323232,
              size: 25.sp,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: PickColor.k323232,
              size: 25.sp,
            ),
          ),
          IconButton(
            onPressed: () {
              box.remove('userId');
              Get.offAll(
                () => const LogInScreen(),
                transition: Transition
                    .fadeIn, // You can choose different transition animations
                duration: const Duration(seconds: 4),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PickColor.kSkyBlue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewContactScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: PickColor.kWhite,
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('User')
              .doc('${box.read('userId')}')
              .collection('Number')
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImagePath.emptyBox,
                      color: PickColor.kWhite,
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      "You have no contacts yet",
                      style: FontTextStyle.kWhite30W500,
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot contact = snapshot.data!.docs[index];

                return ListTile(
                  onTap: () {
                    Get.to(() => ContactDetail(
                          contactReference: contact.reference,
                        ));
                  },
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: PickColor.k7B7B7B,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(7.sp),
                      child: Icon(
                        Icons.person,
                        size: 31.sp,
                        color: PickColor.kWhite,
                      ),
                    ),
                  ),
                  title: Text("${contact["firstName"]} ${contact["lastName"]}"),
                  titleTextStyle: FontTextStyle.kWhite22W400,
                  subtitle: Text("+ ${contact["phoneNumber"]}",
                      style: TextStyle(color: Colors.amber.shade100)),
                  subtitleTextStyle: FontTextStyle.kWhite22W400,
                  trailing: IconButton(
                    onPressed: () {
                      log('IconButton');
                    },
                    icon: Icon(
                      Icons.call,
                      color: PickColor.kGreen,
                      size: 30.sp,
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
