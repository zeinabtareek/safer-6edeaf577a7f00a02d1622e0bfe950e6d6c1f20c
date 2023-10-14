import 'package:cloud_firestore/cloud_firestore.dart';

class TicketModel {
  String? arrivalDate;
  String? docId; // Add the docId field

  int? agencyId;
  String? arrivalTime;
  String? from;
  String? height;
  String? id;
  bool? isAccepted;
  bool? isShipping;
  bool? isPaid;
  String? to;
  String? length;
  String? movingDate;
  String? movingTime;
  String? userId;
  String? price;
  String? shipmentNum;
  String? weight;
  String? width;
  String? payRef;
  int? pivotId;
  int? duration;

  bool? isRejected;
  Timestamp ?lastUpdate;
   TicketModel({
    this.arrivalDate,
    this.agencyId,
    this.arrivalTime,
    this.lastUpdate,
    this.from,
    this.height,
    this.isRejected,
    this.docId,
    this.id,
    this.isAccepted,
    this.isShipping,
    this.isPaid,
    this.to,
    this.length,
    this.movingDate,
    this.movingTime,
    this.userId,
    this.price,
    this.shipmentNum,

    this.weight,
    this.width,
    this.payRef,
    this.pivotId,
    this.duration,
  });

  factory TicketModel.fromJson(DocumentSnapshot json) {
    final data = json.data();

    return TicketModel(
      docId: json.id, // Set the docId field from the document ID

      isRejected: json['isRejected'],
      arrivalDate: json['arrivalDate'],
      lastUpdate: json['lastUpdate'],
      arrivalTime: json['arrivalTime'],
      from: json['from'],
      height: json['height'],
      id: json['id'],
      payRef: json['payRef'],
      pivotId: json['pivotId'],
      agencyId: json['agencyId'],

      isAccepted: json['isAccepted'],
      isShipping: json['isShipping'],
      isPaid: json['isPaid'],
      to: json['to'],
      length: json['length'],
      movingDate: json['movingDate'],
      movingTime: json['movingTime'],
      userId: json['userId'],
      price: json['price'],
      duration: json['duration'],
      shipmentNum: json['shipmentNum'],
      weight: json['weight'],
      width: json['width'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'arrivalDate': arrivalDate,
      'arrivalTime': arrivalTime,
      'from': from,
      'height': height,
      'id': id,
      'lastUpdate': lastUpdate,
      'isRejected': isRejected,
      'isAccepted': isAccepted,
      'isShipping': isShipping,
      'isPaid': isPaid,
      'agencyId': agencyId,
      'to': to,
      'payRef': payRef,
      'pivotId': pivotId,
      'length': length,
      'movingDate': movingDate,
      'movingTime': movingTime,
      'userId': userId,
      'price': price,
      'shipmentNum': shipmentNum,
      'weight': weight,
      'duration': duration,
      'width': width,
    };
  }
}