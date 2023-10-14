import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:untitled3/model/search_model.dart';

import '../../componants/cusom_trip_list_tile.dart';
import '../../componants/custom_btn.dart';
import '../../componants/custom_text_field.dart';
import '../../componants/cutom_shipment_list_tile.dart';
import '../../componants/error_widget.dart';
import '../../const/style.dart';
import '../create_account_screen/create_account_screen.dart';
import '../home_screen/controller/home_screen_controller.dart';
import 'controller/book_shipment_controller.dart';

class BookShipmentScreen extends StatelessWidget {
  SearchModel? searchModel;
  Rxn<DateTime> date;
  String from;
  String to;

  BookShipmentScreen({
    Key? key,
    this.searchModel,
    required this.date,
    required this.from,
    required this.to,
  }) : super(key: key);

  Widget build(BuildContext context) {
    final controller = Get.put(BookShipmentController());
    final homeController = Get.put(HomeScreenController());
    return  GestureDetector(
        onTap: () {
      FocusScope.of(context).unfocus();
    },
    child:Container(
    alignment: FractionalOffset.center,
    // padding: new EdgeInsets.all(20.0),
    child:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'ارسل شحنه',
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
                        text: '   من :   ',
                        style: K.mainColorTextStyle,
                        children: <TextSpan>[
                          // TextSpan(text: ' ${searchModel?.data!.trips!.first.from!.city} ', style: K.primaryTextStyle),
                          TextSpan(text: ' $from ', style: K.primaryTextStyle),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '   الي :   ',
                        style: K.mainColorTextStyle,
                        children: <TextSpan>[
                          // TextSpan(text: ' ${searchModel?.data!.trips!.first.to!.city}  ', style: K.primaryTextStyle),
                          TextSpan(text: ' $to  ', style: K.primaryTextStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                controller.convertTimestamp(date.value!),
                // date.value.toString(),
                style: K.primaryTextStyle,
              ),
              // "${controller.newTime.value?.year}/${controller.newTime.value?.month}/${controller.newTime.value?.day}",style: K.primaryTextStyle,),
              Container(
                decoration: K.boxDecorationFilled,
                padding:  EdgeInsets.only(top: 10.w,bottom: 10.w),
                margin: K.fixedPadding,
                height: 50.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child:Center(child: Text(
                        'وقت التحرك',
                        style: K.whiteTextStyle,
                      ),
                    ),
                    ),
                    VerticalDivider(
                      color: K.whiteColor,
                      thickness: 1,
                    ),
                    Expanded(
                    child:Center(child:  Text(
                      'المكتب',
                      style: K.whiteTextStyle,
                    ),
                    ),
                    ),
                  ],
                ),
              ),
              K.sizedboxH,
              (searchModel!.data!.trips!.isEmpty)
                  ? Center(
                      child: Obx(() => homeController.isSearching.value
                          ? CircularProgressIndicator()
                          : errorWidget(
                        //لا يوجد لديك اي رحلات ، احجز الان!!
                        //   text:   Text('لا يوجد لديك اي  رحلات ، احجز الان!!',style: TextStyle(color: K.primaryColor,fontSize: 25.sp),),

                          onPressed: () async {
                              await homeController.search(
                                  type: "shipping",
                                  newTime:
                                      controller.convertTimestamp(date.value!),
                                  to: to,
                                  //selectedCityFrom.value.city,
                                  from: from,
                                  //selectedCityTo.value.city ,
                                  fromId: homeController
                                      .selectedCityShippingFrom.value.id,
                                  //controller.selectedCityFrom.value.id,
                                  toId: homeController
                                      .selectedCityShippingTo.value.id,
                                  //controller.selectedCityTo.value.id,
                                  dayId: homeController.dayId.value);
                            })))

                  :
                  Container(
                      height: MediaQuery.of(context).size.height *
                          0.6, // Adjust the height as needed
                      child: ListView.builder(
                        itemCount: searchModel?.data?.trips?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              horizontalOffset: 50.0,
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.isClickedFunc(index);
                                    // Rest of your code...
                                    print(searchModel?.data?.trips?[index]);
                                    controller.selectedATrip(
                                        searchModel!.data!.trips![index]);
                                    controller.addDurationAndPrintDate(
                                        searchModel?.data!.trips![index]
                                                .duration ??
                                            0,
                                        date.value!,
                                        searchModel!.data!.trips![index].time
                                            .toString());
                                    //
                                  },
                                  child: Obx(() {
                                    return CustomShipmentListTile(
                                      trips: searchModel?.data?.trips?[index],
                                      isClicked: index ==
                                          controller.selectedItemIndex.value,
                                    );
                                  }),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              const SizedBox(
                height: 200,
              )
            ],
          ),
        ),
        bottomSheet: GetBuilder<BookShipmentController>(
          init: BookShipmentController(),
          builder: (controller) => CustomCalculationBottomSheet(
            tripDetails: controller.selectedTrip,
            date: date,
            isDisabled: searchModel!.data!.trips!.isEmpty ? true : false,
          ),
          ),
          ),
        ));
  }
}

class CustomCalculationBottomSheet extends StatelessWidget {
  Trips tripDetails;
  Rxn<DateTime> date;
  bool isDisabled;

  CustomCalculationBottomSheet({
    Key? key,
    required this.tripDetails,
    required this.date,
    this.isDisabled = false,
  });

  final controller = Get.put(BookShipmentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: K.mainColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "تاريخ الوصول :",
                    style: K.whiteTextStyle,
                  ),

                  Text(
                    // tripDetails.
                    // '20/10/2023',
                    controller.arriveDate.value ?? '',
                    style: K.whiteTextStyle,
                  ),
                  // K.sizedboxW,
                  Text(
                    'وقت الوصول :',
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
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: ' العرض',
                          hint: "",
                          icon: null,
                          enabled: !isDisabled,
                          controller: controller.widthController,
                          type: TextInputType.number,
                          onChange: (v) {
                            controller. calculationDone.value=false;

                            // _loginController.email=v;
                          },
                        ),
                      ),
                      K.sizedboxW,
                      Expanded(
                        child: CustomTextField(
                          label: ' الطول',
                          hint: "",
                          icon: null,
                          controller: controller.lengthController,
                          enabled: !isDisabled,
                          type: TextInputType.number,
                          onChange: (v) {
                            controller. calculationDone.value=false;

                            // _loginController.email=v;
                          },
                        ),
                      ),
                    ],
                  ),
                  K.sizedboxH,
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: ' الوزن',
                          hint: "",
                          enabled: !isDisabled,
                          icon: null,
                          controller: controller.weightController,
                          type: TextInputType.number,
                          onChange: (v) {
                            controller. calculationDone.value=false;

                            // _loginController.email=v;
                          },
                        ),
                      ),
                      K.sizedboxW,
                      Expanded(
                        child: CustomTextField(
                          label: ' الارتفاع',
                          hint: "",
                          icon: null,
                          enabled: !isDisabled,
                          // enabled:isDisabled,
                          type: TextInputType.number,
                          controller: controller.heightController,
                          onChange: (v) {
                            controller. calculationDone.value=false;
                            // _loginController.email=v;
                          },
                        ),
                      ),
                    ],
                  ),
                  K.sizedboxH,
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: IgnorePointer(
                            ignoring: isDisabled,
                            child: Button(
                                textColor: isDisabled
                                    ? K.blackColor.withOpacity(.3)
                                    : Colors.white,
                                color:
                                    isDisabled ? Colors.black12 : K.mainColor,
                                // textColor:  isDisabled?K.greyColor:Colors.white,
                                text: ' احسب التكلفه'.tr,
                                size: MediaQuery.of(context).size.width / 3.w,
                                height:
                                    MediaQuery.of(context).size.width / 11.h,
                                isFramed: false,
                                fontSize: 22.sp,
                                onPressed: () async {
                                  print(controller.totalPrice.value);
                                  print(tripDetails
                                      .agency?.shippingPrices?.initialPrice
                                      ?.toString());
                                  print(controller.totalPrice.value);
                                  print(controller.totalPrice.value);
                                  print(controller.totalPrice.value);
                                  print(controller.totalPrice.value);
                                  controller.validation(
                                    selectedItemInitialWeight: double.parse(
                                        tripDetails.agency?.shippingPrices
                                                ?.initialWeight
                                                ?.toString() ??
                                            '0.0'),
                                    additionalPrice: double.parse(tripDetails
                                            .agency
                                            ?.shippingPrices
                                            ?.additionalPrice
                                            ?.toString() ??
                                        '0.0'),
                                    selectedItemInitialPrice: double.parse(
                                        tripDetails.agency?.shippingPrices
                                                ?.initialPrice
                                                ?.toString() ??
                                            '0.0'),
                                    price: double.parse(
                                        tripDetails.price?.toString() ?? '0.0'),
                                  );
                                }),
                          ),
                        ),
                        K.sizedboxW,
                        Text(
                          'السعر :',
                          style: K.mainColorTextStyle,
                        ),
                      // Obx(()=>
                      controller.calculationDone.value? Text(
                          '   ${controller.totalPrice.value ?? 0.0} دينار',
                          style: K.primaryTextStyle,
                        )
        :Text('0.0',)

                      ],
                    ),
                  ),
                  IgnorePointer(
                    ignoring: isDisabled,
                    child: Button(
                        color: isDisabled ? Colors.black12 : K.mainColor,
                        textColor: isDisabled
                            ? K.blackColor.withOpacity(.3)
                            : Colors.white,
                        text:controller.isLoading.value?'': ' حجز'.tr,
                        widget:controller.isLoading.value? Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircularProgressIndicator(color: Colors.white,),
                        ):SizedBox(),
                        size: MediaQuery.of(context).size.width / 1.w,
                        height: MediaQuery.of(context).size.width / 11.h,
                        isFramed: false,
                        fontSize: 22.sp,
                        onPressed: () async {
                          controller.bookTrip(
                              tripDetails: tripDetails,
                              movingDate:
                                  controller.convertTimestamp(date.value!));
                          // controller.addTicketToFireStore(tripDetails);
                          // Get.to(const CreateAccountScreen());
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
