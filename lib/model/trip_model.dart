import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel { //19
  int? agencyId;
  int? pivotId;
  int? quantity;
  int? duration;
  String? docId;
  String? arrivalDate;
  String? arrivalTime;
  String? from;
  String? to;
  String? price;
  String? id;
  bool? isAccepted;
  bool? isShipping;
  bool? isPaid;
  String? movingDate;
  // Pivot? pivot;
  String? payRef;
  String? userId;
  String? movingTime;
  List<Trip>? ticketList;

  TripModel({
    this.agencyId,
    this.quantity,
    this.arrivalDate,
    this.arrivalTime,
    this.from,
    this.to,
    this.price,
    this.id,
    this.payRef,
    this.isAccepted,
    this.isShipping,
    this.isPaid,
    this.movingDate,
    this.movingTime,
    this.duration,
    this.docId,
    this.userId,
    this.pivotId,
    this.ticketList,
  });

  factory TripModel.fromJson(DocumentSnapshot json) {
    final data = json.data();

    return TripModel(

       docId: json.id, // Set the docId field from the document ID
      quantity: json['quantity'],
      arrivalDate: json['arrivalDate'],
      arrivalTime: json['arrivalTime'],
      agencyId: json['agencyId'],
      from: json['from'],
      to: json['to'],
      price: json['price'],
      payRef: json['payRef'],
      id: json['id'],
      isAccepted: json['isAccepted'],
      isShipping: json['isShipping'],
      isPaid: json['isPaid'],
      movingDate: json['movingDate'],
      movingTime: json['movingTime'],
      userId: json['userId'],
      pivotId: json['pivotId'],
      duration: json['duration'],
      // weight: json['weight'],
      ticketList: (json['ticketList'] as List<dynamic>?)
          ?.map((ticketJson) => Trip.fromJson(ticketJson))
          .toList(),
    );
  }

    toJson() {
    return {
      'agencyId': agencyId,
      'quantity': quantity,
      'arrivalDate': arrivalDate,
      'arrivalTime': arrivalTime,
      'from': from,
      'to': to,
      'price': price,
      'payRef': payRef,
      'pivotId': pivotId,
      'id': id,
      'isAccepted': isAccepted,
      'duration': duration,
      'isShipping': isShipping,
      'isPaid': isPaid,
      'movingDate': movingDate,
      'movingTime': movingTime,
      'userId': userId,
      'ticketList': ticketList?.map((ticket) => ticket.toJson()).toList(),
    };
  }
}

class Trip {
  String? seatNum;
  String? ticketNum;

  Trip({
    this.seatNum,
    this.ticketNum,
  });

  factory Trip.fromJson(  json) {
    return Trip(
      seatNum: json['seatNum'],
      ticketNum: json['ticketNum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seatNum': seatNum,
      'ticketNum': ticketNum,
    };
  }
}

