
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/style.dart';


void showCustomSnackBar({String? message, bool isError = true, bool isInfo = true}) {
  if (message != null && message.isNotEmpty) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin:   EdgeInsets.all( 5),
      duration: const Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : isInfo?Colors.black.withOpacity(.7):Colors.green,
      behavior: SnackBarBehavior.floating,

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular( 10)),
      content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(message, style: K.whiteTextStyle)),
    ));
  }
}