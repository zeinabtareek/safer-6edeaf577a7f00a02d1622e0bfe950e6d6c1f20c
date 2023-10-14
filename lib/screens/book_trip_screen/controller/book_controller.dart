import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/model/ticket_model.dart';

import '../../../componants/custom_snackbar.dart';
import '../../../controller/language_controller.dart';
import '../../../model/search_model.dart';
import '../../../model/trip_model.dart';
import '../../../services/ticket_services.dart';
import '../book_trip_screen.dart';

class BookTripController extends GetxController {
  final isClicked = false.obs;
  final isClickedList = [].obs;
  Trips selectedTrip = Trips();
  final arriveTime = ''.obs;
  final arriveDate = ''.obs;
  final tripCounter = 1.obs;
  final totalTripAmount = 0.0.obs;
  final isLoading=false.obs;

  // isClickedFunc(index) {
  //   if (isClickedList.contains(index)) {
  //     isClickedList.remove(index);
  //   } else {
  //     isClickedList.add(index);
  //   }
  // }
  final selectedItemIndex = RxInt(-1);
  final co=Get.put(LocalizationController());

  final lan=false.obs;


  @override
  void onInit() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    lan.value=co.isLtr;

  }

  void isClickedFunc(int index) {
    if (selectedItemIndex.value == index) {
      // Clicked item is already selected, deselect it
      selectedItemIndex.value = -1;
    } else {
      // Clicked item is not selected, select it
      selectedItemIndex.value = index;
    }
  }

  selectedATrip(Trips selectedTrip1) {
    selectedTrip = selectedTrip1;
    update();
  }

  addDurationAndPrintDate(
      int durationInMinutes, DateTime timestamp, String time) {
    try {
      final timeComponents = time.split(':');
      final hours = int.parse(timeComponents[0]);
      final minutes = int.parse(timeComponents[1]);

      final dateTime = DateTime(
          timestamp.year, timestamp.month, timestamp.day, hours, minutes);
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

  String convertTimestamp(DateTime timestamp) {
    final DateFormat dateFormat = DateFormat('dd/MM/yyy');
    // final DateFormat /dateFormat = DateFormat('yyyy/MM/dd');
    final String formattedDate = dateFormat.format(timestamp);
    return formattedDate;
  }

  add(double tripCost) {
    tripCounter.value++;
    totalTripAmount.value = tripCounter.value * tripCost;
    update();
  }

  removeFunc(double tripCost) {
    if (tripCounter.value > 1) {
      tripCounter.value--;
      totalTripAmount.value = tripCounter.value * tripCost;
    }
    update();
  }

  TicketServices ticketServices = TicketServices();

  validationToAddTripToDb({from, to, movingDate, movingTime, agencyId,pivotId ,duration,token}) async {
    if (selectedTrip.price == null) {
      showCustomSnackBar(message: 'choose_trip_first'.tr, isError: true);
    } else {
      addTripToDb(from:from, to:to, movingDate:movingDate, movingTime:movingTime, agencyId:agencyId,pivotId:pivotId,duration:duration, token: token);
      await sendNotification(token: token);
    }
    update();
  }
  ///TODO add trip to db


  addTripToDb({from, to, movingDate, movingTime, agencyId,pivotId,duration, required token}) async {
    isLoading.value=true;
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    String movingDateString = movingDate;
    DateTime movingDateTime = DateTime.parse(movingDateString);

    String formattedMovingDate = convertTimestamp(movingDateTime);
    List<Trip> tickets = [];
    for (int i = 0; i < tripCounter.value; i++) {
      Trip ticket = Trip(
        seatNum: 'A${i + 1}',
        ticketNum: (i + 1).toString(),
      );
      tickets.add(ticket);
    }

    TripModel ticketModel = TripModel(
      agencyId: agencyId,
      quantity: tripCounter.value,
      arrivalDate: arriveDate.value ?? '',
      arrivalTime: arriveTime.value ?? '',
      from: from,
      to: to,
      price: totalTripAmount.value.toString(),
      isAccepted: false,
      isShipping: false,
      isPaid: false,
      isRejected: false,
      lastUpdate: Timestamp.now(),
      movingDate: formattedMovingDate,
      movingTime: movingTime,
      userId: uid,
      duration:duration,
      payRef: '',
      pivotId:pivotId,
      ticketList: tickets,
    );

    String docId = await ticketServices.addTripToFirestore(ticketModel);
    if (docId != null) {
      ticketModel.id = docId;
      await FirebaseFirestore.instance
          .collection('Tickets')
          .doc(docId)
          .update({'id': ticketModel.id});

      showCustomSnackBar(message: 'trip_booked_success'.tr, isError: false);
      await sendNotification(token: token);

      Get.back(); // Assuming you're using the Get package for navigation
    } else {
      showCustomSnackBar(message:'error_book_trip'.tr);
      print('Error adding trip to Firestore');
    }
    isLoading.value=false;

  }
  Future<void> sendNotification({token}) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    Dio dio = Dio();
    final data = {
      "data": {
        "message": "Accept Trip Request",
        "title": "This is Trip Request",
      },
      "to":  token,  // "to": "cbgfzz_RQj-s_TVxwBk-KO:APA91bG6RYhVrz6tRvNxddbGwjmb_JBE7iTSAMziW2WfUemNZFpSFdduXXtBAFcTOd_8WOyMsIv3-RqIIgcn2jf0xIvHEqWagI5f0S_kiyWQHSn3w_Mk6MhmrtJT-ZWij0hTr9ur1hUK"
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


}
