import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../componants/cusom_trip_list_tile.dart';
import '../../componants/custom_btn.dart';
import '../../componants/error_widget.dart';
import '../../const/style.dart';
import '../../model/search_model.dart';
import '../create_account_screen/create_account_screen.dart';
import '../home_screen/controller/home_screen_controller.dart';
import '../home_screen/home_screen.dart';
import 'controller/book_controller.dart';

class BookTripScreen extends StatelessWidget {
  FocusNode _focusNode = FocusNode();
  SearchModel? searchModel;
  Rxn<DateTime> date;
  String from;
  String to;

  BookTripScreen({
    Key? key,
    this.searchModel,
    required this.date,
    required this.from,
    required this.to,
  }) : super(key: key) {
    // Disable keyboard auto-focus
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeScreenController());

    final controller = Get.put(BookTripController());
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
         'book_trip'.tr,
            style: K.blackText,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            color: K.blackColor,
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '   ${'from'.tr} :   ',
                        style: K.mainColorTextStyle,
                        children: <TextSpan>[
                          TextSpan(
                              text: ' ${from} ', style: K.primaryTextStyle),
                          // TextSpan(text: ' عمان ', style: K.primaryTextStyle),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '   ${'to'.tr} :   ',
                        style: K.mainColorTextStyle,
                        children: <TextSpan>[
                          TextSpan(text: ' $to ', style: K.primaryTextStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                controller.convertTimestamp(date.value!),
                // "2022/09/22",
                style: K.primaryTextStyle,
              ),
              // "${controller.newTime.value?.year}/${controller.newTime.value?.month}/${controller.newTime.value?.day}",style: K.primaryTextStyle,),
              Container(
                decoration: K.boxDecorationFilled,
                // padding: K.fixedPadding,
                margin: K.fixedPadding,
                height: 40.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Expanded(
                child:  Center(
                  child: Text(
                        "price".tr,
                        style: K.whiteTextStyle,
                      ),
                ),
                    ),
                    VerticalDivider(
                      color: K.whiteColor,
                      thickness: 1,
                    ),
                Expanded(
                  child:   Center(
                    child: Text(
                        'moving_time'.tr,
                        style: K.whiteTextStyle,
                      ),
                  ),
                    ),
                    VerticalDivider(
                      color: K.whiteColor,
                      thickness: 1,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'office'.tr,
                          style: K.whiteTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              (searchModel!.data!.trips!.isEmpty)
                  ? Center(
                      child: Obx(() => homeController.isSearching.value
                          ? CircularProgressIndicator()
                          : errorWidget(//لا يوجد لديك اي رحلات ، احجز الان!!
                        text:   Text(
                          'error_no_trips'.tr
                          // '!!لا يوجد لديك اي رحلات ، احجز الان'
                          ,style: TextStyle(color: K.primaryColor,fontSize: 30.sp),),

                          onPressed: () async {
                              await homeController.search(
                                  type: "trip",
                                  newTime:
                                      controller.convertTimestamp(date.value!),
                                  to: to,
                                  from: from,
                                  fromId: homeController
                                      .selectedCityShippingFrom.value.id,
                                  toId: homeController
                                      .selectedCityShippingTo.value.id,
                                  dayId: homeController.dayId.value);
                            })))
                  : ListView.builder(
                      itemCount: searchModel?.data?.trips?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            horizontalOffset: 50.0,
                            // verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: () {
                                  // controller.isClickedFunc(index);
                                  controller.isClickedFunc(index);
                                  print(searchModel?.data?.trips?[index]);
                                  controller.selectedATrip(
                                      searchModel!.data!.trips![index]);
                                  controller.addDurationAndPrintDate(
                                    searchModel?.data!.trips![index].duration ??
                                        0,
                                    date.value!,
                                    searchModel!.data!.trips![index].time
                                        .toString(),
                                  );
                                  controller.totalTripAmount.value =
                                      double.parse(searchModel!
                                          .data!.trips![index].price
                                          .toString());
                                },
                                child: Obx(() {
                                  return CustomTripListTile(
                                    model: searchModel?.data?.trips?[index],
                                    isClicked: index ==
                                        controller.selectedItemIndex.value,
                                  );
                                }),
                              ),
                            ),
                          ),
                        );
                      },
                    )
            ],
          ),
        ),
        bottomSheet: GetBuilder<BookTripController>(
          init: BookTripController(),
          builder: (controller) => CustomTripCalculationBottomSheet(
            tripDetails: controller.selectedTrip,
            date: date,
            searchModel: searchModel!,
          ),
        ));
  }
}

List list = [2, 3, 4, 5, 2, 3, 4, 5, 2, 3, 4, 5, 2, 3, 4, 5];

class CustomTripCalculationBottomSheet extends StatelessWidget {
  Trips tripDetails;
  Rxn<DateTime> date;
  SearchModel searchModel;

  //
  CustomTripCalculationBottomSheet(
      {Key? key,
      required this.tripDetails,
      required this.date,
      required this.searchModel})
      : super(key: key);
  final controller = Get.put(BookTripController());

  @override
  Widget build(BuildContext context) {
    return    Obx(()=>Directionality(
        textDirection: controller.lan.value?TextDirection.rtl:TextDirection.ltr,
        child:Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: K.mainColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${'arrival_date'.tr} :",
                  style: K.whiteTextStyle,
                ),
                Text(
                  // tripDetails.
                  // '20/10/2023',
                  controller.arriveDate.value ?? '',
                  style: K.whiteTextStyle,
                ),
                Text(
                  "${'arrival_time'.tr} :",
                  style: K.whiteTextStyle,
                ),
                Text(
                  controller.arriveTime.value ?? '',
                  // '17:00',
                  style: K.whiteTextStyle,
                ),
              ],
            ),
          ),
          K.sizedboxH,
          Container(
            color: K.whiteColor,
            padding: K.fixedPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                K.sizedboxH,
                GetBuilder<BookTripController>(
                  builder: (controller) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      K.sizedboxW,
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: K.mainColor,
                          ),
                          child: Icon(Icons.remove, color: Colors.white),
                        ),
                        onTap: () {
                          controller.removeFunc(
                              double.parse(tripDetails.price.toString()));
                        },
                      ),
                      Text('  ${controller.tripCounter.value} ',
                          style: K.primaryTextStyle),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: K.mainColor,
                          ),
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                        onTap: () {
                          controller
                              .add(double.parse(tripDetails.price.toString()));
                        },
                      ),
                      Text(
                        '   ${'quantity'.tr}   ',
                        style: K.mainColorTextStyle,
                      ),
                    ],
                  ),
                ),
                K.sizedboxH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    K.sizedboxW,

                    Text(' ${controller.totalTripAmount.value} ${'currency'.tr} ',
                        style: K.primaryTextStyle),
                    // Text(  ' 150 دينار ', style: K.primaryTextStyle),
                    Text(
                      '   ${'total'.tr}  ',
                      // '   اجمالي المبلغ  ',
                      style: K.mainColorTextStyle,
                    ),
                  ],
                ),
              Obx(()=>  Button(
                    color: (searchModel.data!.trips!.isNotEmpty)
                        ? K.mainColor
                        : Colors.black12,
                    textColor: (searchModel.data!.trips!.isNotEmpty)
                        ? Colors.white
                        : K.blackColor.withOpacity(.3),
                    text:controller.isLoading.value?'': 'book'.tr,
                    widget:controller.isLoading.value? const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: CircularProgressIndicator(color: Colors.white,),
                    ):SizedBox(),
                    size: MediaQuery.of(context).size.width / 1.w,
                    height: MediaQuery.of(context).size.width / 11.h,
                    isFramed: false,
                    fontSize: 22.sp,
                    onPressed: () async {
                      controller.validationToAddTripToDb(
                         token: tripDetails.agency?.deviceToken.toString()??'',
                          duration:tripDetails.duration??0
,
                          from: tripDetails.from?.city.toString(),
                          to: tripDetails.to?.city.toString(),
                          movingDate: date.value?.toIso8601String(),
                          movingTime: tripDetails.time ?? '',
                          pivotId:tripDetails.pivot?.id??'',
                          agencyId: tripDetails.agencyId ?? '');
                      // Get.to(const CreateAccountScreen());
                    })),
              ],
            ),
          ),
        ],
         ),
        ),
      ),
    );
  }
}
