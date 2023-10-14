

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../const/app_assets.dart';
import '../const/app_conss.dart';
import '../const/style.dart';
class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key, this.onChange});

  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Theme.of(context).primaryColor,
      onChanged: onChange,
      //     (String query) {
      //   // searchProvider.searchLanguage(query, context);
      // },
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: 14.sp),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(style: BorderStyle.none, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(style: BorderStyle.none, width: 0),
        ),
        isDense: true,
        hintText: AppConstants.findLanguage.tr,
        fillColor: Theme.of(context).cardColor,
        hintStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.grey,fontSize: 16.sp),
        filled: true,
        suffixIcon: Padding(
          padding:   EdgeInsets.only(left :50.sp),
          child: Image.asset(AppAssets.search,
              fit: BoxFit.contain,
              width: 15,
              height: 15,
              color: K.mainColor),
        ),
      ),
    );
  }
}
