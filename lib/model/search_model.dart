class SearchModel {
  SearchData? data;
  String? msg;
  bool? status;
  int? statusCode;

  SearchModel({this.data, this.msg, this.status, this.statusCode});

  SearchModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SearchData.fromJson(json['data']) : null;
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

class SearchData {
  int? id;
  String? day;
  String ?createdAt;
  String? updatedAt;
  List<Trips>? trips;

  SearchData({this.id, this.day, this.createdAt, this.updatedAt, this.trips});

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['trips'] != null) {
      trips = <Trips>[];
      json['trips'].forEach((v) {
        trips!.add(new Trips.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.trips != null) {
      data['trips'] = this.trips!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Trips {
  int? fromId;
  int? toId;
  int? tripId;
  String? time;
  int? price;
  int? duration;
  int? agencyId;
  Pivot? pivot;
  From? from;
  From? to;
  Agency? agency;

  Trips(
      {this.fromId,
        this.toId,
        this.tripId,
        this.time,
        this.price,
        this.duration,
        this.agencyId,
        this.pivot,
        this.from,
        this.to,
        this.agency});

  Trips.fromJson(Map<String, dynamic> json) {
    fromId = json['from_id'];
    toId = json['to_id'];
    tripId = json['trip_id'];
    time = json['time'];
    price = json['price'];
    duration = json['duration'];
    agencyId = json['agency_id'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    to = json['to'] != null ? new From.fromJson(json['to']) : null;
    agency =
    json['agency'] != null ? new Agency.fromJson(json['agency']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_id'] = this.fromId;
    data['to_id'] = this.toId;
    data['trip_id'] = this.tripId;
    data['time'] = this.time;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['agency_id'] = this.agencyId;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to!.toJson();
    }
    if (this.agency != null) {
      data['agency'] = this.agency!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? dayId;
  int? tripId;
  int? id;

  Pivot({this.dayId, this.tripId, this.id});

  Pivot.fromJson(Map<String, dynamic> json) {
    dayId = json['day_id'];
    tripId = json['trip_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day_id'] = this.dayId;
    data['trip_id'] = this.tripId;
    data['id'] = this.id;
    return data;
  }
}

class From {
  String? city;
  int? id;

  From({this.city, this.id});

  From.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['id'] = this.id;
    return data;
  }
}

class Agency {
  int? id;
  String? agencyName;
  String? email;
  String? phone;
  Null? photo;
  String? deviceToken;
  ShippingPrices? shippingPrices;
  int? active;
  String? address;
  double? lat;
  double? lng;

  Agency(
      {this.id,
        this.agencyName,
        this.email,
        this.phone,
        this.photo,
        this.deviceToken,
        this.shippingPrices,
        this.active,
        this.address,
        this.lat,
        this.lng});

  Agency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agencyName = json['agency_name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    deviceToken = json['device_token'];
    shippingPrices = json['shipping_prices'] != null
        ? new ShippingPrices.fromJson(json['shipping_prices'])
        : null;
    active = json['active'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['agency_name'] = this.agencyName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    data['device_token'] = this.deviceToken;
    if (this.shippingPrices != null) {
      data['shipping_prices'] = this.shippingPrices!.toJson();
    }
    data['active'] = this.active;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class ShippingPrices {
  String? initialWeight;
  String? initialPrice;
  String? additionalPrice;

  ShippingPrices({this.initialWeight, this.initialPrice, this.additionalPrice});

  ShippingPrices.fromJson(Map<String, dynamic> json) {
    initialWeight = json['initial_weight'];
    initialPrice = json['initial_price'];
    additionalPrice = json['additional_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['initial_weight'] = this.initialWeight;
    data['initial_price'] = this.initialPrice;
    data['additional_price'] = this.additionalPrice;
    return data;
  }
}
