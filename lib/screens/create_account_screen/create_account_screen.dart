import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled3/componants/custom_snackbar.dart';
import 'package:untitled3/const/app_assets.dart';
import 'package:untitled3/const/app_conss.dart';
import 'package:untitled3/helper/cache_helper.dart';
import 'package:untitled3/screens/account_screen/controller/account_controller.dart';
import 'package:untitled3/screens/home/home.dart';

import '../../componants/custom_body.dart';
import '../../componants/custom_btn.dart';
import '../../componants/custom_text_field.dart';
import '../../const/style.dart';
import '../home_screen/home_screen.dart';
import 'controller/create_account_controller.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(AccountController());
    final controller = Get.put(CreateAccountController());
    List optionsList = [
      optionOne(),
      optionTwo(context),
    ];
    return Scaffold(
      body: CustomBody(body:

      // Scaffold(
        //   appBar: AppBar(
        //     backgroundColor: Colors.transparent,
        //     title: Text(
        //       'انشاء حساب',
        //       style: K.blackText,
        //     ),
        //     leading: IconButton(
        //       icon: Icon(
        //         Icons.arrow_back_rounded,
        //         color: K.blackColor,
        //       ),
        //       color: K.blackColor,
        //       onPressed: () {
        //         Get.back();
        //       },
        //     ),
        //   ),
        //   body:

          Center(
            child: Padding(
              padding: K.fixedPadding,
              child: CarouselSlider(
                carouselController: controller.carouselController,
                options: CarouselOptions(
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    // aspectRatio: 2.0,
                    pageSnapping: false,
                    enlargeCenterPage: false,
                    pauseAutoPlayOnManualNavigate: false,
                    height: MediaQuery.of(context).size.height.h / 1,
                    viewportFraction: 1,
                    onPageChanged: (index1, reason) {
                      controller.currentImageIndex.value = index1;
                    }),
                items: optionsList
                    .map(
                      (item) => Center(
                        child: Container(
                            clipBehavior: Clip.antiAlias,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height.h,
                            margin: null,
                            padding: null,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.transparent, width: 0),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: item),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
      isLoadoing:controller.loading, appBarText:    'انشاء حساب',),

        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            K.sizedboxW,
            Button(
                color: K.mainColor,
                text: ' المتابعه'.tr,
                size: MediaQuery.of(context).size.width / 3.w,
                height: MediaQuery.of(context).size.width / 11.h,
                isFramed: false,
                fontSize: 22.sp,
                onPressed: () async {


                  // Get.to(const CreateAccountScreen());
                  // controller.carouselController.nextPage();
                  // controller.addUserData()
                  if (controller.currentImageIndex.value == 0) {
                    if(controller.key.currentState!.validate()){
                     controller.carouselController.nextPage();
                   }
                  }
                    else {
                      if(controller.loading.value==true){
                        showCustomSnackBar(message: 'يرجى الانتظار ثانية',isError: true);
                      }

                      if(controller.image2.value==''||controller.image2.value==null||controller.image.value==''||controller.image.value==null){
                        showCustomSnackBar(message: 'يرجى إضافة صورة الهوية في الخلف والأمام',isError: false,isInfo: true);

                      }
                      else  if(controller.loading.value==false){
                    controller.updateUser(
                        id: CacheHelper.getData(key: AppConstants.idUser));
                    Get.offAll(() => const Home());
                    // Get.to(() => const Home());
                  }
                  }
                }

                  ),
            K.sizedboxW,
          ],
        ));
  }
}

optionOne() {

  final controller = Get.put(CreateAccountController());

  return SingleChildScrollView(
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        key: controller.key,
        child: Column(
          children: [
            K.sizedboxH,
            Image.asset(
              AppAssets.profileAssets,
              height: 120.h,
              fit: BoxFit.cover,
              color: K.primaryColor,
            ), //
            K.sizedboxH,
            CustomTextField(
              label: 'الأسم',
              heightt: 50.h,
              controller: controller.nameController,
              icon: null,
              hint: "",
              type: TextInputType.text,
              onChange: (v) {
                // _loginController.email=v;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'يرجى إدخال الأسم';
                }
                return null;
              },
            ),
            CustomTextField(
              controller: controller.idController,
              label: 'الرقم القومي',
              hint: "",
              icon: null,
              type: TextInputType.number,
              onChange: (v) {
                // _loginController.email=v;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'يرجى إدخال الرقم القومي';
                }
                return null;
              },
            ),
            CustomTextField(
              controller: controller.emailController,
              label: 'البريد الالكتروني',
              hint: "",
              icon: null,
              type: TextInputType.emailAddress,
              onChange: (v) {
                // _loginController.email=v;
              },
              validator: (value) {
                if (value!.isEmpty || !value.toString().contains('@') || !value.toString().contains('.')) {
                  return 'يرجى إدخال البريد الإلكتروني';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    ),
  );
}

optionTwo(context) {
  final controller = Get.put(CreateAccountController());
  return SingleChildScrollView(
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'اهلا و سهلا بك سيد ${controller.nameController.text}',
            style: K.largeMainColorTextStyle,
          ),
          Text(
            'باقي اخر خطوة لاكتمال عملبة التسجيل',
            style: TextStyle(color: K.mainColor, fontSize: 14.sp),
          ),
          K.sizedboxH,
          GestureDetector(
              onTap: () async {
                controller.image.value = (await controller.selectImage()) ?? "";
                controller.nationalIdFront.value = await controller.updateImage(
                        image: controller.image.value) ??
                    "";
              },
              child: Container(
                decoration: K.boxDecorationLightBgWithBorder,
                padding: K.fixedPadding,
                height: 200.h,
                width: MediaQuery.of(context).size.width / 1.5.w,
                child: Obx(
                  // () => controller.photo.value!.path == ""
                  () => controller.image.value == ""
                      ? Center(
                          child: Text(
                          'ادخل صورة الهوية من الامام',
                          style: K.largeMainColorTextStyle,
                        ))
                      // : Image.file(File(controller.photo.value!.path),
                      : Image.file(File(controller.image.value),
                          fit: BoxFit.cover),
                ),
              )),
          K.sizedboxH,
          GestureDetector(
              onTap: () async {
                controller.image2.value =
                    (await controller.selectImage()) ?? "";
                controller.nationalIdBack.value = await controller.updateImage(
                        image: controller.image2.value) ??
                    "";
              },
              child: Container(
                decoration: K.boxDecorationLightBgWithBorder,
                padding: K.fixedPadding,
                height: 200.h,
                width: MediaQuery.of(context).size.width / 1.5.w,
                child: Obx(
                  () => controller.image2.value == ""
                      ? Center(
                          child: Text(
                          'ادخل صورة الهوية من الخلف',
                          style: K.largeMainColorTextStyle,
                        ))
                      : Image.file(File(controller.image2.value),
                          fit: BoxFit.cover),
                ),
              )),
        ],
      ),

    ),
  );
}
