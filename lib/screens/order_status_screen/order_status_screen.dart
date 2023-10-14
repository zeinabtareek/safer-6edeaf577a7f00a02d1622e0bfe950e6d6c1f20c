import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled3/componants/error_widget.dart';
import 'package:untitled3/screens/profile/controller/profile_controller.dart';

import '../../componants/custom_btn.dart';
import '../../componants/custom_card.dart';
import '../../const/app_assets.dart';
import '../../const/style.dart';
import '../../model/ticket_model.dart';
import '../../model/trip_model.dart';
import '../../paytab/services/paytab_services.dart';
import '../bill_details_screen/bill_details_screen.dart';
import '../trip_info_screen/trip_info_screen.dart';
import 'controller/order_status_controller.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderStatusController());
    final List<Tab> tabs = [
      Tab(text: "shipping_tab".tr),
      Tab(text: "trips_tab".tr,),

    ];
    return  DefaultTabController(
        length: tabs.length,
        child: Scaffold(
      //
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('orders_Status_title'.tr,
          style: K.blackText,
        ),
        bottom: TabBar(
          indicatorColor: K.primaryColor,
          unselectedLabelColor: K.blackColor,
          labelColor: K.primaryColor,
          tabs: tabs,
          onTap: (v){
            print( controller.trips.length);

          },
        ),
      ),
      body:
      TabBarView(
        children: [
          tripCards(isShipping:true),
          tripCards(isShipping:false),
        ],
      ),
      ),





    );
  }
}

Widget tripCards({required bool isShipping}) {
  final controller = Get.put(OrderStatusController());
  final prController = Get.put(PayTabController());
  final profileController = Get.put(ProfileController());
  var docId ='';
  return Obx(
        () {
      final filteredTrips = controller.trips
          .where((trip) => (trip is TripModel && !isShipping) || (trip is TicketModel && isShipping))
          .toList();
       // final data = controller. service.getAllTicket();

      return Obx(
              () => controller.loading.value
              ? const Center(
             child: CircularProgressIndicator( ),
          )
              : controller.connection.connectivity.value == 1
              ?filteredTrips.isEmpty?
              Center(
                  child: errorWidget(
                      text:   SizedBox(

                          child: Text(isShipping ==true ?
                          '${'error_no_shipping_tickets'.tr}  ':
                          '  ${'error_no_trip_tickets'.tr} '
                            ,style: TextStyle(color: K.primaryColor,fontSize: 25.sp),)),
                      onPressed: () {
                        controller.fetchTrips();
                      },
                      noButton: false)):
              Padding(
                padding: K.fixedPadding,
                child: ListView.builder(
                  itemCount: filteredTrips.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final trip = filteredTrips[index];
                    return   Padding(
                                  padding: K.fixedPaddingOnlyTopAndBottom,
                                  child: CustomCard(
                                    widget: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: '   ${'from'.tr} :   ',
                                                    style:
                                                    K.mainColorTextStyle,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: trip.from,
                                                          style: K
                                                              .primaryTextStyle),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: '   ${'to'.tr} :   ',
                                                    style:
                                                    K.mainColorTextStyle,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: trip.to,
                                                          style: K
                                                              .primaryTextStyle),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          K.sizedboxH,
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                '  ${'booking_type'.tr}   :   ',
                                                style: K
                                                    .mainColorTextStyle,
                                              ),
                                              Text(trip.isShipping ==
                                                  true
                                                  ? "shipping_tab".tr
                                                  : "trips_tab".tr,
                                                  style: K
                                                      .primaryTextStyle),
                                              K.sizedboxW,
                                            ],
                                          ),
                                          K.sizedboxH,
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                '  ${'booking_date'.tr}   :   ',
                                                style: K
                                                    .mainColorTextStyle,
                                              ),
                                              Text(trip.movingDate ??
                                                  "",
                                                  style: K
                                                      .primaryTextStyle),
                                              K.sizedboxW,
                                            ],
                                          ),
                                          K.sizedboxH,
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                '  ${'booking_status'.tr}   :   ',
                                                style: K
                                                    .mainColorTextStyle,
                                              ),
                                              Text(
                                                  ' ${(trip.isAccepted ==
                                                      false &&
                                                      trip.isPaid ==
                                                          false)
                                                      ? 'قيد الانتظار'
                                                      : (trip
                                                      .isAccepted ==
                                                      true &&
                                                      trip.isPaid ==
                                                          false)
                                                      ? 'مقبول'
                                                      : (trip
                                                      .isAccepted ==
                                                      true &&
                                                      trip.isPaid == true)
                                                      ? " تم الحجز"
                                                      : '-'}',
                                                  style: K
                                                      .primaryTextStyle),
                                              K.sizedboxW,
                                            ],
                                          ),
                                          K.sizedboxH,
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Button(
                                                    color: K.mainColor,
                                                    text: ' ${'office_details'.tr}  '
                                                        .tr,
                                                    size:
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        1.w,
                                                    height:
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        11.h,
                                                    isFramed: false,
                                                    fontSize: 22.sp,
                                                    onPressed: () async {
                                                      Get.to(() =>
                                                          TripInfoScreen(
                                                              isTrip: trip
                                                                  .isShipping ==
                                                                  true
                                                                  ? true
                                                                  : false,
                                                              tripDetails: trip));
                                                      // const BillDetailsScreen());
                                                    }),
                                              ),
                                              K.sizedboxW,
                                              Expanded(
                                                child: Button(
                                                  color: trip
                                                      .isAccepted ==
                                                      false||trip.isPaid==true
                                                      ? Colors.black12
                                                      : K.mainColor,
                                                  text:

                                                  ' ${(trip.isAccepted ==
                                                      false &&
                                                      trip.isPaid ==
                                                          false)
                                                      ? 'not_ready_to_pay'.tr
                                                      : (trip
                                                      .isAccepted ==
                                                      true &&
                                                      trip.isPaid ==
                                                          false)
                                                      ? 'state_accepted'.tr
                                                      : (trip
                                                      .isAccepted ==
                                                      true &&
                                                      trip.isPaid == true)
                                                      ? 'paid'.tr
                                                      : '-'}',
                                                  textColor:  trip
                                                      .isAccepted ==
                                                      false||trip.isPaid==true
                                                      ? Colors.black12
                                                      : K.whiteColor,
                                                  size: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width /
                                                      1.w,
                                                  height:
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width /
                                                      11.h,
                                                  isFramed: true,
                                                  fontSize: 22.sp,
                                                  onPressed: trip
                                                      .isAccepted ==
                                                      false||trip.isPaid==true
                                                      ? null
                                                      : () {
                                                    ///TODO Payment

                                                    prController.  payPressed(
                                                        name: profileController.userModel?.name??'',
                                                        email:profileController.userModel?.email??'',
                                                        phone:profileController.userModel?.phone??'',
                                                        addressLine: '',
                                                        country: '',
                                                        city: '',
                                                        state: '',
                                                        zipCode: '',
                                                        cartId:trip.id.toString()
                                                        ,cartDesc:
                                                    trip.isShipping ==
                                                      true
                                                      ?"ارسال شحنه من  ${trip.from}  الي   ${trip.to}":

                                                    'حجز رحله من "${trip.from}   " الي "${trip.to}"',

                                                        amount:double.parse(trip.price.toString()),
                                                        docId:  trip.docId.toString(),

                                                        // agencyId: 3,
                                                        agencyId: trip.agencyId,
                                                        dayTripId: trip.pivotId??'',
                                                         duration: trip.duration,
                                                        quantity:trip.isShipping ==
                                                            true
                                                            ?1: trip.quantity,
                                                        type:trip.isShipping ==
                                                            true
                                                            ? "shipping"
                                                            : "trip",
                                                        userId: FirebaseAuth.instance.currentUser?.uid??'',
                                                         refId: trip.id,
                                                        movingDate: trip.movingDate,
                                                        time: trip.movingTime,

                                                    );
                                                    // Get.to(
                                                    //     () => TripInfoScreen(
                                                    //           isTrip:
                                                    //               index == 0
                                                    //                   ? true
                                                    //                   : false,
                                                    //         ));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              // ),
                        // ],
                      // ),
                    ),
              )














             :
    Center(  child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.no_connection,
            height: 300.h,
            width: 300.w,
            // color: K.primaryColor,
          ),
          Text(
            'لا يوجد اتصال'.tr,
            style: TextStyle(
                fontSize: 25.sp,
                color: K.primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ],
      )
      )
      );
    },
  );
}
// Widget tripCards({required bool isShipping}) {
//   final controller = Get.put(OrderStatusController());
//
//   return   Obx(
//       () => controller.loading.value
//       ? const Center(
//     child: CircularProgressIndicator(),
//   )
//       : controller.connection.connectivity.value == 0
//       ? Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             AppAssets.no_connection,
//             height: 300.h,
//             width: 300.w,
//             // color: K.primaryColor,
//           ),
//           Text(
//             'لا يوجد اتصال'.tr,
//             style: TextStyle(
//                 fontSize: 25.sp,
//                 color: K.primaryColor,
//                 fontWeight: FontWeight.bold),
//           ),
//         ],
//       ))
//       : controller.trips.isEmpty
//       ? Center(
//       child: errorWidget(
//           onPressed: () {
//             controller.fetchTrips();
//           },
//           noButton: false))
//       : SingleChildScrollView(
//     child: Column(
//       children: [
//         ListView.builder(
//             itemCount: controller.trips.length,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: K.fixedPaddingOnlyTopAndBottom,
//                 child: CustomCard(
//                   widget: Directionality(
//                     textDirection: TextDirection.rtl,
//                     child: Column(
//                       mainAxisAlignment:
//                       MainAxisAlignment.start,
//                       crossAxisAlignment:
//                       CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: RichText(
//                                 text: TextSpan(
//                                   text: '   من :   ',
//                                   style:
//                                   K.mainColorTextStyle,
//                                   children: <TextSpan>[
//                                     TextSpan(
//                                         text: controller
//                                             .trips[index]
//                                             .from,
//                                         style: K
//                                             .primaryTextStyle),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: RichText(
//                                 text: TextSpan(
//                                   text: '   الي :   ',
//                                   style:
//                                   K.mainColorTextStyle,
//                                   children: <TextSpan>[
//                                     TextSpan(
//                                         text: controller
//                                             .trips[index]
//                                             .to,
//                                         style: K
//                                             .primaryTextStyle),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         K.sizedboxH,
//                         Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment
//                               .spaceBetween,
//                           children: [
//                             Text(
//                               '  نوع الحجز   :   ',
//                               style: K.mainColorTextStyle,
//                             ),
//                             Text(
//                                 controller.trips[index]
//                                     .isShipping ==
//                                     true
//                                     ? "شحن"
//                                     : "رحلات",
//                                 style: K.primaryTextStyle),
//                             K.sizedboxW,
//                           ],
//                         ),
//                         K.sizedboxH,
//                         Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment
//                               .spaceBetween,
//                           children: [
//                             Text(
//                               '  تاريخ الحجز   :   ',
//                               style: K.mainColorTextStyle,
//                             ),
//                             Text(
//                                 controller.trips[index]
//                                     .movingDate ??
//                                     "",
//                                 style: K.primaryTextStyle),
//                             K.sizedboxW,
//                           ],
//                         ),
//                         K.sizedboxH,
//                         Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment
//                               .spaceBetween,
//                           children: [
//                             Text(
//                               '  حالة الحجز   :   ',
//                               style: K.mainColorTextStyle,
//                             ),
//                             Text(
//                                 ' ${(controller.trips[index].isAccepted == false && controller.trips[index].isPaid == false) ? 'قيد الانتظار' : (controller.trips[index].isAccepted == true && controller.trips[index].isPaid == false) ? 'مقبول' : (controller.trips[index].isAccepted == true && controller.trips[index].isPaid == true) ? " تم الحجز" : '-'}',
//                                 style: K.primaryTextStyle),
//                             K.sizedboxW,
//                           ],
//                         ),
//                         K.sizedboxH,
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Button(
//                                   color: K.mainColor,
//                                   text: ' التفاصيل  '.tr,
//                                   size:
//                                   MediaQuery.of(context)
//                                       .size
//                                       .width /
//                                       1.w,
//                                   height:
//                                   MediaQuery.of(context)
//                                       .size
//                                       .width /
//                                       11.h,
//                                   isFramed: false,
//                                   fontSize: 22.sp,
//                                   onPressed: () async {
//                                     Get.to(() => TripInfoScreen(
//                                         isTrip: controller
//                                             .trips[
//                                         index]
//                                             .isShipping ==
//                                             true
//                                             ? true
//                                             : false,
//                                         tripDetails:
//                                         controller
//                                             .trips[
//                                         index]));
//                                     // const BillDetailsScreen());
//                                   }),
//                             ),
//                             K.sizedboxW,
//                             Expanded(
//                               child: Button(
//                                 color: controller
//                                     .trips[index]
//                                     .isAccepted ==
//                                     false
//                                     ? Colors.black12
//                                     : K.mainColor,
//                                 text:
//
//                                 // controller.trips[index]
//                                 //             .isPaid ==
//                                 //         true
//                                 //     ? 'تم الدفع'
//                                 //     : 'جاهز للدفع',
//                                 ' ${(controller.trips[index].isAccepted == false && controller.trips[index].isPaid == false) ? 'غير جاهز للدفع' : (controller.trips[index].isAccepted == true && controller.trips[index].isPaid == false) ? 'جاهز للدفع' : (controller.trips[index].isAccepted == true && controller.trips[index].isPaid == true) ? 'تم الدفع' : '-'}',
//                                 textColor: controller
//                                     .trips[index]
//                                     .isAccepted ==
//                                     true
//                                     ? K.whiteColor
//                                     : K.blackColor
//                                     .withOpacity(.3),
//                                 size: MediaQuery.of(context)
//                                     .size
//                                     .width /
//                                     1.w,
//                                 height:
//                                 MediaQuery.of(context)
//                                     .size
//                                     .width /
//                                     11.h,
//                                 isFramed: true,
//                                 fontSize: 22.sp,
//                                 onPressed: controller
//                                     .trips[index]
//                                     .isAccepted ==
//                                     false
//                                     ? null
//                                     : () {
//                                   // Get.to(
//                                   //     () => TripInfoScreen(
//                                   //           isTrip:
//                                   //               index == 0
//                                   //                   ? true
//                                   //                   : false,
//                                   //         ));
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }),
//       ],
//     ),
//   ),
// );
// }