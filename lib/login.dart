import 'package:cargo_inha/driver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
int tabTextIndexSelected = 0;
final TextEditingController phone = TextEditingController();
final TextEditingController name = TextEditingController();
final TextEditingController surname = TextEditingController();
class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/trico-home.jpg"),
                fit: BoxFit.cover),
          ),
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 300,),
                FlutterToggleTab(
                  unSelectedBackgroundColors: [
                    Color.fromRGBO(245, 245, 245, 1)],

                  marginSelected: EdgeInsets.all(5),
                  width: 40,
                  borderRadius: 30,
                  height: 54,
                  selectedIndex: tabTextIndexSelected,
                  selectedBackgroundColors: [Colors.deepOrangeAccent,],
                  selectedTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  unSelectedTextStyle: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                  labels: ['Driver','Admin'],
                  selectedLabelIndex: (index) {
                    setState(() {
                      tabTextIndexSelected = index;
                    });
                  },
                  isScroll: true,
                ),

                  Container(
                    width: 358,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color : Colors.black),
                    ),
                    margin: EdgeInsets.only(top : 50 ,bottom: 16),
                    padding: EdgeInsets.only(left: 16,),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              suffixStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              ),
                              hintText: 'Email',
                              // contentPadding: EdgeInsets.only(top: 0.1),
                              border: InputBorder.none,
                            ),
                            controller: name,
                          ),
                        ),
                      ],
                    ),
                  ),

                Container(
                  width: 358,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color : Colors.black),
                  ),
                  margin: EdgeInsets.only(bottom:  50),
                  padding: EdgeInsets.only(left: 16,),
                  child: Row(
                    children: [
                      Text(
                        "+998 | ",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            suffixStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15
                            ),
                            hintText: 'Phone',
                            // contentPadding: EdgeInsets.only(top: 0.1),
                            border: InputBorder.none,
                          ),
                          controller: phone,
                        ),
                      ),

                    ],
                  ),

                ),
                Container(
                  height: 46,
                  width: 358,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color.fromRGBO(0, 35, 184, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                    ),
                    onPressed: ()  {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Driver()));

                    },
                    child:  Text('Login', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                  ),
                ),


              ],
            ),
          ),
        ),
      )
    );
  }
}
