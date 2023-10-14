import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesModel {
  final String? message;
  final String? id;
  final String? sentDate;

  MessagesModel({this.message, this.id, this.sentDate});

  factory MessagesModel.fromJSON(DocumentSnapshot snapshot) {
    return MessagesModel(
        id: snapshot["id"],
        message: snapshot["message"],
       );
  }
}
