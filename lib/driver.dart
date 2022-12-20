import 'package:flutter/material.dart';
class Driver extends StatefulWidget {
  const Driver({Key? key}) : super(key: key);

  @override
  State<Driver> createState() => _DriverState();
}
List<bool> selectedSe = [
  false,false,false,false,false,false
];
class _DriverState extends State<Driver> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = [
      {
        "name" : "Muhammadsaid",
        "phone" : "+998993466246",
        "date" : "14.10.2022"
      },
      {
        "name" : "Ibrohim",
        "phone" : "+998993466246",
        "date" : "25.09.2022"
      },
      {
        "name" : "Saidafzal",
        "phone" : "+998993466246",
        "date" : "12.12.2022"
      },
      {
        "name" : "Ibrohim",
        "phone" : "+998993466246",
        "date" : "11.12.2022"
      },
      {
        "name" : "Abror",
        "phone" : "+998993466246",
        "date" : "17.04.2022"
      },
      {
        "name" : "Umar",
        "phone" : "+998993466246",
        "date" : "16.03.2022"
      },
    ];
    String status = "Choose status";
    return  Scaffold(
      body: Container(
          height: 500,
          padding: EdgeInsets.all(16),
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (Context , index ) {
                return DataTable(

                  columns: [
                    DataColumn(label: Text('Receiver Name'),),
                    DataColumn(label: Text('Receiver phone number'),),
                    DataColumn(label: Text('Date'),),
                    DataColumn(label: Text('Status'),),
                  ],

                  rows: [
                    DataRow(
                        selected: true,
                        cells: [
                          DataCell(Text('Muhammadsaid')),
                          DataCell(Text('+998993466246')),
                          DataCell(Text('27.12.2022')),
                          DataCell(
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
                                      if(selectedSe[index]){
                                        status = "Accept";
                                      }
                                      else{
                                        status = "Decline";
                                      }
                                    });
                                  }),
                                  child: Text(selectedSe[index] ? "Accept" : "Decline"),
                                ),
                              ))
                        ]),
                  ],
                );
              })
      ),
    );
  }
}
