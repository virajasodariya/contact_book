import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raj_contact_book/Constants/color.dart';
import 'package:raj_contact_book/Constants/text_style.dart';
import 'package:raj_contact_book/View/Home/contact_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    this.userId,
  });
  final String? userId;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final box = GetStorage();
  late List<DocumentSnapshot> allContacts;
  late List<DocumentSnapshot> filteredContacts;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    allContacts = [];
    filteredContacts = [];
    fetchContacts();
  }

  void fetchContacts() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('User')
        .doc('${box.read('userId')}')
        .collection('Number')
        .get();

    setState(() {
      allContacts = snapshot.docs;
      filteredContacts = allContacts;
    });
  }

  // Filter contacts based on search text
  void filterContacts(String searchText) {
    List<DocumentSnapshot> filtered = allContacts.where((contact) {
      String fullName =
          "${contact["firstName"]} ${contact["lastName"]}".toLowerCase();
      return fullName.contains(searchText.toLowerCase());
    }).toList();

    setState(() {
      filteredContacts = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PickColor.kBlack,
      appBar: AppBar(
        backgroundColor: PickColor.kBlack,
        title: const Text(
          "Search Contacts",
        ),
        titleTextStyle: FontTextStyle.kWhite30W500,
        actions: [
          IconButton(
            onPressed: () {
              filterContacts(searchController.text);
            },
            icon: Icon(
              Icons.search,
              color: PickColor.k323232,
              size: 25.sp,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              cursorColor: PickColor.kWhite,
              controller: searchController,
              onChanged: (value) {
                filterContacts(value);
              },
              style: FontTextStyle.kWhite22W400,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.search_rounded,
                  color: PickColor.kWhite,
                ),
                hintText: "Search contacts",
                hintStyle: FontTextStyle.kWhite22W400,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                DocumentSnapshot contact = filteredContacts[index];
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
            ),
          ),
        ],
      ),
    );
  }
}
