import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:super_app/Screens/Examination_Container.dart';
import 'package:super_app/Screens/Privacypolicy_page.dart';
import 'package:super_app/Screens/RakeStatus_Screen.dart';
import 'package:super_app/universal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_app/Screens/Login_screen.dart';
import '../Services/FoisController.dart';
import 'Change_password.dart';
import 'GateTransit.dart';
import 'ILEContainer_search.dart';
import 'Rake_search.dart';
import 'Rake_survey.dart';
import 'Temp_Monitoring.dart';
import 'Warehouse_activity.dart';
import 'package:image_picker/image_picker.dart';
import 'Weighment_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final RakestatusController statusdata = Get.put((RakestatusController()));
  final detailRakestatusController detailrakestatusdata = Get.put((detailRakestatusController()));
  File? imageFile;
  final picker = ImagePicker();

  Future<bool> _onWillPop() async {
    return (
        await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert'),
        content: const Text('Do you want to exit?'),
        actions: <Widget>[
          // ignore: deprecated_member_use
           ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
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
          backgroundColor: const Color(0xFF184f8d),
        ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(Globaldata.DisplayName,style: const TextStyle(fontSize: 18.0,color: Colors.white),),
                  accountEmail:  Text(Globaldata.Location),
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
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                              image: NetworkImage("https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png"),)
                        )
                    )
                      ]
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF184f8d)
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(color: Colors.blue )),
                  elevation: 4.0,
                  child:  ListTile(
                    dense: true,
                    leading: const Icon(FontAwesomeIcons.clockRotateLeft,color: Colors.black,),
                    title: const Text(
                      'History',
                      style:  TextStyle(fontSize: 15.0),
                    ),
                      onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const esealHistory()));
                            },
                  )
                ),
                Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(color: Colors.blue )),
                    elevation: 4.0,
                    child:  ListTile(
                      dense: true,
                      leading: const Icon(FontAwesomeIcons.clockRotateLeft,color: Colors.black,),
                      title: const Text(
                        'Rake History',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  const Rakesearch()));
                      },
                    )
                ),
                Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(color: Colors.blue )),
                    elevation: 4.0,
                    child:  ListTile(
                      dense: true,
                      leading: const Icon(FontAwesomeIcons.clockRotateLeft,color: Colors.black,),
                      title: const Text(
                        'Grounding History',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      onTap: (){
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>  const Rakesearch()));
                      },
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
                      side: const BorderSide(color: Colors.blue )),
                  child: ListTile(
                    dense: true,
                      leading: const Icon(Icons.security_rounded,color: Colors.black,),
                      title: const Text(
                        'Privacy Policy',
                        style:  TextStyle(fontSize: 15.0),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const Privacyscreen()));
                      }),
                ),
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(color: Colors.blue )),
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
                        margin: const EdgeInsets.all(9.0),
                        elevation: 10.0,
                        shadowColor: Colors.blueAccent,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: Colors.red,width: 1)
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Sealtabbar()));
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
                                  'Seal Verification',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14.0,
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Temptabbar()));
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
                                  'Reefer Cntr. Temperature',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14.0,
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  dropdownrake()));
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
                                      fontSize: 14.0,
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
                            statusdata.Rakestatusupdate(context);
                            //Navigator.push(context, MaterialPageRoute(builder: (context) =>  rakePosition()));
                          },
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
                                  'Rake Position List',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14.0,
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
                            detailrakestatusdata.detailRakestatus(context);
                            //Navigator.push(context, MaterialPageRoute(builder: (context) =>  rakePosition()));
                          },
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
                                  'Rake Position Detail',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14.0,
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  dropdownscreen()));
                          },
                          splashColor: Colors.green,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'images/Grounding.png',
                                  height: 60,
                                  width: 60,
                                ),
                                const Text(
                                  'Grounding /Weighment',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14.0,
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => warehousetab()));
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
                                      fontSize: 14.0,
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
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => dropdownExam()));
                          },
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
                                  'Container Examination',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14.0,
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
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(10.0),
              shape: Border.all(color: Colors.red, width: 2),
              title: const Text(
                'Select Image',
              ),
              content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      GestureDetector(
                        child: const Text('Gallery', style: TextStyle(fontSize: 20.0)),
                        onTap: () {
                          openGallery();
                          setState(() {});
                          Navigator.of(context).pop(false);
                        },
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      GestureDetector(
                        child: const Text('Camera', style: TextStyle(fontSize: 20.0)),
                        onTap: () {
                          openCamera();
                          setState(() {});
                          Navigator.of(context).pop(false);
                        },
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:MaterialStateProperty.all(const Color(0xFF184f8d)),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text(
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
  }
  Future<void> openCamera() async {
    var pickedFile =
    (await picker.pickImage(source: ImageSource.gallery, imageQuality: 25));
    setState(() {
      imageFile = File(pickedFile!.path);
    });

  }
}
