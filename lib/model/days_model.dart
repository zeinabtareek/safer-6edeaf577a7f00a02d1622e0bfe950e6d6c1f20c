class DaysModel {
  List<DayData>? data;
  String? msg;
  bool? status;
  int? statusCode;

  DaysModel({this.data, this.msg, this.status, this.statusCode});

  DaysModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DayData>[];
      json['data'].forEach((v) {
        data!.add(new DayData.fromJson(v));
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

class DayData {
  int? id;
  String? day;
  String? createdAt;
  String? updatedAt;

  DayData({this.id, this.day, this.createdAt, this.updatedAt});

  DayData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
