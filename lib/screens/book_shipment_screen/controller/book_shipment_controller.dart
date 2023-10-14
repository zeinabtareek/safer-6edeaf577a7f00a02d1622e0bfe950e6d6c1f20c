import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/model/ticket_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../componants/custom_snackbar.dart';
import '../../../model/search_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/ticket_services.dart';

class BookShipmentController extends GetxController {
  final isClicked = false.obs;

  // final isClickedList = [].obs;
  Trips selectedTrip = Trips();
  final dateTime = ''.obs;
  final arriveTime = ''.obs;
  final arriveDate = ''.obs;
  final totalPrice = 0.0.obs;
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  final isLoading = false.obs;
  final calculationDone = false.obs;

  final selectedItemIndex = RxInt(-1);

  void isClickedFunc(int index) {
    calculationDone.value = false;

    if (selectedItemIndex.value == index) {
      // Clicked item is already selected, deselect it
      selectedItemIndex.value = -1;
      selectedTrip.price = null;
    } else {
      // Clicked item is not selected, select it
      selectedItemIndex.value = index;
    }
  }

  selectedATrip(Trips selectedTrip1) {
    selectedTrip = selectedTrip1;
    update();
  }

  validation(
      {required double selectedItemInitialWeight,
      required double additionalPrice,
      required double selectedItemInitialPrice,
      required double price}) async {
    if (selectedTrip.price == null) {
      showCustomSnackBar(message: 'تاكد من اختيار رحله اولا', isError: true);
    }
    if (widthController.text == '' ||
        weightController.text == '' ||
        heightController.text == '' ||
        lengthController.text == '') {
      showCustomSnackBar(
          message: ' تاكد من ادخال قيم الارتفاع و الطول و العرض و الوزن ',
          isError: true);
    } else {
      calculate(
          selectedItemInitialWeight: selectedItemInitialWeight,
          additionalPrice: additionalPrice,
          selectedItemInitialPrice: selectedItemInitialPrice,
          price: price);
    }
    update();
  }

  calculate(
      {required double selectedItemInitialWeight,
      required double additionalPrice,
      required double selectedItemInitialPrice,
      required double price}) {
    final weight = double.parse(weightController.text);
    if (weight > selectedItemInitialWeight) {
      double extraWeight = weight - selectedItemInitialWeight;
      double extraPrice = extraWeight * additionalPrice;
      totalPrice.value = extraPrice + selectedItemInitialPrice + price;
      print(totalPrice.value);
    } else {
      totalPrice.value = selectedItemInitialPrice + price;
    }
    calculationDone.value = true;
    update();
  }

  String convertTimestamp(DateTime timestamp) {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final String formattedDate = dateFormat.format(timestamp);
    return formattedDate;
  }

  addDurationAndPrintDate(
      int durationInMinutes, DateTime timestamp, String time) {
    try {
      final timeComponents = time.split(':');
      final hours = int.parse(timeComponents[0]);
      final minutes = int.parse(timeComponents[1]);

      final dateTime = DateTime(
          timestamp.day, timestamp.month, timestamp.year, hours, minutes);
      final duration = Duration(minutes: durationInMinutes);
      final newDateTime = dateTime.add(duration);
      arriveDate.value =
          "${newDateTime.day}/${newDateTime.month}/${newDateTime.year}";
      print('New Date: ${arriveDate.value}');
      arriveTime.value =
          ' ${newDateTime.hour}:${newDateTime.minute.toString().padLeft(2, '0')}';
      print('New Date: ${arriveTime.value}');

      // print('New Time: ${newDateTime.hour}:${newDateTime.minute.toString().padLeft(2, '0')}');
    } catch (e) {
      // Handle parsing errors
      print('Invalid time format. Using default values.');
      // Provide default values or handle the error as needed
    }
    update();
  }

  bookTrip({required Trips tripDetails, movingDate}) async {
    if (totalPrice.value == 0.0 ||
        !calculationDone.value ||
        selectedTrip.price == 0.0) {
      showCustomSnackBar(message: ' تاكد من حسب التكلفه اولا  ', isError: true);
    } else {
      // print('it\'s ok $selectedTrip');
      addTicketToFirestore(tripDetails, movingDate ,duration:tripDetails.duration??0,pivotId:tripDetails.pivot?.id??'' );
      await sendNotification(token: tripDetails.agency?.deviceToken.toString()??'');
    }
  }

  TicketServices ticketServices = TicketServices();

  ///TODO add ticket to db
  Future<void> addTicketToFirestore(Trips tripDetails, movingDate,
      {pivotId, duration}) async {
    isLoading.value = true;

    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';

    TicketModel ticketModel = TicketModel(
      arrivalDate: arriveDate.value,
      arrivalTime: arriveTime.value,
      agencyId: tripDetails.agencyId,
      from: tripDetails.from?.city,
      to: tripDetails.to?.city,
      price: totalPrice.value.toString(),
      // id: 'id',
      isAccepted: false,
      isShipping: true,
      isPaid: false,
      movingDate: movingDate,
      movingTime: tripDetails.time,
      userId: uid,
      height: heightController.text,
      length: lengthController.text,
      width: widthController.text,
      weight: weightController.text,
      duration: duration,
      payRef: '',
      pivotId: pivotId,
      shipmentNum: '',
    );
    // try {
    // print('Adding ticket to Firestore...');
    // CollectionReference ticketsRef =
    // FirebaseFirestore.instance.collection('Tickets');
    // DocumentReference newTicketRef = await ticketsRef.add(ticketModel.toJson());
    // String ticketId = newTicketRef.id; // Get the document ID
    // ticketModel.id = ticketId; // Assign the document ID to the ticketModel
    // await newTicketRef.set(ticketModel.toJson()); // Update the document with the ticketModel
    //
    // print('Ticket added successfully. Ticket ID: $ticketId');
    // } catch (error) {
    //   print('Failed to add ticket: $error');
    // }

    String docId = await ticketServices.addTicketToFirestore(ticketModel);
    if (docId != null) {
      ticketModel.id = docId;
      await FirebaseFirestore.instance
          .collection('Tickets')
          .doc(docId)
          .update({'id': ticketModel.id});

      showCustomSnackBar(
          message: 'Shipment booked successfully',
          isError: false,
          isInfo: false);
      Get.back(); // Assuming you're using the Get package for navigation
    } else {
      showCustomSnackBar(message: 'Error booking ticket');
      print('Error adding ticket to Firestore');
    }
    isLoading.value = false;
  }

  Future<void> sendNotification({token}) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    Dio dio = Dio();
    final data = {
      "data": {
        "message": "Accept Ride Request",
        "title": "This is Ride Request",
      },
      "to":token
          // "cbgfzz_RQj-s_TVxwBk-KO:APA91bG6RYhVrz6tRvNxddbGwjmb_JBE7iTSAMziW2WfUemNZFpSFdduXXtBAFcTOd_8WOyMsIv3-RqIIgcn2jf0xIvHEqWagI5f0S_kiyWQHSn3w_Mk6MhmrtJT-ZWij0hTr9ur1hUK"
    };

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] =
        'key=AAAAz9Q9Nzs:APA91bEGb8YbSZshnf2POzsVqShaDwyEivIu0Xoh32PzJQBNXkALkKY-CbGNK62jKUYQ9MJL2pZ3DwZxY8mSA2NNIMCU3gyeibfW6hWlf2W2pwjEZZZ9jUU4xhj7EMm1RbroIXAYgJDF';

    try {
      final response = await dio.post(postUrl, data: data);

      if (response.statusCode == 200) {
        print('Request Sent To Driver');
      } else {
        print('notification sending failed');
      }
    } catch (e) {
      print('exception $e');
    }
  }

  Future<String?> getDeviceToken() async {
    print(await FirebaseMessaging.instance.getToken());
    return await FirebaseMessaging.instance.getToken();
  }
}
