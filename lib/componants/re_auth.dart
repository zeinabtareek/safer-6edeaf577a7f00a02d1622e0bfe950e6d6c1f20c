

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../const/style.dart';
import '../screens/account_screen/controller/account_controller.dart';
import '../screens/profile/controller/profile_controller.dart';
import 'custom_btn.dart';

class DelayDialog extends StatelessWidget {
  DelayDialog({super.key});

  final controller = Get.put(ProfileController());
  final authController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        width: w * 0.8,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                IconButton(
                    onPressed: () {
                      // authController.nameTextEditingController.clear();
                      authController.phoneController.clear();
                      Get.back();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),

            // Text('التحقق من رقم OTP'.tr,style:TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold) ,),

            K.sizedboxH,

            Button(
              textColor: K.primaryColor,
              text: "submit".tr,
              onPressed: () async {
                Get.back();
                // showLoaderDialog(context);
                // await authController
                //     .sendVerificationCode(
                //     phone: FirebaseAuth.instance.currentUser!.phoneNumber)
                //     .then((value) {
                //   authController.phoneController.clear();
                // });
                await controller.deleteFun().then((value) {
              authController.phoneController.clear();
                });



              },
              isFramed: true,
              height: MediaQuery.of(context).size.height / 15.h,
              fontSize: 16,
              size: 250, color: K.whiteColor,
            ),


          ],
        ),
      ),
    );
  }
}