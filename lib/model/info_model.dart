class InfoModel {
  InfoData? data;
  String? msg;
  bool? status;
  int? statusCode;

  InfoModel({this.data, this.msg, this.status, this.statusCode});

  InfoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new InfoData.fromJson(json['data']) : null;
    msg = json['msg'];
    status = json['status'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = this.msg;
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class InfoData {
  int? id;
  String? email;
  String? phone;
  String?createdAt;
  String?updatedAt;

  InfoData({this.id, this.email, this.phone, this.createdAt, this.updatedAt});

  InfoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
