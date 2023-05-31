import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:super_app/Screens/ILESearch_Listviewbuilder.dart';
import 'package:super_app/Services/Container_searchcontroller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../Models/ILE_Models.dart';
import '../universal.dart';
import '../universal.dart';

class Containersearch extends StatefulWidget {
    Containersearch({Key? key}) : super(key: key);

  @override
  State<Containersearch> createState() => _ContainersearchState();
}
int rindex = 0;
class _ContainersearchState extends State<Containersearch> {
  final ILEController obj = Get.put(ILEController());
  Welcome? fromdata;
  String? selectedvalue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        title: Text("History"),
        backgroundColor: Color(0xFF184f8d),
      ),
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 30.0)),
            Column(
              children:  [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: [
                      Container(
                        height:45,
                        width: 300,
                        child: TextField(
                          controller: obj.searchcontroller ,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                                //suffixIcon: Icon(Icons.clear,color: Colors.black,),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.black)
                              ),
                              hintText: "Please Enter Container No.",
                                hintStyle: const TextStyle(color: Colors.black, fontSize: 15),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    obj.searchcontroller.clear();
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    color: Color(0xFF184f8d),
                                  ),
                                )
                        )),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: RadioListTile(
                        title: Text(
                          "Stuffing",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        value: "1",
                        groupValue: obj.selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            obj.selectedvalue = value.toString();
                          });
                        },
                      ),),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: RadioListTile(
                          title: Text("Destuffing",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold)),
                          value: "2",
                          groupValue: obj.selectedvalue,
                          onChanged: (value) {
                            setState(() {
                              obj.selectedvalue = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: RadioListTile(
                          title: Text("e-Seal",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold)),
                          value: "3",
                          groupValue: obj.selectedvalue,
                          onChanged: (value) {
                            setState(() {
                              obj.selectedvalue = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: RadioListTile(
                          title: Text("All",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold)),
                          value: "0",
                          groupValue: obj.selectedvalue,
                          onChanged: (value) {
                            setState(() {
                              obj.selectedvalue = value.toString();
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all(Color(0xFF184f8d)),
                  ),
                  child: Text('Search',style: TextStyle(fontSize: 18.0),),
                    onPressed: () async {
                    if(obj.searchcontroller.text.isEmpty){
                      Fluttertoast.showToast(
                          msg: "Please enter container no.",
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Color(0xFF184f8d),
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if(obj.selectedvalue==null){
                      Fluttertoast.showToast(
                          msg: "Please Activity type",
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Color(0xFF184f8d),
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    else {
                      fromdata =  await obj.searchIlE();
                      if (fromdata?.error==false){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            ILEListview(fromdata: fromdata),));
                        obj.searchcontroller.clear();
                        obj.selectedvalue=null;
                        setState(() {
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Data not found",
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_LONG,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Color(0xFF184f8d),
                            textColor: Colors.white,
                            fontSize: 16.0);
                        obj.searchcontroller.clear();
                        obj.selectedvalue=null;
                        setState(() {});

                      }

                    }

                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
