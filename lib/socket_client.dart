import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cargo_inha/models.dart';

class SocketService {
  static Socket? socket;
  static String data = "";

  Future<bool> connect() async {
    try {
      log("started");
      socket = await Socket.connect(
          '192.168.192.114',
          8000,
          timeout: const Duration(seconds: 10)
      );
      log('connected');

      // listen to the received data event stream
      socket!.listen((List<int> event) {
        log("Result is empty: ${event.isEmpty}");
        data = String.fromCharCodes(event);
        log("Response data: $data");
      });
      return true;
    } catch(error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      return false;
    }
  }

  Users? login(String name, String password, String type) {
    socket!.add(utf8.encode("SELECT JSON_ARRAYAGG(JSON_OBJECT('name', name, 'id', id, 'type', type)) from users where name = $name and password = $password and type = $type;"));
    try{
      return usersFromJson(data)[0];
    } catch(error) {
      return null;
    }
  }

  List<Users> getDrivers() {
    socket!.add(utf8.encode("SELECT JSON_ARRAYAGG(JSON_OBJECT('name', name, 'id', id, 'type', type)) from users where type = 'driver';"));
    try {
      return usersFromJson(data);
    } catch(error) {
      return [];
    }
  }

  List<Orders> getOrders() {
    socket!.add(utf8.encode("SELECT JSON_ARRAYAGG(JSON_OBJECT('id', id, 'company', company, 'address', address, 'phone', phone, 'date', date, 'status', status, 'driver_id', driver_id, 'distance', distance,)) from orders;"));
    try {
      return ordersFromJson(data);
    } catch(error) {
      return [];
    }
  }

  List<Orders> createOrder(Map<String, dynamic> body) {
    String values = '${body["id"]}, ${body["company"]}, ${body["address"]}, ${body["phone"]}, ${body["date"]}, ${body["status"]}, ${body["distance"]}, ${body["driver_id"]};';
    socket!.add(utf8.encode("INSERT INTO orders VALUES ($values);"));
    return getOrders();
  }

  List<Orders> assignDriver(int id, int driverID) {
    socket!.add(utf8.encode("UPDATE orders set driver_id = $driverID where id = $id;"));
    return getOrders();
  }

  List<Orders> blockOrder(int id, bool blocked) {
    socket!.add(utf8.encode("UPDATE orders set status = ${blocked ? "block" : "pending"} where id = $id;"));
    return getOrders();
  }

  List<Orders> changeStatus(int id, String currentStatus) {
    Map<String, String> statuses = {
      "Pending": "Accepted",
      "Accepted": "On the way",
      "On the way": "Finished",
    };
    String newStatus = statuses[currentStatus] ?? 'NULL';
    socket!.add(utf8.encode("UPDATE orders set status = $newStatus where id = $id;"));
    return getOrders();
  }
}