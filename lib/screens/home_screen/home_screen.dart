import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'as intl;
import 'package:untitled3/componants/custom_card.dart';
import 'package:untitled3/const/app_assets.dart';
import 'package:untitled3/screens/book_trip_screen/book_trip_screen.dart';
import 'package:untitled3/screens/home_screen/controller/home_screen_controller.dart';
import '../../componants/custom_body.dart';
import '../../componants/custom_btn.dart';
import '../../const/style.dart';
import '../../main.dart';
import '../../paytab/services/paytab_services.dart';
import '../profile/controller/profile_controller.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    final prController = Get.put(PayTabController());
     return  CustomBody(body: SingleChildScrollView(
        child: Column(
          children: [


            // TextButton(onPressed: (){
            //   prController.  payPressed(
            //
            //     name:'zoz',
            //     email:"zozo@gmail.ccom",
            //     phone:'0111111111',
            //     addressLine:"test address",
            //     country:"test country",
            //     city:"test city",
            //     state:"test state",
            //     zipCode:"test zipCode", amount: 202,
            //   );
            // }, child: Text('test2')),
            Text('book_trip'.tr,
              style: K.extraLargeMainColorTextStyle,
            ),
            K.sizedboxH,
            CustomCard(
              widget:
             Obx(()=>Directionality(
                textDirection: controller.lan.value?TextDirection.rtl:TextDirection.ltr,
              child:
              Column(
                children: [
                  K.sizedboxH,
                  Image.asset(AppAssets.bus, height: 50.h,color: K.primaryColor,),
                  K.sizedboxH,
                  Row(
                    children: [
                      // K.sizedboxW,

                      Obx(()=>  Expanded(
                        child: SizedBox(
                          height: 40.h,
                          child:CustomDropDown(hint: 'choose_place'.tr,
                          listOfItems:controller.listOfCities.value,
                          onSaved: ( v ) {
                           }, onChanged: (v ) {
                            controller.selectedCityFrom.value = v!;    },  type: controller.selectedCityFrom.value, ),
                      ) ),),
                      K.sizedboxW,
                      SizedBox(
                        width: 60.w,
                        child: Center(
                          child: Text('from'.tr,
                            style: K.mainColorTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  K.sizedboxH,


                  Row(
                    children: [
                      // K.sizedboxW,

                      Obx(()=>  Expanded(
                        child: SizedBox(
                          height: 40.h,
                          child: CustomDropDown(hint: 'مكان',
                            listOfItems:controller.listOfCities.value,
                            // listOfItems:controller.listOfCities.where((item) => item != controller.selectedCityTo.value).toList(),
                            onSaved: ( v ) {
                              // controller.selectedValue.value =v!;
                            }, onChanged: (v ) {
                              controller.selectedCityTo.value = v !;
                              // controller. listOfCities.assignAll(controller.listOfCities.where((item) => item != v).toList());

                             },  type: controller.selectedCityTo.value, ),
                        ),
                      ),),
                      K.sizedboxW,
                      SizedBox(

                        width: 60.w,

                        child: Center(
                          child: Text(
                            'to'.tr,
                            style: K.mainColorTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  K.sizedboxH,
///choose
                  Row(
                    children: [
                      // K.sizedboxW,

                      Expanded(
                        child:  SizedBox(
                          height: 40.h,
                          child: GestureDetector(
                          onTap: () async {
                            final date = await controller
                                .showCalender(context: context);
                            if (date == null) return;
                            controller.newTime.value = date;
                            print(controller.dateTime.value);
                            var format = intl.DateFormat.EEEE('ar');
                            var dateString = format.format(date);
                            print(dateString);
                            controller.listOfDays
                                .forEach((element) {
                              if (element.day == dateString) {
                                print(element.id);
                                controller.dayId.value =
                                element.id!;
                              }
                            });

                            // var x=  controller. getDayFromDate(controller.dateTime.value.toString());
                            // print(x);
                          },
                          child: Container(
                          height: 40.h,
                          width: double.infinity,
                          padding: EdgeInsets.only(right: 5.w),
                          // margin: EdgeInsets.only(right: 5.w),
                          decoration: K.boxDecorationLightBgWithBorder,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Obx(
                                    () => controller.newTime.value == null
                                    ? Text(
                                  'choose_date'.tr,
                                  style: K.primaryTextStyle,
                                )
                                    : Text(
                                  "${controller.newTime.value?.year}/${controller.newTime.value?.month}/${controller.newTime.value?.day}",
                                  style: K.primaryTextStyle,
                                ),
                              ),
                            Icon(  Icons.calendar_month,
                                    color: K.primaryColor,
                                  ),
                            ],
                          ),
                        ),
                      ),
                      ),
                      ),

                      K.sizedboxW,
                      SizedBox(
                        width: 60.w,
                        child: Text(
                          '',
                          style: K.mainColorTextStyle,
                        ),
                      ),
                    ],
                  ),



                  K.sizedboxH,
                  Button(
                      color: K.mainColor,
                      widget: Icon(Icons.search,color: Colors.white,),
                      text: 'search'.tr,
                      fontSize: 30.sp,
                      size: MediaQuery.of(context).size.width / 1.w,
                      height: MediaQuery.of(context).size.width / 10.h,
                      isFramed: false,
                      // fontSize: 22.sp,
                      onPressed: () async {
                        print( controller.selectedCityTo.value.city);


                         controller.validateSearch(
                            type: "trip",
                            newTime:controller.newTime,
                            to:controller. selectedCityTo.value.city,//selectedCityFrom.value.city,
                            from:controller. selectedCityFrom.value.city,//selectedCityTo.value.city ,
                            fromId: controller.selectedCityFrom.value.id,//controller.selectedCityFrom.value.id,
                            toId: controller.selectedCityTo.value.id,//controller.selectedCityTo.value.id,
                            dayId:controller. dayId.value

                        );
                        //  controller.search(
                       //      type: "trip",
                       //      newTime:controller.newTime,
                       //      to:controller. selectedCityTo.value.city,//selectedCityFrom.value.city,
                       //      from:controller. selectedCityFrom.value.city,//selectedCityTo.value.city ,
                       //      fromId: controller.selectedCityFrom.value.id,//controller.selectedCityFrom.value.id,
                       //      toId: controller.selectedCityTo.value.id,//controller.selectedCityTo.value.id,
                       //      dayId:controller. dayId.value
                       //
                       //  );

                      }),
                ],
              ),
            ),
            ),
            ),
            K.sizedboxH,
            Text( 'send_shipment'.tr,
              style: K.extraLargeMainColorTextStyle,
              // style: K.largeMainColorTextStyle,
            ),
            K.sizedboxH,
            CustomCard(
              widget:

    Obx(()=>Directionality(
    textDirection: controller.lan.value?TextDirection.rtl:TextDirection.ltr,
 child:   Column(
                children: [
                  K.sizedboxH,
                  Image.asset(AppAssets.shipping, height: 50.h,color: K.primaryColor),
                  K.sizedboxH,

                  ///shipment
                  Row(
                    children: [
                      Obx(()=>  Expanded(
                        child: SizedBox(
                          height: 40.h,
                          child: CustomDropDown(hint: 'مكان',
                            listOfItems:controller.listOfCities.value,
                            onSaved: ( v ) {  }, onChanged: (v ) {
                              controller.selectedCityShippingFrom.value = v !;
                              print(controller.selectedCityShippingFrom.value.id,);
                            }, type: controller.selectedCityShippingFrom.value, ),
                        ),
                      ),),
                      K.sizedboxW,
                      SizedBox(
                        width: 60.w,
                        child: Center(
                          child: Text('from'.tr,
                            style: K.mainColorTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  K.sizedboxH,

                  ///555
                  Row(
                    children: [
                      Obx(()=>  Expanded(
                        child: SizedBox(
                          height: 40.h,
                          child: CustomDropDown(hint: 'مكان',
                          listOfItems:controller.listOfCities.value,
                          onSaved: ( v ) {
                            // controller.selectedValue.value =v!;
                          }, onChanged: (v ) {
                            controller.selectedCityShippingTo.value = v !;
                            print(controller.selectedCityShippingTo.value.id);

                          },   type: controller.selectedCityShippingTo.value, ),
                      ),),),
                      K.sizedboxW,
                      SizedBox(
                        width: 60.w,
                        child: Center(
                          child: Text('to'.tr,
                            style: K.mainColorTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  K.sizedboxH,
                Row(children:[
                Expanded(
                  child: SizedBox(
                    height: 40.h,
                    child: GestureDetector(
                    onTap: () async {
                      final date = await controller
                          .showCalenderShip(context: context);
                      if (date == null) return;
                      controller.newTimeShip.value = date;
                      print(controller.dateTimeShip.value);
                      var format = intl.DateFormat.EEEE('ar');
                      var dateString = format.format(date);
                      print(dateString);
                      controller.listOfDays
                          .forEach((element) {
                        if (element.day == dateString) {
                          print(element.id);
                          controller.dayId.value =
                          element.id!;
                        }
                      });
                    },
                    child: Container(
                            height: 40.h,
                            width: double.infinity,
                            padding: EdgeInsets.only(right: 5.w),
                            // margin: EdgeInsets.only(right: 5.w),
                            decoration: K.boxDecorationLightBgWithBorder,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                Obx(
                                      () => controller.newTimeShip.value == null
                                      ? Text(
                                    'choose_date'.tr,
                                    style: K.primaryTextStyle,
                                  )
                                      : Text(
                                    "${controller.newTimeShip.value?.year}/${controller.newTimeShip.value?.month}/${controller.newTimeShip.value?.day}",
                                    // "${controller.newTime.value?.year}/${controller.newTime.value?.month}/${controller.newTime.value?.day}",
                                    style: K.primaryTextStyle,
                                  ),
                                ),
                                Icon(
                                      Icons.calendar_month,
                                      color: K.primaryColor,
                                    ),
                              ],
                            ),
                          ),
                        ),



                ),
                ),

                  K.sizedboxW,
                  SizedBox(
                    width: 60.w,
                    child: Text(
                      '',
                      style: K.mainColorTextStyle,
                    ),
                  ),
                ],
 ),

                  K.sizedboxH,
                  Button(
                      color: K.mainColor,
                      widget: Icon(Icons.search,color: Colors.white,),
                      text: 'search'.tr,
                      fontSize: 30.sp,

                      size: MediaQuery.of(context).size.width / 1.w,
                      height: MediaQuery.of(context).size.width / 9.h,
                      isFramed: false,
                      onPressed: () async {
                        print(controller.selectedCityShippingFrom.value.id,);
                        print(controller.selectedCityShippingTo.value.id,);
                        // controller.search(
                        //   type: "shipping",
                        //   newTime:controller.newTimeShip,
                        //   to:controller. selectedCityShippingTo.value.city,//selectedCityFrom.value.city,
                        //   from:controller. selectedCityShippingFrom.value.city,//selectedCityTo.value.city ,
                        //   fromId: controller.selectedCityShippingFrom.value.id,//controller.selectedCityFrom.value.id,
                        //   toId: controller.selectedCityShippingTo.value.id,//controller.selectedCityTo.value.id,
                        //     dayId:controller. dayId.value
                        //
                        // );


                        controller.validateSearch(
                            type: "shipping",
                              newTime:controller.newTimeShip,
                              to:controller. selectedCityShippingTo.value.city,//selectedCityFrom.value.city,
                              from:controller. selectedCityShippingFrom.value.city,//selectedCityTo.value.city ,
                              fromId: controller.selectedCityShippingFrom.value.id,//controller.selectedCityFrom.value.id,
                              toId: controller.selectedCityShippingTo.value.id,//controller.selectedCityTo.value.id,
                                dayId:controller. dayId.value
                            );
                      }),
                ],
              ),
            )
            )
            )
          ],
        ),
      ),
      isLoadoing:controller.isSearching, appBarText:  'home'.tr,
    );
  }
}


