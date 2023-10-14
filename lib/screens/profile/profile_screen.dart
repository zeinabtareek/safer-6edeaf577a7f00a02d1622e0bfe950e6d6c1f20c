import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled3/componants/custom_btn.dart';
import 'package:untitled3/componants/custom_card.dart';
import 'package:untitled3/componants/custom_text_field.dart';
import 'package:untitled3/const/app_assets.dart';
import 'package:untitled3/const/app_conss.dart';
import 'package:untitled3/const/style.dart';
import 'package:untitled3/helper/cache_helper.dart';
import 'package:untitled3/screens/profile/controller/profile_controller.dart';

import '../../componants/custom_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return CustomBody(
      appBarText: 'حسابي',
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCard(
              widget: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    K.sizedboxH,
                    Image.asset(
                      AppAssets.profileAssets,
                      height: 100.h,
                      color: K.primaryColor,
                    ),
                    K.sizedboxH,
                    CustomTextField(
                      label: controller.userModel?.name??'الأسم',
                      controller: controller.nameController,
                      icon: null,
                      hint: "",
                      enabled: false,
                      type: TextInputType.text,
                      onChange: (v) {
                        // _loginController.email=v;
                      },
                    ),
                    CustomTextField(
                      controller: controller.idController,
                      label: 'الرقم القومي',
                      hint: "",
                      enabled: false,
                      icon: null,
                      type: TextInputType.number,
                      onChange: (v) {
                        // _loginController.email=v;
                      },
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.emailController,
                      label: 'البريد الالكتروني',
                      hint: "",
                      icon: null,
                      type: TextInputType.emailAddress,
                      onChange: (v) {
                        // _loginController.email=v;
                      },
                    ),
                    K.sizedboxH,
                    Obx(
                      () => Button(
                          color: K.mainColor,
                          text: controller.isLoading.value
                              ? 'loading'
                              : ' تسجيل الخروج'.tr,
                          size: MediaQuery.of(context).size.width / 1.3.w,
                          height: MediaQuery.of(context).size.width / 11.h,
                          isFramed: false,
                          fontSize: 22.sp,
                          onPressed: () async {
                            controller.logOut(context);
                          }),
                    ),
                  ]),
            ),
            K.sizedboxH,
            Image.asset(AppAssets.contact, height: 100.h),
            K.sizedboxH,
            //رقم الهاتف
           Obx(()=> Button(
                color: K.whiteColor,
                text: controller.infoModel.data?.phone??'',
                size: MediaQuery.of(context).size.width / 1.3.w,
                height: MediaQuery.of(context).size.width / 11.h,
                widget: controller.loading.value?CircularProgressIndicator():SizedBox(),
                isFramed: true,
                fontSize: 22.sp,
                onPressed: () async {
                  controller.makePhoneCall(controller.infoModel.data?.phone??'');


                  // controller.showOtpDialog(context);

                  // Get.to(const BookTripScreen());
                })),


            Button(
              isFramed: true,
              text: 'حذف الحساب ',
              fontSize: 22.sp,
              textColor: K.whiteColor,
              // size: 50,

              size: MediaQuery.of(context).size.width / 1.3.w,
              height: MediaQuery.of(context).size.width / 11.h,
              onPressed: () async {
                if (  FirebaseAuth.instance.currentUser == null) {

                  Get.defaultDialog(
                      title: 'خطأ'.tr,
                      content: Text(  'لا حساب'.tr));
                } else {
                  Get.defaultDialog(
                      title:
                      'هل تريد حذف حسابك'
                          .tr,
                      content: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: [
                          K.sizedboxH,
                          TextButton(
                              child:
                              Text(
                                'نعم'
                                    .tr,
                                style: TextStyle(
                                    color:
                                    K.primaryColor,
                                    fontSize: 20.sp),
                              ),
                              onPressed:
                                  () async {
                                print(FirebaseAuth.instance.currentUser!.phoneNumber);
                                await controller.deleteDocumentsWithUserId().then((value) async {
                                await controller.deleteFun();
                                  FirebaseAuth.instance.currentUser!.delete();

                                });


                                Get.back();
                                // controller.showDelayReasonDialog( );
                                // controller.delete();


                              }

                            ///$$$$$$$$$$$$$$$



                          ),
                          TextButton(
                              onPressed:
                                  () {
                                Get.back();
                              },
                              child:
                              Text(
                                'لا'.tr,
                                style: TextStyle(
                                    color:
                                    K.primaryColor,
                                    fontSize: 20.sp),
                              )),
                          SizedBox(
                            height:
                            50.h,
                          ),
                        ],
                      ));
                }
                ;
              }, color: K.mainColor,),
          ],
        ),
      ),
      isLoadoing: controller.isLoading,
    );
  }
}
