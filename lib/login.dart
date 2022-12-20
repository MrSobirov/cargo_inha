import 'package:cargo_inha/admin.dart';
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

bool openingDemoStore(BuildContext ctx) {
  bool needDemo = false;
  showDialog<void>(
    context: ctx,
    builder: (BuildContext contextDialog) {
      return WillPopScope(
        onWillPop: () async {
          Navigator.push;
          return false;
        },
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28))),
          title: Text(
            "Login error !",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18
            ),
          ),
          content: Text(
            "Email or password was incorrect\nPlease try again !.",
            //textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 15
            ),
          ),
          actions: <Widget>[
            /*TextButton(
                style: TextButton.styleFrom(textStyle: Theme.of(contextDialog).textTheme.labelLarge,),
                child: Text(
                  'Check demo',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: MyColors.primary
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(contextDialog);
                  needDemo = true;
                },
              ),*/
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(contextDialog).textTheme.labelLarge,),
              child: Text(
                'OK',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent
                ),
              ),
              onPressed: () {
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      );
    },
  );
  return needDemo;
}
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
                  labels: ['Admin','Driver'],
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
                      /*if(tabTextIndexSelected == 1 ) {
                        if(name.text == "Muhammadsaid" && phone.text == "993466246"){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => Driver()));
                        }
                        else {
                          openingDemoStore(context);
                        }
                      }
                      else {
                        if(name.text == "Muhammadsaid" && phone.text == "993466246") {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => Admin()));
                        }
                        else {
                          openingDemoStore(context);
                        }

                      }*/

                      Navigator.push(context, MaterialPageRoute(builder: (_) => Admin()));
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
