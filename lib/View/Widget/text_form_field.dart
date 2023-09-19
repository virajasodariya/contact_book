import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raj_contact_book/Constants/color.dart';

class CommonTextFormField extends StatefulWidget {
  const CommonTextFormField({
    Key? key,
    required this.keyboardType,
    required this.hintText,
    required this.controller,
    // required this.validator,
    this.suffixIcon,
    required this.title,
    this.prefixIcon,
    this.maxLength,
  }) : super(key: key);

  final TextInputType keyboardType;
  final String hintText;
  // ignore: prefer_typing_uninitialized_variables
  final prefixIcon;
  final TextEditingController controller;
  // final FormFieldValidator validator;
  final Widget? suffixIcon;
  final String title;
  final int? maxLength;

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            color: PickColor.kWhite,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            keyboardType: widget.keyboardType,
            // validator: widget.validator,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a value';
              }
              return null;
            },
            maxLength: widget.maxLength,

            controller: widget.controller,
            cursorColor: PickColor.kBlack,
            decoration: InputDecoration(
              // constraints: BoxConstraints(maxWidth: 388.w, minHeight: 56.h),
              hintText: widget.hintText,
              hintStyle: const TextStyle(),
              filled: true,
              prefixIcon: widget.prefixIcon,
              fillColor: const Color(0xffF7F7F7),
              suffixIcon: widget.suffixIcon,

              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide: const BorderSide(color: Color(0xffE0E0E0))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide: const BorderSide(color: Color(0xffE0E0E0))),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide: const BorderSide(color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide: const BorderSide(color: Colors.red)),
            ),
          ),
        ),
      ],
    );
  }
}
