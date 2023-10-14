import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled3/const/app_conss.dart';
import 'package:untitled3/helper/cache_helper.dart';

import '../../componants/custom_body.dart';
import '../../componants/custom_btn.dart';
import '../../componants/custom_card.dart';
import '../../componants/custom_text_field.dart';
import '../../const/app_assets.dart';
import '../../const/style.dart';
import '../create_account_screen/create_account_screen.dart';
import '../home_screen/home_screen.dart';
import '../profile/controller/profile_controller.dart';
import 'componants/custom_phone_text_field.dart';
import 'controller/account_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());
    final profileController = Get.put(ProfileController());
    return Listener(
        onPointerUp: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        // ,title: Text('حسابي',style: K.blackText,),),
        child: CustomBody(
          appBarText: 'حسابي',
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCard(
                  widget: Column(
                    children: [
                      K.sizedboxH,
                      Image.asset(
                        AppAssets.profileAssets,
                        height: 100.h,
                        color: K.primaryColor,
                      ),
                      K.sizedboxH,
                      CustomPhoneTextField(
                          hintText: '',
                          inputType: TextInputType.number,
                          fillColor: Colors.transparent,
                          countryDialCode: "+962",
                          prefixHeight: 70,
                          borderRadius: 10,
                          controller: controller.phoneController,
                          // focusNode: authController.signInPhoneNode,
                          // nextFocus: authController.passwordNode,
                          inputAction: TextInputAction.next,
                          onCountryChanged: (countryCode) =>
                              controller.onCountryChanged(
                                  countryCode, controller.phoneController)),
                      K.sizedboxH,
                      Obx(
                        () => Button(
                            color: K.mainColor,
                            text: controller.isLoading.value
                                ? ''
                                : ' تسجيل الدخول'.tr,
                            size: MediaQuery.of(context).size.width / 1.3.w,
                            height: MediaQuery.of(context).size.width / 11.h,
                            isFramed: false,
                            widget: controller.isLoading.value?Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(color: K.mainColor,),
                            ):SizedBox(),
                            fontSize: 22.sp,
                            onPressed: () async {
                              // controller.addToDb();
                              controller
                                  .validation(controller.phoneController.text);
                              // controller.sendVerificationCode(phone:controller.phoneController.text );
                              // controller.sendVerificationCodeToReAuthenticate(phone:controller.phoneController.text );

                              // Get.to(()=>CreateAccountScreen());/
                              // Get.to(const BookTripScreen());
                            }),
                      ),
                    ],
                  ),
                ),
                K.sizedboxH,
                Image.asset(AppAssets.contact, height: 100.h),
                K.sizedboxH,
                Obx(()=> Button(
                  color: K.whiteColor,
                    text: profileController.infoModel.data?.phone??'',
                    size: MediaQuery.of(context).size.width / 1.3.w,
                    height: MediaQuery.of(context).size.width / 11.h,
                    widget: profileController.loading.value?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(color: K.mainColor,),
                    ):SizedBox(),
                    isFramed: true,
                    fontSize: 22.sp,
                    onPressed: () async {
                      profileController.makePhoneCall(profileController.infoModel.data?.phone??'');


                      // controller.showOtpDialog(context);

                      // Get.to(const BookTripScreen());
                    })),



              ],
            ),
          ),
          isLoadoing: controller.isLoading,
        ));
  }
}
