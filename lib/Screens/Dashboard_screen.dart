import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:super_app/Screens/Privacypolicy_page.dart';
import 'package:super_app/Screens/Seal_verify.dart';
import 'package:super_app/universal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_app/Screens/Login_screen.dart';
import 'Change_password.dart';
import 'GateTransit.dart';
import 'ILEContainer_search.dart';
import 'ILEContainersearch_Date.dart';
import 'Rake_survey.dart';
import 'Temp_Monitoring.dart';
import 'Typeaheadsearchdata.dart';
import 'Warehouse_activity.dart';
import 'package:image_picker/image_picker.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  File? imageFile;
  final picker = ImagePicker();

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          // ignore: deprecated_member_use
           ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          // ignore: deprecated_member_use
          ElevatedButton(
            onPressed: () => exit(0),
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("e-Operation Management"),
          backgroundColor: Color(0xFF184f8d),
        ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(Globaldata.DisplayName,style: TextStyle(fontSize: 18.0,color: Colors.white),),
                  accountEmail: const Text(""),
                  currentAccountPicture: InkWell(
                    onTap: (){
                      //_showDialog();
                      },
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1))
                          ],shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                              image: NetworkImage("https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png"),)

                        )
                    )
                      ]
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF184f8d)
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(color: Colors.blue )),
                  elevation: 4.0,
                  child: ExpansionTile(
                      title: const Text("History",style: TextStyle(fontSize: 15.0,color: Colors.black),),
                  children: [
                    ListTile(
                      dense: true,
                      leading: const Icon(Icons.search,size: 25.0,color: Colors.black),
                      title: const Text("Based On Container",style: TextStyle(fontSize: 14.0,color: Colors.black),),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Containersearch()));
                      },
                    ),
                    ListTile(
                      dense: true,
                      leading: const Icon(Icons.search,size: 25.0,color: Colors.black),
                      title: const Text("Based On Date",style: TextStyle(fontSize: 14.0,color: Colors.black),),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Containerdatesearch()));
                      },
                    ),
                  ],
                  )
                ),
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.blue )),
                  child: ListTile(
                    dense: true,
                      leading: const Icon(FontAwesomeIcons.lock,color: Colors.black,),
                      title: const Text(
                        'Change Password',
                        style: const TextStyle(fontSize: 15.0),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Changemypassword()));
                      }),
                ),
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.blue )),
                  child: ListTile(
                    dense: true,
                      leading: const Icon(Icons.security_rounded,color: Colors.black,),
                      title: const Text(
                        'Privacy Policy',
                        style: const TextStyle(fontSize: 15.0),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Privacyscreen()));
                      }),
                ),
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.blue )),
                  child: ListTile(
                    dense: true,
                      leading: const Icon(Icons.exit_to_app,color: Colors.black,),
                      title: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      onTap: () async {
                        SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                        await preferences.clear();
                        //Navigator.of(context).pop();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => LoginScreen()));
                      }),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: GridView.count(
                    primary: false,
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: [
                      Card(
                  margin: const EdgeInsets.all(10.0),
              elevation: 10.0,
              shadowColor: Colors.blueAccent,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.red,width: 1)
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Shippingcontainer()));
                },
                splashColor: Colors.green,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'images/sealnew.png',
                        height: 60,
                        width: 60,
                      ),
                      const Text(
                        'Imp-Rail-Seal',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
                      Card(
                        margin: const EdgeInsets.all(10.0),
                        elevation: 10.0,
                        shadowColor: Colors.blueAccent,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: Colors.red,width: 1)
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Tempmonitor()));
                          },
                          splashColor: Colors.green,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'images/rffertemp.png',
                                  height: 60,
                                  width: 60,
                                ),
                                const Text(
                                  'Temp. Monitoring',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.all(10.0),
                        elevation: 10.0,
                        shadowColor: Colors.blueAccent,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: Colors.red,width: 1)
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  AutoComplete()));
                          },
                          splashColor: Colors.green,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'images/sealnew.png',
                                  height: 60,
                                  width: 60,
                                ),
                                const Text(
                                  'InYard-Seal Verification',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.all(10.0),
                        elevation: 10.0,
                        shadowColor: Colors.blueAccent,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: Colors.red,width: 1)
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Rakesurvey()));
                          },
                          splashColor: Colors.green,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'images/rake.png',
                                  height: 60,
                                  width: 60,
                                ),
                                const Text(
                                  'e-Rake Survey',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.all(10.0),
                        elevation: 10.0,
                        shadowColor: Colors.blueAccent,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: Colors.red,width: 1)
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Warehouse()));
                          },
                          splashColor: Colors.green,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'images/warehouse.png',
                                  height: 50,
                                  width: 50,
                                ),
                                const Text(
                                  'Warehouse Activity',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
  Future<void> _showDialog() {
    // ignore: missing_return
    return showDialog(
        context: this.context,
        builder: (BuildContext) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(10.0),
              shape: Border.all(color: Colors.red, width: 2),
              title: Text(
                'Select Image',
              ),
              content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      GestureDetector(
                        child: Text('Gallery', style: TextStyle(fontSize: 20.0)),
                        onTap: () {
                          openGallery();
                          setState(() {});
                          Navigator.of(this.context).pop(false);
                        },
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      GestureDetector(
                        child: Text('Camera', style: TextStyle(fontSize: 20.0)),
                        onTap: () {
                          openCamera();
                          setState(() {});
                          Navigator.of(this.context).pop(false);
                        },
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:MaterialStateProperty.all(Color(0xFF184f8d)),
                                ),
                                onPressed: () {
                                  Navigator.of(this.context).pop(false);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ))
                        ],
                      )
                    ],
                  )));
        });
  }

  Future<void> openGallery() async {
    var pickedFile =
    (await picker.pickImage(source: ImageSource.gallery, imageQuality: 25));
    setState(() {
      imageFile = File(pickedFile!.path);
    });
    print("ABCD");
    print(imageFile);
  }
  Future<void> openCamera() async {
    var pickedFile =
    (await picker.pickImage(source: ImageSource.gallery, imageQuality: 25));
    setState(() {
      imageFile = File(pickedFile!.path);
    });
    print("ABCD");
    print(imageFile);
  }
}
