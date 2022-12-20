import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  Socket? socket;
  String data = "No data";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketConnect();
  }
  
  Future<void> socketConnect() async {
    log("here");
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
        setState(() {});
      });
    } catch(error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: ((){
              socketConnect();
            }),
            icon: const Icon(Icons.refresh),)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            const Text("Socket")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    String str = _controller.text;
    str = "SELECT JSON_ARRAYAGG(JSON_OBJECT('name', name, 'id', orderID)) from orders";
    if(_controller.text.isEmpty) {
      str = "Connected hello server!!!";
    }
    socket!.add(utf8.encode(str));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}