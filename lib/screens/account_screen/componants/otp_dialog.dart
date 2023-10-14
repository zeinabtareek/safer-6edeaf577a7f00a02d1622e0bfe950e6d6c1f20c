import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../componants/custom_btn.dart';
import '../../../componants/custom_text_field.dart';
import '../../../const/style.dart';
import '../../home_screen/home_screen.dart';
import '../controller/account_controller.dart';

class OtpDialog extends StatelessWidget {
    OtpDialog({Key? key ,required this.validation}) : super(key: key);
final controller=Get.put(AccountController());
String validation;
  Widget build(BuildContext context) {



    return  Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0.r)),


        child:  Container(
          decoration: K.boxDecorationLightBg20,
          // height: 200.h,
          child:   Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               K.sizedboxH,
               Text('verification_code_has_been_sent'.tr,style: K.boldBlackSmallText,),
               K.sizedboxH,
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: K.fixedPadding,
                  child: CustomTextField(
                    controller: controller.pinController,
                    label: 'write_code'.tr,
                    hint: "",
                    icon: null,
                    type: TextInputType.number,
                    onChange: (v) {
                      // _loginController.email=v;
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  K.sizedboxW,
                  Expanded(
                    child: Button(
                        color: K.whiteColor,
                        text:'resend_code'.tr,
                        size: MediaQuery.of(context).size.width / 2.w,
                        height: MediaQuery.of(context).size.width / 11.h,
                        isFramed: true,
                        fontSize: 18.sp,
                        onPressed: () async {

                         }),
                  ),
                  K.sizedboxW,


                  Expanded(
                    child:Obx(()=> Button(
                        color: K.mainColor,
                        text:controller.isLoading.value?' ... ${'loading'.tr}':'send'.tr,
                        size: MediaQuery.of(context).size.width / 2.w,
                        height: MediaQuery.of(context).size.width / 11.h,
                        isFramed: false,
                        fontSize: 18.sp,
                        onPressed: () async {
                          controller.verifyCode(validation );

                         }),
                  ),   ), K.sizedboxW,
                ],
              )

            ],
          ),
       ),
    );
  }

}
