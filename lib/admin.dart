import 'package:cargo_inha/models.dart';
import 'package:cargo_inha/socket_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class Admin extends StatefulWidget {
  final Users admin;
  const Admin(this.admin, {Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  String? driverName;
  List<Orders> orders = [];
  List<Users> drivers = [];
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    initialize(needDRV: true);
  }

  void initialize({bool needDRV = false}) {
    if(needDRV) {
      drivers = SocketService().getDrivers();
      items.clear();
      log("Driverrrrrrr");
      log(drivers.isEmpty.toString());
      for (var value in drivers) {
        String? a = value.name;
        log(a.toString());
        if(a != null) items.add(a);
      }
    }
    orders = SocketService().getOrders();
    log("here7777");
    setState(() {});
  }

  void connect() {
    SocketService().connect();
    initialize(needDRV: true);
  }

  void addOrder(BuildContext ctx) {
    List<TextEditingController> controllers = [
      for (int i = 0; i < 6; i++)
        TextEditingController()
    ];

    showDialog<void>(
      context: ctx,
      builder: (BuildContext contextDialog) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28))),
          title: Text(
            "Add new order",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18
            ),
          ),
          content: Column(
            children: [
              TTF("Order ID", controllers[0], numeric: true),
              TTF("Company name", controllers[1]),
              TTF("Customer Phone", controllers[2]),
              TTF("Order Date", controllers[3]),
              TTF("Shipping address", controllers[4]),
              TTF("Shipping distance", controllers[5], numeric: true),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(contextDialog).textTheme.labelLarge,),
              child: Text(
                'Cancel',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),
              ),
              onPressed: () async {
                Navigator.pop(contextDialog);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(contextDialog).textTheme.labelLarge,),
              child: Text(
                'Create',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),
              ),
              onPressed: () async {
                Map<String, dynamic> body = {
                  "id": int.parse(controllers[0].text),
                  "company": controllers[1].text,
                  "phone": controllers[2].text,
                  "date": controllers[3].text,
                  "address": controllers[4].text,
                  "distance": int.parse(controllers[5].text),
                  "driver_id": 0,
                  "status": "Pending",
                };
                orders = SocketService().createOrder(body);
                setState(() {});
                Navigator.pop(contextDialog);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.admin.name} dashboard"),
        actions: [
          IconButton(onPressed: initialize, icon: Icon(Icons.update)),
          IconButton(onPressed: connect, icon: Icon(Icons.connected_tv)),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/admin_background.jpg"),
                fit: BoxFit.cover),
          ),
        padding: EdgeInsets.all(16),
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            Orders orderItem = orders[index];
            driverName = drivers.firstWhere((element) => element.id == orderItem.driverId, orElse: () => Users(id: 0, name: null, type: "driver")).name;
            bool blocked = orderItem.status == "block";
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
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
                  Text("Assign"),
                  Container(
                    height: 35,
                    width: 100,
                    margin: EdgeInsets.only(left: 8,bottom: 8),
                    padding: EdgeInsets.only(bottom: 5,left: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: DropdownButton(
                      underline: SizedBox(),
                      value: driverName,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        int newDriverID = drivers.firstWhere((element) => element.name == newValue).id;
                        orders = SocketService().assignDriver(orderItem.id, newDriverID);
                        driverName = newValue!;
                        setState(() {});
                      },
                    ),
                  ),
                  Text("Block"),
                  Container(
                    height: 25,
                    width: 80,
                    child: CupertinoSwitch(
                      value: blocked,
                      activeColor: Colors.green,
                      onChanged: (newVal) {
                        orders = SocketService().blockOrder(orderItem.id, newVal);
                        blocked = newVal;
                        setState(() {});
                      },
                    )
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addOrder(context);
        },
        tooltip: 'Add order',
        child: const Icon(
          Icons.add_task,
          color: Color.fromRGBO(0, 35, 184, 1),
        ),
      ),
    );
  }

  Widget TTF(String hint, TextEditingController ctr, {bool numeric = false}) {
    return Container(
      margin: EdgeInsets.only(left: 8,bottom: 8),
      padding: EdgeInsets.only(bottom: 5,left: 5),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black
          ),
          borderRadius: BorderRadius.circular(5)
      ),
      height: 35,
      width: 300,
      child: TextFormField(
        keyboardType: numeric ? TextInputType.number : TextInputType.name,
        decoration: InputDecoration(
          suffixStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15
          ),
          hintText: hint,
          // contentPadding: EdgeInsets.only(top: 0.1),
          border: InputBorder.none,
        ),
        controller: ctr,
      ),
    );
  }
}
