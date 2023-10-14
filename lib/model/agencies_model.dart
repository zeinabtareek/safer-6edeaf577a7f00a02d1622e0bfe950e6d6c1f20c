class AgenciesModel {
  AgenciesModel({
      this.data, 
      this.msg, 
      this.status, 
      this.statusCode,});

  AgenciesModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
    statusCode = json['statusCode'];
  }
  List<Data>? data;
  String? msg;
  bool? status;
  int? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    map['status'] = status;
    map['statusCode'] = statusCode;
    return map;
  }

}

class Data {
  Data({
      this.agencyName, 
      this.email, 
      this.phone, 
      this.photo, 
      this.address, 
      this.lat, 
      this.lng, 
      this.deviceToken,});

  Data.fromJson(dynamic json) {
    agencyName = json['agency_name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    deviceToken = json['device_token'];
  }
  String? agencyName;
  String? email;
  String? phone;
  dynamic photo;
  dynamic address;
  dynamic lat;
  dynamic lng;
  dynamic deviceToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['agency_name'] = agencyName;
    map['email'] = email;
    map['phone'] = phone;
    map['photo'] = photo;
    map['address'] = address;
    map['lat'] = lat;
    map['lng'] = lng;
    map['device_token'] = deviceToken;
    return map;
  }

}