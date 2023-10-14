class FirebaseUserModel {
  String? email;
  String? name;
  String? userId;
  String? nationalId;
  String? nationalIdBack;
  String? nationalIdFront;
  String? phone;

  FirebaseUserModel(
      {this.email,
        this.name,
        this.userId,
        this.nationalId,
        this.nationalIdBack,
        this.nationalIdFront,
        this.phone});

  FirebaseUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    userId = json['userId'];
    nationalId = json['nationalId'];
    nationalIdBack = json['nationalIdBack'];
    nationalIdFront = json['nationalIdFront'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['userId'] = this.userId;
    data['nationalId'] = this.nationalId;
    data['nationalIdBack'] = this.nationalIdBack;
    data['nationalIdFront'] = this.nationalIdFront;
    data['phone'] = this.phone;
    return data;
  }
}
