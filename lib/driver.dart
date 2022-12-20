import 'package:flutter/material.dart';

import 'models.dart';
class Driver extends StatefulWidget {
  const Driver({Key? key}) : super(key: key);

  @override
  State<Driver> createState() => _DriverState();
}
List<bool> selectedSe = [
  false,false,false,false,false,false
];
List<Orders> orders = [];
class _DriverState extends State<Driver> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  Widget build(BuildContext context) {
    return  Scaffold(
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
                return Row(
                  children: [
                    DataTable(

                      columns: [
                        DataColumn(label: Text("Address"),),
                        DataColumn(label: Text("Company name"),),
                        DataColumn(label: Text("Distance"),),
                        DataColumn(label: Text("Phone number"),),
                        DataColumn(label: Text("Date"),),
                        DataColumn(label: Text("Status"),),
                      ],

                      rows: [
                        DataRow(
                            selected: true,
                            cells: [
                              DataCell(Text(orders[index].address)),
                              DataCell(Text(orders[index].company)),
                              DataCell(Text(orders[index].distance.toString())),
                              DataCell(Text(orders[index].phone)),
                              DataCell(Text(orders[index].date)),
                              DataCell(Text(orders[index].status)),

                            ]),
                      ],
                    ),
                    Container(
                      height: 25,
                      width: 80,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  selectedSe[index] ? Colors.green[600] : Colors.red,
                        ),

                        onPressed: ((){
                          setState(() {
                            selectedSe[index] =! selectedSe[index];
                          });
                        }),
                        child: Text(selectedSe[index] ? "Accept" : "Decline"),
                      ),
                    )
                  ],
                );
              })
      ),
    );
  }
}
