import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color.dart';

class FontTextStyle {
  static TextStyle kBlack20W500 = TextStyle(
    color: PickColor.kBlack,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle kBlack25Bold = TextStyle(
    color: PickColor.kBlack,
    fontSize: 25.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle kBlackWithOpacity16W500 = TextStyle(
    color: PickColor.kBlack.withOpacity(0.5),
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle kBlack16W500 = TextStyle(
    color: PickColor.kBlack,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle k8B8B8B14W500 = TextStyle(
    color: PickColor.k8B8B8B,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle kWhite30W500 = TextStyle(
    color: PickColor.kWhite,
    fontSize: 30.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle kWhite22W400 = TextStyle(
    color: PickColor.kWhite,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
  );
}
