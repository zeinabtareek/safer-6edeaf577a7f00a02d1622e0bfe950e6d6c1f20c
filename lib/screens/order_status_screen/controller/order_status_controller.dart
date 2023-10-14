import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:untitled3/model/trip_model.dart';
import 'package:untitled3/services/home_services.dart';

import '../../../helper/connectivity.dart';

// class OrderStatusController extends GetxController {
//   final service = HomeServices();
//   final isAcceptedOrder = false.obs;
//   final trips = <TripModel>[].obs;
//    final loading = false.obs;
//
//   @override
//   Future<void> onInit() async {
//     // TODO: implement onInit
//     super.onInit();
//     service.getAllTicket();
//     // loading.value = true;
//     trips.assignAll(await service.getAllTicket());
//     // loading.value = false;
//   }
//
//
//
// }
class OrderStatusController extends GetxController {
  final service = HomeServices();
  final isAcceptedOrder = false.obs;
  final trips = <dynamic>[].obs;
  final loading = false.obs;
  Timer? refreshTimer;
  final connection = Get.put(ConnectionStatusSingleton());

  @override
  onInit()   {
    super.onInit();
    loading.value = true;
///this works fine

    refreshTimer = Timer.periodic(Duration(seconds: 10), (_) {
      fetchTrips();
    loading.value = false;
    });
  }


  @override
  void onClose() {
    refreshTimer?.cancel();
    super.onClose();
  }


  Future<void> fetchTrips() async {
    loading.value = true;
    try {
      final data = await service.getAllTicket();
      trips.assignAll(data);
    } catch (e) {
      // Handle error
    } finally {
      loading.value = false;
    }
  }

// getDocId()async{
//   var docId ;
//   final data = await service.getAllTicket();
//   trips.assignAll(data.map((dynamic model) {
//     docId= model.docId;
//     print('Document ID: $docId');
// }));
//
//   print('Document ID::: $docId');
// }





}