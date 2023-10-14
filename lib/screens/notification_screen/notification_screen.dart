import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled3/const/app_assets.dart';
import 'package:untitled3/screens/notification_screen/controller/notification_controller.dart';

import '../../componants/custom_btn.dart';
import '../../const/style.dart';

class NotificaionScreen extends StatelessWidget {
  const NotificaionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent
          // K.whiteColor
          ,
          title: Text(
            'الاشعارات',
            style: K.blackText,
          ),
        ),
        body: Obx(() => controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              ):controller.messages.isEmpty?Center(child:
        SingleChildScrollView(
          child: Column(
                  children: [
                    Image.asset('assets/images/img_no_message.png',width: 300.w),//,width: 300.w
                    Text('ليس لديك  رسائل',style: TextStyle(color: K.primaryColor,fontSize: 30.sp),),
                    Button(
                        color: K.mainColor,
                        text: 'اعاده المحاوله'.tr,
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
                        onPressed:   (){
                          controller.getMessage();
                        }

                    ),
                  ],
                ),
        ))
            : Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                    ListView.builder(
                              itemCount: controller.messages.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // messages[index].messageType == "receiver"
                                      //     ?
                                      Container(
                                        padding: K.fixedPadding,
                                        decoration: K.boxDecorationLightBg,
                                        // clipBehavior: Clip.antiAlias,
                                        child: Image.asset(
                                          AppAssets.splashLogo,
                                          fit: BoxFit.contain,
                                          width: 20,
                                          height: 25,
                                        ),
                                      ),
                                      // : SizedBox(),
                                      K.sizedboxW,
                                      Expanded(
                                        child: Container(
                                          decoration: K.boxDecorationLightBg,
                                          padding: EdgeInsets.all(16),
                                          child: Text(
                                            controller.messages[index].message ??
                                                "",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      K.sizedboxW,
                                      K.sizedboxW,
                                    ],
                                  ),
                                );
                              },
                            ),

                    ],
                  ),
                ),
              )));
  }
}
