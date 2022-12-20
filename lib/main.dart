import 'package:cargo_inha/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Login()
    );
  }
}