  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled3/model/ticket_model.dart';

import '../model/trip_model.dart';

class TicketServices{

  addTripToFirestore(TripModel trip, ) async {
    try {
      final tripRef = FirebaseFirestore.instance.collection('Tickets').doc();
      await tripRef.set(trip.toJson());
      print('Trip added to Firestore');
      return tripRef.id;
    } catch (e) {
      print('Error adding trip to Firestore: $e');
      return null; // Return null if there was an error
    }
  }


  addTicketToFirestore(TicketModel ticket, ) async {
    try {
      final tripRef = FirebaseFirestore.instance.collection('Tickets').doc();
      await tripRef.set(ticket.toJson());
      print('Ticket added to Firestore');
      return tripRef.id;
    } catch (e) {
      print('Error adding Ticket to Firestore: $e');
      return null; // Return null if there was an error
    }
  }


}