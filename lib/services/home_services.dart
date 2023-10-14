import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:untitled3/const/app_conss.dart';
import 'package:untitled3/model/agencies_model.dart';
import 'package:untitled3/model/cities_model.dart';
import 'package:untitled3/model/days_model.dart';
import 'package:untitled3/model/search_model.dart';
import 'package:untitled3/model/ticket_model.dart';
import 'package:untitled3/model/trip_model.dart';

import '../helper/network/dio_integration.dart';
import '../screens/book_shipment_screen/book_shipment_screen.dart';
import '../screens/book_trip_screen/book_trip_screen.dart';

class HomeServices {
  final store = FirebaseFirestore.instance;
  final dio = DioUtilNew.dio;

  getCities() async {
    try {
      final response = await dio!.get(AppConstants.getCitiesUrl);
      if (response.statusCode == 200) {
        var model = CitiesModel.fromJson(response.data);
        return model.data;
      } else {
        print('Failed to fetch : ${response.statusCode}');
        throw Exception(
            'Failed to fetch logged user. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('An error occurred: $error');
      throw Exception('An error occurred: $error');
    }
  }

  getDays() async {
    try {
      final response = await dio!.get(AppConstants.getDayssUrl);

      if (response.statusCode == 200) {
        var model = DaysModel.fromJson(response.data);
        return model.data;
      } else {
        print('Failed to fetch : ${response.statusCode}');
        throw Exception(
            'Failed to fetch logged user. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('An error occurred: $error');
      throw Exception('An error occurred: $error');
    }
  }

  getAgencies() async {
    try {
      final response = await dio!.get(AppConstants.getAgencies);

      if (response.statusCode == 200) {
        print(response.data);
        return AgenciesModel.fromJson(response.data);
      } else {
        print('Failed to fetch : ${response.statusCode}');
        throw Exception(
            'Failed to fetch logged user. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('An error occurred: $error');
      throw Exception('An error occurred: $error');
    }
  }
  //
  // Future search(
  //     {int? fromId, toId, dayId, String? type, date, from, to}) async {
  //   try {
  //     final response = await dio!.get(
  //         "${AppConstants.search}/fromId=$fromId/toId=$toId/type=$type/dayId=$dayId");
  //     if (response.statusCode == 200) {
  //       final model = SearchModel.fromJson(response.data);
  //       print(model.data!.trips);
  //       if (model.data!.trips != []) {
  //         // Get.to(BookShipmentScreen(searchModel: model, date: date,  ));
  //         Get.to(BookShipmentScreen(
  //           searchModel: model,
  //           date: date,
  //           from: from.toString(),
  //           to: to.toString(),
  //         ));
  //       } else {
  //         Get.to(() => BookShipmentScreen(
  //               date: date,
  //               from: from,
  //               to: to,
  //             ));
  //       }
  //       return model.data;
  //     }
  //   } catch (e) {}
  // }

// Future<List<TripModel>> getAllTicket() async {
//   final data = await store.collection("Tickets").get();
//   print("List${data.docs.length}");
//   return data.docs.map((e) => TripModel.fromJson(e)).toList();
// }



  // Future<List<TripModel>> getAllTicket() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   final userId = user?.uid;
  //
  //   final data = await store.collection("Tickets").where("userId", isEqualTo: userId).get();
  //   print("List: ${data.docs.length}");
  //   print("List: ${userId??''}");
  //
  //   return data.docs.map((e) => TripModel.fromJson(e)).toList();
  // }

  Future<List<dynamic>> getAllTicket() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    final data = await store.collection("Tickets").where("userId", isEqualTo: userId).get();
    print("List: ${data.docs.length}");

    return data.docs.map((e) {
      print('docId ${e.id}');
      final isShipping = e.data()['isShipping'] ?? false;
      if (isShipping == false) {
        final tripModel= TripModel.fromJson(e);
        print('docId ${e.id}');
        print('docId ${tripModel.docId}');

        return tripModel;
      } else {
        final ticketModel= TicketModel.fromJson(e);
        print('docId ${ticketModel.docId}');

        return ticketModel;
      }
    }).toList();
  }




  Future search({int? fromId, toId, dayId, String? type,date, from ,to}) async {
    try {
      final response = await dio!.get(
           "${AppConstants.search}/fromId=$fromId/toId=$toId/type=$type/dayId=$dayId");
      if (response.statusCode == 200) {
        print('fromId :::$fromId');
        print('toId :::$toId');
        print('type :::$type');
        print('dayId :::$dayId');
        // Get.to(() => BookShipmentScreen(date: date, from: from, to: to,));
        print('shipment ::: ${response.data}');

        if(type=='shipping') {
           final model = SearchModel.fromJson(response.data);
          print('shipment ::: ${model.data!.trips}');
          if (model.data!.trips != []) {
             Get.to(BookShipmentScreen(searchModel: model,
              date: date,
              from: from.toString(),
              to: to.toString(),));
          } else {
            Get.to(() => BookShipmentScreen(date: date, from: from, to: to,));
          }
           return model.data;
        }else if(type=='trip'){
          final model = SearchModel.fromJson(response.data);
        //   print(' trips::: ${model.data!.trips}');
          if (model.data!.trips != []) {
            // Get.to(BookShipmentScreen(searchModel: model, date: date, from: from, to: to,  ));
            Get.to(BookTripScreen(searchModel: model,
              date: date,
              from: from.toString(),
              to: to.toString(),));
             } else {
            Get.to(() => BookTripScreen(date: date, from: from, to: to,));
            }
          return model.data;
        }
      }
    } catch (e) {}
  }
}
