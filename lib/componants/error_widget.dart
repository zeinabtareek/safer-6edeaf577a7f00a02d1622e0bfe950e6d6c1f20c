

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:get/get.dart';

import '../const/app_assets.dart';
import '../const/style.dart';
import 'custom_btn.dart';


Widget errorWidget({required Function()? onPressed,bool ? noButton=false ,text}){
  return SingleChildScrollView(
    child: Column(

      children: [
        Image.asset('assets/images/img_no_data.png',
        // Image.asset(AppAssets.error,
          width: 300.w, // Set the desired width
          // height: 140.h, // Set the desired height
          fit: BoxFit.fill,
        ),
        // K.sizedboxH,

      text!=null?text:  Text("لايوجد بيانات",style: K.primaryTextStyle,),
        noButton==true?const SizedBox(): Button(
            color: K.mainColor,
            text: 'اعاده المحاوله',
            size: MediaQuery.of(Get.context!)
                .size
                .width /
                2.w,
            height: MediaQuery.of(Get.context!)
                .size
                .width /
                11.h,
            isFramed: false,
            fontSize: 22.sp,
            // widget: Image.asset(AppAssets.reload,width: 50,color: Colors.white,height: 25.h,) ,
            onPressed:   onPressed

        ),
      ],
    ),
  );
}