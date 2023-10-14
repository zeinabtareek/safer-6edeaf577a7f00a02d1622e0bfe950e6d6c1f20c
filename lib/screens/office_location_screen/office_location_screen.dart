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
            'مواقع المكاتب',
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
                        Text('التفاصيل', style: K.largeMainColorTextStyle),
                        K.sizedboxH,

                      controller.  selectedValue != null?
               GetBuilder<OfficeLocationController>(
                 init: OfficeLocationController(),
                   builder: (controller)=>       Padding(
                                padding: K.fixedPaddingOnlyTopAndBottom,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: CustomCard(
                          widget: Column(
                            children: [
                              K.sizedboxH,
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'الفرع :   ',
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
                                      text: 'رقم الهاتف :   ',
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
                                        text: 'العنوان :   ',

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
                                  text: ' اظهار علي الخريطه'.tr,
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
                        ):SizedBox()





                        // ListView.builder(
                        //     itemCount: controller.agenciesModel?.data?.length,
                        //     shrinkWrap: true,
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     itemBuilder: (context, index) {
                        //       return Padding(
                        //         padding: K.fixedPaddingOnlyTopAndBottom,
                        //         child: Directionality(
                        //           textDirection: TextDirection.rtl,
                        //           child: CustomCard(
                        //             widget: Column(
                        //               children: [
                        //                 K.sizedboxH,
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.start,
                        //                   children: [
                        //                     RichText(
                        //                       text: TextSpan(
                        //                         text: 'الفرع :   ',
                        //                         style: K.mainColorTextStyle,
                        //                         children: <TextSpan>[
                        //                           TextSpan(
                        //                               text: controller
                        //                                   .agenciesModel
                        //                                   ?.data?[index]
                        //                                   .agencyName,
                        //                               style: K.primaryTextStyle),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 K.sizedboxH,
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //
                        //                     RichText(
                        //                       text: TextSpan(
                        //                         text: 'رقم الهاتف :   ',
                        //                         style: K.mainColorTextStyle,
                        //                         children: <TextSpan>[
                        //                           TextSpan(
                        //                               text: controller
                        //                                   .agenciesModel
                        //                                   ?.data?[index]
                        //                                   .phone,
                        //                               style: K.primaryTextStyle),
                        //                         ],
                        //                       ),
                        //                     ),
                        //
                        //                     GestureDetector(
                        //                       child: Container(
                        //                         padding: K.thirdFixedPadding,
                        //                         decoration: BoxDecoration(
                        //                           color: K.mainColor,
                        //                           borderRadius:
                        //                           BorderRadius.circular(10),
                        //                         ),
                        //                         child: Icon(Icons.phone,
                        //                             color: K.whiteColor),
                        //                       ),onTap: (){
                        //                       controller.makePhoneCall(
                        //                           controller
                        //                               .agenciesModel
                        //                               ?.data?[index]
                        //                               .phone??'');
                        //                     },
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 K.sizedboxH,
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.start,
                        //                   children: [
                        //                  SizedBox(
                        //                    width:MediaQuery.of(context).size.width/1.4.w,
                        //                    child:    RichText(
                        //                    text: TextSpan(
                        //                      text: 'العنوان :   ',
                        //
                        //                      // text: '   العنوان     ',
                        //                      style: K.mainColorTextStyle,
                        //                      children: <TextSpan>[
                        //                        TextSpan(
                        //                            text: controller
                        //                                .agenciesModel
                        //                                ?.data?[index]
                        //                                .address,
                        //                            style: K.primaryTextStyle),
                        //                      ],
                        //                    ),
                        //                  ),)
                        //                   ],
                        //                 ),
                        //                 K.sizedboxH,
                        //                 Button(
                        //                     color: K.mainColor,
                        //                     text: ' اظهار علي الخريطه'.tr,
                        //                     size: MediaQuery.of(context)
                        //                             .size
                        //                             .width /
                        //                         1.w,
                        //                     height: MediaQuery.of(context)
                        //                             .size
                        //                             .width /
                        //                         11.h,
                        //                     isFramed: false,
                        //                     fontSize: 22.sp,
                        //                     onPressed: () async {
                        //                       controller.openMap(
                        //                         lat: double.parse('${controller.agenciesModel ?.data?[index].lat}'),
                        //                         long: controller.agenciesModel?.data?[index].lng?.toDouble(),
                        //                       );
                        //                     }),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     }),

                     ],
                    ),
                  ),
                ),
        ));
  }
}
