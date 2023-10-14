import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../componants/custom_btn.dart';
import '../../componants/custom_card.dart';
import '../../componants/custom_drop_down.dart';
import '../../const/style.dart';
import '../../data.dart';
import '../../main.dart';
import '../book_trip_screen/book_trip_screen.dart';
import '../home_screen/home_screen.dart';
import 'controller/offic_location_controller.dart';

class OfficeLocationScreen extends StatelessWidget {
  const OfficeLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OfficeLocationController());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent
          // K.whiteColor
          ,
          title: Text(
            'office_title'.tr,
            style: K.blackText,
          ),
        ),
        body: Obx(
          () => controller.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: K.fixedPadding,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ///555
                        // Obx(()=>
                            SizedBox(
                              height: 40.h,
                              child:CustomDropDown2(hint: 'مكان',
                                listOfItems:controller.agenciesModel!.data!,
                                 onSaved: ( v ) {
                                }, onChanged: (v ) {
                                  controller.selectedValue=v!;
                                  controller.update();


                                   },  type: controller.selectedValue, ),
                            ),
                        K.sizedboxH,
                        Text('office_details'.tr, style: K.largeMainColorTextStyle),
                        K.sizedboxH,

                      controller.  selectedValue != null?
               GetBuilder<OfficeLocationController>(
                 init: OfficeLocationController(),
                   builder: (controller)=>
                      Padding(
                                padding: K.fixedPaddingOnlyTopAndBottom,
                                child: CustomCard(
                          widget:  Obx(()=>Directionality(
                            textDirection: controller.lan.value?TextDirection.ltr:TextDirection.rtl,
                            child: Column(
                            children: [
                              K.sizedboxH,
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: '${'branch'.tr} :   ',
                                      style: K.mainColorTextStyle,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:controller.selectedValue.agencyName,
                                            style: K.primaryTextStyle),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              K.sizedboxH,
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [

                                  RichText(
                                    text: TextSpan(
                                      text: '${'phone_number'.tr} :   ',
                                      style: K.mainColorTextStyle,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: controller.selectedValue
                                                .phone,
                                            style: K.primaryTextStyle),
                                      ],
                                    ),
                                  ),

                                  GestureDetector(
                                    child: Container(
                                      padding: K.thirdFixedPadding,
                                      decoration: BoxDecoration(
                                        color: K.mainColor,
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      child: Icon(Icons.phone,
                                          color: K.whiteColor),
                                    ),onTap: (){
                                    controller.makePhoneCall(controller.selectedValue
                                            .phone??'');
                                  },
                                  ),
                                ],
                              ),
                              K.sizedboxH,
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:MediaQuery.of(context).size.width/1.4.w,
                                    child:    RichText(
                                      text: TextSpan(
                                        text: '${'address'.tr} :   ',

                                        // text: '   العنوان     ',
                                        style: K.mainColorTextStyle,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: controller.selectedValue
                                                  .address,
                                              style: K.primaryTextStyle),
                                        ],
                                      ),
                                    ),)
                                ],
                              ),
                              K.sizedboxH,
                              Button(
                                  color: K.mainColor,
                                  text: 'show_in_map'.tr,
                                  size: MediaQuery.of(context)
                                      .size
                                      .width /
                                      1.w,
                                  height: MediaQuery.of(context)
                                      .size
                                      .width /
                                      11.h,
                                  isFramed: false,
                                  fontSize: 22.sp,
                                  onPressed: () async {
                                    controller.openMap(
                                      lat: double.parse('${controller.selectedValue.lat}'),
                                      long: controller.selectedValue.lng?.toDouble(),
                                    );
                                  }),
                            ],
                          ),
                          ),
                          ),
                          ),

                          ),
                        ):SizedBox()



                     ],
                    ),
                  ),
                ),
        ));
  }
}
