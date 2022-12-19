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
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketConnect();
  }
  
  Future<void> socketConnect() async {
    log("here");
    try {
      Socket socket = await Socket.connect(
        '172.20.10.8',
        8000,
        timeout: const Duration(seconds: 10)
      );
      log('connected');

      // listen to the received data event stream
      socket.listen((List<int> event) {
        log(utf8.decode(event));
      });

      // send hello
      socket.add(utf8.encode('hello'));
      socket.add(utf8.encode('hello2'));

      // wait 5 seconds
      await Future.delayed(const Duration(seconds: 5));

      // .. and close the socket
      //socket.close();
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
    if (_controller.text.isNotEmpty) {
      
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}