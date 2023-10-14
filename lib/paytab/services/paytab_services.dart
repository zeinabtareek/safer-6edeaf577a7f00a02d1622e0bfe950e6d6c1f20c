import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokenFormat.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSDKSavedCardInfo.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTransactionClass.dart';
import 'package:flutter_paytabs_bridge/PaymentSDKQueryConfiguration.dart';
import 'package:get/get.dart';

import '../../componants/custom_snackbar.dart';
import '../../const/app_conss.dart';
import '../../const/style.dart';
import '../../helper/network/dio_integration.dart';

class PayTabController extends GetxController{
  getBillingDetails(
      {billingName,
      billingEmail,
      billingPhone,
      addressLine,
      country,
      city,
      state,
      zipCode}) {
    var billingDetails = BillingDetails(billingName, billingEmail,
        billingPhone, addressLine, country, city, state, zipCode
        // "billing name",
        // "billing email",
        // "billing phone",
        // "address line",
        // "country",
        // "city",
        // "state",
        // "zip code"
        );


    return billingDetails;
  }



  PaymentSdkConfigurationDetails generateConfig({
    cartId,cartDesc,required double amount ,required BillingDetails billingDetails}) {


    var configuration = PaymentSdkConfigurationDetails(
      profileId: "129536",
      serverKey: "S9J9MKB6GM-JHBZMKTGB6-TJ9WBWHRJL",
      clientKey: "CRK2TV-QKN96H-29NK7T-P7MNGP",
      cartId: cartId,
      cartDescription: cartDesc,
      merchantName: "merchant name",
      screentTitle: "ادفع بالبطاقة",
      billingDetails: billingDetails,
      // shippingDetails: shippingDetails,
      locale: PaymentSdkLocale.AR, // PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
      // amount: 555,// amount in double
      amount: amount,// amount in double
      currencyCode: "JOD",
      merchantCountryCode: "JO",
    );
    configuration.showBillingInfo = true;
     // Use the configuration object as needed
    // For example, you can pass it to another function or use it to initiate a payment

    var theme = IOSThemeConfigurations(
      primaryColor: 'FFFFFF',//flutter run
      // primaryColor: '0xFFFF36328',//flutter run
      secondaryColor: 'F36328',//flutter run
      buttonColor: 'F36328'
      // secondaryColor: 'F36328',//flutter run
    );
    theme.backgroundColor = "FFFFFF"; // Color hex value
    // theme.backgroundColor = '0xFFFF0000'; //
      configuration.iOSThemeConfigurations = theme;
    theme.logoImage = 'assets/icons/logo.png';
     configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    return configuration;
  }

   Future<void> payPressed(
       {
    String? name,
     email,
     phone,
     addressLine,
     country,
     city,
     state,
     zipCode, cartId,cartDesc,required double amount,
         required docId,
         required  int agencyId,
         required int dayTripId,
         required num duration,
         required num quantity,
         required String type,
         required String userId,
         required String refId,
         required String movingDate,
         required String time,
       }) async {
    final billingDetails=getBillingDetails(
         billingName:name,
         billingEmail:email,
         billingPhone:phone,
         addressLine:addressLine,
         country:country,
         city:city,
         state:state,
         zipCode:zipCode
    );
    FlutterPaytabsBridge.startCardPayment(generateConfig(
        billingDetails: billingDetails,

        cartId:cartId,cartDesc:cartDesc,amount:amount
    ), (event) async {

      print(event);
      // //setState(() {
        if (event["status"] == "success") {
          var transactionDetails = event["data"];
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            print('transactions :::${transactionDetails['transactionReference']}');
           await updatePayRef(docId: docId.toString(),newPayRefValue:transactionDetails['transactionReference']??'' );
           await setTicketAfterPay(agencyId: agencyId,
               dayTripId: dayTripId,
               price: amount,
               duration: duration,
               quantity: quantity,
               type: type,
               userId: userId,
               // payRef: 'tttt',
               payRef: transactionDetails['transactionReference'].toString(),
               refId: refId, movingDate: movingDate, time: time);

            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            print("failed transaction");
          }
        }
        else if (event["status"] == "error") {
          print("error");
        } else if (event["status"] == "event") {
          print("event");
        }
      });
    update();
    // });
  }



  updatePayRef({required String docId ,newPayRefValue})async{
      await FirebaseFirestore.instance
          .collection('Tickets')
          .doc(docId)
          .update({
        'payRef': newPayRefValue,
        "isPaid":true

      });

      showCustomSnackBar(message: 'تم الدفع بنجاح', isError: false);
      Get.back(); // Assuming you're using the Get package for navigation


// Remaining code...
  }



  final dio = DioUtilNew.dio;

   setTicketAfterPay({
     required int agencyId,
     required num dayTripId,
     required num price,
     required num duration,
     required num quantity,
     required String type,
     required String userId,
     required String payRef,
     required String refId,
     required String movingDate,
     required String time,

   }) async {

       final response = await dio!.post(
           AppConstants.setTicket,data:{
         "agency_id":agencyId,
         "day_trip_id":dayTripId,
         "price":price,
         "duration":duration,
         "type":type,
         "quantity":quantity,
         "userId":userId,
         "payRef":payRef,
         "refId":refId,
         "movingDate":movingDate,
         "time":time

       } );
       if (response.statusCode == 200) {
         print('setTicket :::$response');

         }
       }


}