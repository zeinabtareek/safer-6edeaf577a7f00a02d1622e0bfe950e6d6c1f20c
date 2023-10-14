class CitiesModel {
  List<CityData>? data;
  String? msg;
  bool? status;
  int? statusCode;

  CitiesModel({this.data, this.msg, this.status, this.statusCode});

  CitiesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CityData>[];
      json['data'].forEach((v) {
        data!.add(new CityData.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class CityData {
  int? id; //for extra knowladge
  String? city;
  String? createdAt;
  String? updatedAt;

  CityData({this.id, this.city, this.createdAt, this.updatedAt});

  CityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.city;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
