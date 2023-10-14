

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../componants/custom_btn.dart';
import '../../componants/custom_search_text_field.dart';
import '../../componants/responsive_widget.dart';
import '../../const/app_assets.dart';
import '../../const/app_conss.dart';
import '../../const/style.dart';
import '../../controller/language_controller.dart';
import '../home/controller/home_controller.dart';
import '../home_screen/controller/home_screen_controller.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocalizationController());

    return Responsive(
      mobile: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0.r)),


        child:  Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child:   Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:   EdgeInsets.all( 10.sp),
                child: Text(AppConstants.chooseLanguage.tr,
                    style:K.blackText),
              ),
              Padding(
                padding:   EdgeInsets.symmetric(
                    horizontal:10.w),
                child: CustomSearchTextField(
                  onChange: (value) {
                    controller.searchLanguage(value);
                  },
                ),
              ),
              Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.languages.length,
                  itemBuilder: (_, index) => Obx(() => Padding(
                    padding:   EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical:10.h,
                    ),
                    child: ListTile(
                      shape: controller.selectedIndex == index
                          ? RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: K.mainColor.withOpacity(.1),))
                          : null,
                      onTap: () {
                        controller.setSelectIndex(index);
                      },
                      leading: Image.asset(
                        controller.languages[index].imageUrl!,
                        color: K.primaryColor,
                        width: 30.w,
                        height: 50.h,
                        fit: BoxFit.contain,),
                      title:
                      Text(controller.languages[index].languageName!.tr,style: K.smallBlackText,),
                      trailing: controller.selectedIndex == index
                          ?  Image.asset(AppAssets.done,
                          color: K.primaryColor,
                          width:20.w):SizedBox(),
                    ),
                  )))),
              const Spacer(),
              // CustomButton(
              //   onPressed: () {
              //     Get.delete<HomeController>();
              //     Get.delete<HomeScreenController>();
              //     controller.setLanguage(Locale(
              //       AppConstants
              //           .languages[controller.selectedIndex].languageCode!,
              //       AppConstants.languages[controller.selectedIndex].countryCode,
              //     ));
              //     Navigator.pop(context);
              //   },
              //   buttonText: AppConstants.saveLanguage.tr,
              //   width: AppDimensions.space(Dimensions.FONT_SIZE_EXTRA_LARGE),
              // ),
              Button(
                  color: K.mainColor,
                  text: AppConstants.saveLanguage.tr,
                  size: MediaQuery.of(context).size.width / 1.3.w,
                  height: MediaQuery.of(context).size.width / 11.h,
                  isFramed: false,
                  fontSize: 22.sp,
                  onPressed: () async {
                    Get.delete<HomeController>();
                    Get.delete<HomeScreenController>();
                    controller.setLanguage(Locale(
                      AppConstants .languages[controller.selectedIndex].languageCode!,
                      AppConstants.languages[controller.selectedIndex].countryCode,
                    ));
                    Navigator.pop(context);
                  }),

           K.sizedboxH
            ],
          ),
        ),
      ),
    );
  }
}
