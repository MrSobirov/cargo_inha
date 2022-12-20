import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

List<Orders> ordersFromJson(String str) => List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

class Users {
  Users({
    required this.id,
    required this.name,
    required this.type,
  });

  int id;
  String? name;
  String type;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    name: json["name"],
    type: json["type"],
  );
}

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
}
