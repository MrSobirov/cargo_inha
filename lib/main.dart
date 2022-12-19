import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
      ),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketConnect();
  }
  
  Future<void> socketConnect() async {
    log("here");
    int counter = 0;
    try {
      socket = await Socket.connect(
        '192.168.192.114',
        8000,
        timeout: const Duration(seconds: 10)
      );
      log('connected');

      // listen to the received data event stream
      socket!.listen((List<int> event) {
        log("${counter++} here");
        log(utf8.decode(event));
      });

      // send hello
      _sendMessage();
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
    if (_controller.text.isEmpty) {
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