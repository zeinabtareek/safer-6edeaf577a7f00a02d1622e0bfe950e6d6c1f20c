import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled3/model/trip_model.dart';

import '../../componants/custom_btn.dart';
import '../../componants/custom_card.dart';
import '../../const/style.dart';
import '../../model/ticket_model.dart';
import '../../paytab/services/paytab_services.dart';
import '../profile/controller/profile_controller.dart';

class TripInfoScreen extends StatelessWidget {


  final payController=Get.put(PayTabController());
  final profileController=Get.put(ProfileController());
  bool isTrip;
  dynamic tripDetails;
    TripInfoScreen({Key? key , required this.isTrip,
      required this. tripDetails
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'تفاصيل التذكره',
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
        child: Padding(
          padding: K.fixedPadding,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                K.sizedboxH,
                CustomCard(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '   من :   ',
                          style: K.mainColorTextStyle,
                          children: <TextSpan>[
                            TextSpan(text: ' ${tripDetails.from??''} ', style: K.primaryTextStyle),
                          ],
                        ),
                      ),
                      Spacer(),
                      RichText(
                        text: TextSpan(
                          text: '   الي :   ',
                          style: K.mainColorTextStyle,
                          children: <TextSpan>[
                            TextSpan(text: ' ${tripDetails.to??''} ', style: K.primaryTextStyle),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                K.sizedboxH1,


                // !isTrip?  tripInfoWidget(tripDetails):shipmentInfoWidget( ),
                !isTrip
                    ? tripInfoWidget(tripDetails as TripModel) // Cast tripDetails as TripModel
                    : shipmentInfoWidget(tripDetails as TicketModel),

                K.sizedboxH,
                Button(
                    color:    tripDetails
                        .isAccepted ==
                        false||tripDetails.isPaid==true
                        ? Colors.black12
                        : K.mainColor,

     // color:tripDetails.isAccepted==true||tripDetails.isPaid==true? K.mainColor:Colors.black12 ,
                    text:  ' ${(tripDetails.isAccepted==false &&tripDetails.isPaid ==false)?'غير جاهز للدفع':
                    (tripDetails.isAccepted==true &&tripDetails.isPaid ==false)?'جاهز للدفع':
                    (tripDetails.isAccepted==true &&tripDetails.isPaid ==true) ?'تم الدفع':'-'
                    }' ,

                    textColor:  tripDetails
                    .isAccepted ==
                false||tripDetails.isPaid==true
                    ? Colors.black12
                    : K.whiteColor,
                    size: MediaQuery.of(context).size.width / 1.w,
                    height: MediaQuery.of(context).size.width / 11.h,
                    isFramed: false,


                    // isFramed: controller.isAcceptedOrder.value?false:true,
                    fontSize: 22.sp,
                    onPressed:
    tripDetails
        .isAccepted ==
    false||tripDetails.isPaid==true
    ? null
        : () {
print(' tripDetails.id, ${ tripDetails.id}');
                      // payController.payPressed(
                      //   name: profileController.userModel?.name??'',
                      //   email:profileController.userModel?.email??'',
                      //      phone:profileController.userModel?.phone??'',
                      //      addressLine: '',
                      //      country: '',
                      //      city: '',
                      //      state: '',
                      //      zipCode: '',
                      //   cartId :tripDetails.id,
                      //   cartDesc :"description ",
                      //   amount: double.parse(tripDetails.price.toString()),
                      //   docId: tripDetails.docId,
                      // );
      payController.  payPressed(
          name: profileController.userModel?.name??'',
          email:profileController.userModel?.email??'',
          phone:profileController.userModel?.phone??'',
          addressLine: '',
          country: '',
          city: '',
          state: '',
          zipCode: '',
          cartId:tripDetails.id.toString()
          ,cartDesc:
      tripDetails.isShipping ==
          true
          ?"ارسال شحنه من  ${tripDetails.from}  الي   ${tripDetails.to}":

      'حجز رحله من "${tripDetails.from}   " الي "${tripDetails.to}"',
          amount:double.parse(tripDetails.price.toString()),
          docId:  tripDetails.docId.toString(),




        agencyId: tripDetails.agencyId,
        dayTripId: tripDetails.pivotId??'',
        duration: tripDetails.duration,
        quantity:tripDetails.isShipping ==
            true
            ?1: tripDetails.quantity,
        type:tripDetails.isShipping ==
            true
            ? "shipping"
            : "trip",
        userId: FirebaseAuth.instance.currentUser?.uid??'',
        refId: tripDetails.id,
        movingDate: tripDetails.movingDate,
        time: tripDetails.movingTime,


        // agencyId: 3,
        // agencyId: trip.agencyId,
        // dayTripId: trip.pivotId??'',
        // duration: trip.duration,
        // quantity:trip.isShipping ==
        //     true
        //     ?1: trip.quantity,
        // type:trip.isShipping ==
        //     true
        //     ? "shipping"
        //     : "trip",
        // userId: FirebaseAuth.instance.currentUser?.uid??'',
        // refId: trip.id,
        // movingDate: trip.movingDate,
        // time: trip.movingTime,
      );

                    }
                ),

                K.sizedboxH,   K.sizedboxH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
shipmentInfoWidget( TicketModel tripDetails){
  return Column(
    children: [
      K.sizedboxH1,
      CustomCard(
        widget: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('تاريخ التحرك :',style: K.mainColorTextStyle,),
                Spacer(),
                Text(tripDetails.movingDate??'',style: K.primaryTextStyle,),
                Spacer(),
              ],
            ),
            K.sizedboxH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('وقت التحرك :',style: K.mainColorTextStyle,),
                Spacer(),
                Text('${tripDetails.movingTime??''}',style: K.primaryTextStyle,),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
      K.sizedboxH1,
      CustomCard(
        widget: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                RichText(
                  text:
                  TextSpan(
                    text: '   الطول :   ',
                    style: K.mainColorTextStyle,
                    children: <TextSpan>[
                      TextSpan(text: ' ${tripDetails.length??''} ', style: K.primaryTextStyle),
                    ],
                  ),
                ),

                Spacer(),
                RichText(
                  text: TextSpan(
                    text: '   العرض :   ',
                    style: K.mainColorTextStyle,
                    children: <TextSpan>[
                      TextSpan(text: ' ${tripDetails.width??''} ', style: K.primaryTextStyle),
                    ],
                  ),
                ),
                Spacer(),

              ],
            ),  K.sizedboxH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RichText(
                  text: TextSpan(
                    text: '  الارتفاع :   ',
                    style: K.mainColorTextStyle,
                    children: <TextSpan>[
                      TextSpan(text: ' ${tripDetails.height??''} ', style: K.primaryTextStyle),
                    ],
                  ),
                ),
                Spacer(),
                RichText(
                  text: TextSpan(
                    text: '  الوزن :   ',
                    style: K.mainColorTextStyle,
                    children: <TextSpan>[
                      TextSpan(text: ' ${tripDetails.weight??''} ', style: K.primaryTextStyle),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),


          ],
        ),
      ),




      K.sizedboxH,
      CustomCard(
        widget: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('تاريخ الوصول :',style: K.mainColorTextStyle,),
                Spacer(),
                Text('${tripDetails.arrivalDate??''}',style: K.primaryTextStyle,),
                Spacer(),
              ],
            ),
            K.sizedboxH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('وقت الوصول :',style: K.mainColorTextStyle,),
                Spacer(),
                Text('${tripDetails.arrivalTime??''}',style: K.primaryTextStyle,),
                Spacer(),
              ],
            ),
          ],
        ),
      ),

      K.sizedboxH1,  K.sizedboxH1,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          K.sizedboxW,
          Text(' السعر :',style: K.mainColorTextStyle,),
          Spacer(),
          Text('${tripDetails.price??''} دينار',style: K.primaryTextStyle,),
          Spacer(),
        ],
      ),
      K.sizedboxH,
  Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          K.sizedboxW,
          Text('حالة الحجز :',style: K.mainColorTextStyle,),
          Spacer(),
          Text('${tripDetails.price??''} دينار',style: K.primaryTextStyle,),
          Spacer(),
        ],
      ),
      K.sizedboxH,

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          K.sizedboxW,
          Text('حالة الحجز :',style: K.mainColorTextStyle,),
          Spacer(),
          Text(' ${(tripDetails.isAccepted==false &&tripDetails.isPaid ==false)?'قيد الانتظار':
          (tripDetails.isAccepted==true &&tripDetails.isPaid ==false)?'مقبول':
          (tripDetails.isAccepted==true &&tripDetails.isPaid ==true) ?" تم الحجز":'-'
          }',style: K.primaryTextStyle,),
          Spacer(),
        ],
      ),
      K.sizedboxH,

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          K.sizedboxW,
          Text('رقم الشحنه:',style: K.mainColorTextStyle,),
          Spacer(),
          Text('${tripDetails.shipmentNum??''} ',style: K.primaryTextStyle,),
          Spacer(),
        ],
      ),
    ],
  );
}

tripInfoWidget( TripModel tripDetails) {
  return Column(
    children: [
      CustomCard(
        widget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('عدد الافراد :',style: K.mainColorTextStyle,),
            Spacer(),
            Text('${tripDetails.quantity??''}',style: K.primaryTextStyle,),
            Spacer(),
          ],
        ),
      ),
      K.sizedboxH1,
      CustomCard(
        widget: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('تاريخ التحرك :',style: K.mainColorTextStyle,),
                Spacer(),
                Text(tripDetails.movingDate??'',style: K.primaryTextStyle,),
                Spacer(),
              ],
            ),
            K.sizedboxH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('وقت التحرك :',style: K.mainColorTextStyle,),
                Spacer(),
                Text('${tripDetails.movingTime??''}',style: K.primaryTextStyle,),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
      K.sizedboxH1,
      CustomCard(
        widget: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('تاريخ الوصول :',style: K.mainColorTextStyle,),
                Spacer(),
                Text(tripDetails.arrivalTime??'',style: K.primaryTextStyle,),
                Spacer(),
              ],
            ),
            K.sizedboxH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('وقت الوصول :',style: K.mainColorTextStyle,),
                Spacer(),
                Text('${tripDetails.arrivalDate??''}',style: K.primaryTextStyle,),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
      K.sizedboxH1,  K.sizedboxH1,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          K.sizedboxW,
          Text('السعر :',style: K.mainColorTextStyle,),
          Spacer(),
          Text('${tripDetails.price??''} دينار',style: K.primaryTextStyle,),
          Spacer(),
        ],
      ),K.sizedboxH,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          K.sizedboxW,
          Text('حالة الحجز :',style: K.mainColorTextStyle,),
          Spacer(),
          Text(' ${(tripDetails.isAccepted==false &&tripDetails.isPaid ==false)?'قيد الانتظار':
          (tripDetails.isAccepted==true &&tripDetails.isPaid ==false)?'مقبول':
          (tripDetails.isAccepted==true &&tripDetails.isPaid ==true) ?" تم الحجز":'-'
          }',style: K.primaryTextStyle,),
          Spacer(),
        ],
      ),
      Container(
        decoration: K.boxDecorationFilled,
        // padding: K.fixedPadding,
        margin: K.fixedPadding,
        height: 40.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('رقم التذكرة',
              style: K.whiteTextStyle,
            ),
            VerticalDivider(
              color: K.whiteColor,
              thickness: 1,
            ),
            Text('رقم المقعد',
              style: K.whiteTextStyle,
            ),
          ],
        ),
      ),
      ListView.builder(
        itemCount: tripDetails.ticketList?.length??0,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // controller.isClickedFunc(index);
            },
            child:
            Container(
              decoration: K.boxDecorationFilledLightGreen,
              // padding: K.fixedPadding,
              margin: EdgeInsets.only(bottom:5.h,left: 10.w,right: 10.w),
              height: 40.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(tripDetails.isPaid ==true?' ${tripDetails.ticketList?[index].ticketNum??''}':'_',
                    style: K.smallBlackText,
                  ),
                  VerticalDivider(
                    color: K.blackColor,
                    thickness: 1,
                  ),
                  Text(tripDetails.isPaid ==true?' ${tripDetails.ticketList?[index].seatNum??''}':'_',
                    style: K.smallBlackText,
                  ),
                ],
              ),
            ),

            // CustomTripListTile(isClicked: controller.isClickedList.value.contains(index)?true:false);

          );
        },
      )

    ],
  );
}