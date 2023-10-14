import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? deviceToken;
  String? phone;
  String? id;
  String? name;
  String? nationalID;
  String? nationalIdBack;
  String? nationalIdFront;
  String? email;

  UserModel({
    this.deviceToken,
    this.phone,
    this.id,
    this.name,
    this.nationalID,
    this.nationalIdBack,
    this.nationalIdFront,
    this.email,
  });

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    return UserModel(
      deviceToken: json['deviceToken'],
      phone: json['phone'],
      id: json['id'],
      name: json['name'],
      nationalID: json['nationalID'],
      nationalIdBack: json['nationalIdBack'],
      nationalIdFront: json['nationalIdFront'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceToken': deviceToken,
      'phone': phone,
      'id': id,
      'name': name,
      'nationalID': nationalID,
      'nationalIdBack': nationalIdBack,
      'nationalIdFront': nationalIdFront,
      'email': email,
    };
  }
}