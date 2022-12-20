import 'package:cargo_inha/socket_client.dart';
import 'package:flutter/material.dart';

import 'models.dart';
class Driver extends StatefulWidget {
  const Driver({Key? key}) : super(key: key);

  @override
  State<Driver> createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  List<Orders> orders = [];
  Map<String, String> statuses = {
    "Pending": "Accepted",
    "Accepted": "On the way",
    "On the way": "Finished",
  };

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    orders = SocketService().getOrders();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver dashboard"),
        actions: [
          IconButton(onPressed: initialize, icon: Icon(Icons.update))
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/admin_background.jpg"),
                fit: BoxFit.cover),
          ),
          height: double.infinity,
          padding: EdgeInsets.all(16),
          child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (Context , index ) {
                Orders orderItem = orders[index];
                return Row(
                  children: [
                    DataTable(
                      columns: [
                        DataColumn(label: Text("ID")),
                        DataColumn(label: Text("Company name")),
                        DataColumn(label: Text("Phone number")),
                        DataColumn(label: Text("Date")),
                        DataColumn(label: Text("Address")),
                        DataColumn(label: Text("Distance")),
                        DataColumn(label: Text("Status")),
                      ],
                      rows: [
                        DataRow(
                            selected: true,
                            cells: [
                              DataCell(Text(orderItem.id.toString())),
                              DataCell(Text(orderItem.company)),
                              DataCell(Text(orderItem.phone)),
                              DataCell(Text(orderItem.date)),
                              DataCell(Text(orderItem.address)),
                              DataCell(Text(orderItem.distance.toString())),
                              DataCell(Text(orderItem.status)),
                            ],
                        ),
                      ],
                    ),
                    Container(
                      height: 25,
                      width: 80,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                        onPressed: orderItem.status == "Finished" ? null : () {
                          orders = SocketService().changeStatus(orderItem.id, orderItem.status);
                          setState(() {});
                        },
                        child: Text(statuses[orderItem.status] ?? "Unknown"),
                      ),
                    )
                  ],
                );
              },
          )
      ),
    );
  }
}
