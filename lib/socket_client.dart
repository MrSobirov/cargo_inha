import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cargo_inha/models.dart';

class SocketService {
  static Socket? socket;
  static String data = "";

  Future<bool> connect() async {
    try {
      socket = await Socket.connect(
          '192.168.192.114',
          8000,
          timeout: const Duration(seconds: 10)
      );
      log('connected');

      // listen to the received data event stream
      socket!.listen((List<int> event) {
        log("Result here: ${event.isEmpty}");
        log(event.toString());
        final List<int> charCodes = event;
        log(charCodes.toString());
        data = String.fromCharCodes(charCodes);
        log("Data $data");
      });
      return true;
    } catch(error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      return false;
    }
  }

  Users login(String name, String password) {
    socket!.add(utf8.encode("SELECT JSON_ARRAYAGG(JSON_OBJECT('name', name, 'id', id, 'type', type)) from users where name = $name and password = $password"));
    return usersFromJson(data)[0];
  }
}