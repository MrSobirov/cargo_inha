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
        //data = String.fromCharCodes(event);
        log("Response data: $data");
      });
      return true;
    } catch(error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      return false;
    }
  }

  Users login(String name, String password) {
    socket!.add(utf8.encode("SELECT JSON_ARRAYAGG(JSON_OBJECT('name', name, 'id', id, 'type', type)) from users where name = $name and password = $password;"));
    data = '[{"id": 1, "name": "Ibrohim driver", "type": "driver"}]';
    return usersFromJson(data)[0];
  }

  List<Users> getDrivers() {
    socket!.add(utf8.encode("SELECT JSON_ARRAYAGG(JSON_OBJECT('name', name, 'id', id, 'type', type)) from users where type = 'driver';"));
    data = '[{"id": 1, "name": "Ibrohim driver", "type": "driver"}]';
    return usersFromJson(data);
  }

  List<Orders> getOrders() {
    socket!.add(utf8.encode("SELECT JSON_ARRAYAGG(JSON_OBJECT('id', id, 'company', company, 'address', address, 'phone', phone, 'date', date, 'status', status, 'driver_id', driver_id, 'distance', distance,)) from orders;"));
    data = '[{"id": 1, "phone": "946590850", "company": "Artel", "driver_id": 1}, {"id": 2, "phone": "946590851", "company": "Akfa", "driver_id": 2}]';
    return ordersFromJson(data);
  }
}