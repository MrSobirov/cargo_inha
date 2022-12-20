import 'package:flutter/material.dart';
class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}
String? dropdownValue;
List<String> items =[
  "Sekn", "Ultr"
];

List<Map> users = [];

int count = 0;
class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {

    List<Map> orders = List<Map>.filled(count, {
     "name" : TextEditingController(),
      "phone" :TextEditingController(),
      "date" : TextEditingController(),
    });

    print(orders);
    return Scaffold(
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
          itemCount: count,
            itemBuilder: (context , index) {
              return Row(
                children: [
                  Container(
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
                      decoration: InputDecoration(
                        suffixStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                        ),
                        hintText: 'Name',
                        // contentPadding: EdgeInsets.only(top: 0.1),
                        border: InputBorder.none,
                      ),
                      controller: orders[index]["name"],
                    ),
                  ),
                  Container(
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
                      decoration: InputDecoration(
                        suffixStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                        ),
                        hintText: 'Phone number',
                        // contentPadding: EdgeInsets.only(top: 0.1),
                        border: InputBorder.none,
                      ),
                      controller: orders[index]["phone"],
                    ),
                  ),
                  Container(
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
                      decoration: InputDecoration(
                        suffixStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                        ),
                        hintText: 'Date',
                        // contentPadding: EdgeInsets.only(top: 0.1),
                        border: InputBorder.none,
                      ),
                      controller: orders[index]["date"],
                    ),
                  ),
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
                      // Initial Value
                      value: dropdownValue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 150,
                    margin: EdgeInsets.only(left: 8,bottom: 8),
                    padding: EdgeInsets.only(bottom: 5,left: 5),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 35, 184, 1),
                        border: Border.all(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Center(
                      child: Text("Send",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.white
                      ),),
                    ),
                  )
                ],
              );
            })
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ((){
          setState(() {
            count++;
          });
        }),
        tooltip: 'Add order',
        child: const Icon(
          Icons.add_task,
          color: Color.fromRGBO(0, 35, 184, 1),
        ),
      ),
    );
  }
}
