import 'dart:convert';

List<Users> welcomeFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String welcomeToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    required this.id,
    required this.name,
    required this.type,
  });

  int id;
  String name;
  String type;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
  };
}

List<Orders> ordersFromJson(String str) => List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
  Orders({
    required this.id,
    required this.address,
    required this.phone,
    required this.date,
    required this.status,
    required this.distance,
    required this.company,
    required this.driverId,
  });

  int id;
  String address;
  String phone;
  String date;
  String status;
  int distance;
  String company;
  int driverId;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    id: json["id"],
    address: json["address"],
    phone: json["phone"],
    date: json["date"],
    status: json["status"],
    distance: json["distance"],
    company: json["company"],
    driverId: json["driver_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "phone": phone,
    "date": date,
    "status": status,
    "distance": distance,
    "company": company,
    "driver_id": driverId,
  };
}
