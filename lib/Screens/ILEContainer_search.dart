// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:super_app/Screens/ILESearch_Listviewbuilder.dart';
import 'package:http/http.dart' as http;
import '../Models/ILEDate_Search.dart';
import '../Models/ILE_Models.dart';
import '../universal.dart';
import 'DateSearchlistviewbuilder.dart';
//Containersearch///
class Containersearch extends StatefulWidget {
    const Containersearch({Key? key}) : super(key: key);

  @override
  State<Containersearch> createState() => _ContainersearchState();
}
class _ContainersearchState extends State<Containersearch> {
  TextEditingController datecontroller = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();
  String? selectedvalue;
  bool uidesign = false;
  var searchdata;
  DateIleSearch? fromdata;
  List<DateIleSearch>? list = [];
  Welcome? containersearchdata;
  List<Welcome>? listt = [];

  searchIlE() async {
    uidesign=false;
    int index=0;
    var headers = {
      'Content-Type': 'application/json'
    };
    try
    {
      var request = http.Request('GET',
          Uri.parse('http://103.25.130.254/grfl_login_api/Api/ILESearch'));
      request.body = json.encode({
        "ContainerNo": searchcontroller.text,
        "ActivityType": selectedvalue.toString(),
        "Location": Globaldata.Location,
        "Remarks": "",
        "Date": ""
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var responseData = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        var autoGenerate = Welcome.fromJson(json.decode(responseData));
        var freshdata = autoGenerate;
        var searchdatamessage = freshdata.data[index].msg;
        Globaldata.containersearchmessage = searchdatamessage;
        if ((freshdata.data[index].error == false)&&(searchcontroller.text.isNotEmpty)) {
          uidesign=false;
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              myclasss(autoGenerate: freshdata,),));
          setState(() {
            searchcontroller.clear();
            selectedvalue = null;
            datecontroller.clear();
          });
        } else {
          Fluttertoast.showToast(
              msg: "Data not found",
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 2,
              backgroundColor: const Color(0xFF184f8d),
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() {
            searchcontroller.clear();
            selectedvalue = null;
            datecontroller.clear();
          });
        }
        return autoGenerate;
      }
      else {
        Fluttertoast.showToast(
            msg: "Data not found",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 5,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
      }}

    catch (e) {
      Fluttertoast.showToast(
          msg: "Data not found",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("History"),
      //   backgroundColor: const Color(0xFF184f8d),
      // ),
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             const Padding(padding: EdgeInsets.only(top: 25.0)),
            Column(
              children:  [
                const SizedBox(height: 5.0,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex:1,
                        child: SizedBox(
                          height:40,
                          width:200,
                          child:
                          TextField(
                            controller: searchcontroller ,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                  //suffixIcon: Icon(Icons.clear,color: Colors.black,),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: "Container No.",
                                  hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
                                  // suffixIcon: GestureDetector(
                                  //   onTap: () {
                                  //     searchcontroller.clear();
                                  //   },
                                  //   child: const Icon(
                                  //     Icons.clear,
                                  //     color: Color(0xFF184f8d),
                                  //   ),
                                  // )
                          )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: const Text("E - Seal",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                        value: "3",
                        groupValue: selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            selectedvalue = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: const Text("Reefer Temp.",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                        value: "4",
                        groupValue: selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            selectedvalue = value.toString();
                          });
                        },
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: const Text(
                          "Stuffing",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        value: "1",
                        groupValue: selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            selectedvalue = value.toString();
                          });
                        },
                      ),),
                    Flexible(
                      child: RadioListTile(
                        title: const Text("Destuffing",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                        value: "2",
                        groupValue: selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            selectedvalue = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all(const Color(0xFF184f8d)),
                  ),
                  child: const Text('Search',style: TextStyle(fontSize: 18.0),),
                    onPressed: () async {
                      if((datecontroller.text.isEmpty)&&(searchcontroller.text.isEmpty)){
                      Fluttertoast.showToast(
                          msg: "Either select date or container no.",
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 2,
                          backgroundColor: const Color(0xFF184f8d),
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    else if(selectedvalue==null){
                      Fluttertoast.showToast(
                          msg: "Please Activity type",
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 2,
                          backgroundColor: const Color(0xFF184f8d),
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    else {
                        await searchIlE();
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


//datesearch///
class dateSearch extends StatefulWidget {
  const dateSearch({Key? key}) : super(key: key);

  @override
  State<dateSearch> createState() => _dateSearchState();
}
// int rindexx = 0;
class _dateSearchState extends State<dateSearch> {
  TextEditingController datecontroller = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();
  String? selectedvalue;
  bool uidesign = false;
  var searchdata;
  DateIleSearch? fromdata;
  List<DateIleSearch>? list = [];
  Welcome? containersearchdata;
  List<Welcome>? listt = [];
  datesearchIlE() async {
    int index=0;
    var headers = {
      'Content-Type': 'application/json'
    };
    try {
      var request = http.Request('GET',
          Uri.parse('http://103.25.130.254/grfl_login_api/Api/ShowImage'));
      request.body = json.encode({
        "Date": datecontroller.text,
        "ActivityType": selectedvalue.toString(),
        "Location": Globaldata.Location,
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var responseData = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        uidesign=true;
        var autoGenerate = DateIleSearch.fromJson(json.decode(responseData));
        var refreshdata = autoGenerate;
        var searchmessage = refreshdata.data[index].msg;
        Globaldata.datesearchmessage = searchmessage;
        if (refreshdata.data[index].error == false) {
          uidesign=true;
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              datesearchdata(Generate: refreshdata,),));
          setState(() {
            selectedvalue = null;
            datecontroller.clear();
          });
        } else {
          Fluttertoast.showToast(
              msg: "Data not found",
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb:2,
              backgroundColor: const Color(0xFF184f8d),
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() {
            selectedvalue = null;
            datecontroller.clear();
          });
        }
        return autoGenerate;
      }
      else {
        Fluttertoast.showToast(
            msg: "Data not found",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
      }}

    catch (e) {
      Fluttertoast.showToast(
          msg: "Data not found",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("History"),
      //   backgroundColor: const Color(0xFF184f8d),
      // ),
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 25.0)),
            Column(
              children:  [
                const SizedBox(height: 5.0,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 40,
                          width: 180,
                          child: TextField(
                            controller: datecontroller,
                            readOnly: true,
                            decoration:  InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Select Date",
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                suffixIcon: const Icon(Icons.calendar_month,color: Color(0xFF184f8d),size: 20,)
                            ),
                            onTap: ()
                            async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context, initialDate: DateTime.now(),
                                  firstDate: DateTime(2023), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101)
                              );
                              if(pickedDate != null ){//pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate = DateFormat('dd-MMM-yyyy').format(pickedDate);
                                //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement
                                setState(() {
                                  datecontroller.text = formattedDate; //set output date to TextField value.
                                });
                              }else{
                                Fluttertoast.showToast(
                                    msg: 'Date is not selected',
                                    gravity: ToastGravity.BOTTOM,
                                    toastLength: Toast.LENGTH_LONG,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: const Color(0xFF184f8d),
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: const Text("E - Seal",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                        value: "3",
                        groupValue: selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            selectedvalue = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: const Text("Reefer Temp.",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                        value: "4",
                        groupValue: selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            selectedvalue = value.toString();
                          });
                        },
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: const Text(
                          "Stuffing",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        value: "1",
                        groupValue: selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            selectedvalue = value.toString();
                          });
                        },
                      ),),
                    Flexible(
                      child: RadioListTile(
                        title: const Text("Destuffing",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                        value: "2",
                        groupValue: selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            selectedvalue = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all(const Color(0xFF184f8d)),
                    ),
                    child: const Text('Search',style: TextStyle(fontSize: 18.0),),
                    onPressed: () async {
                      if((datecontroller.text.isEmpty)&&(searchcontroller.text.isEmpty)){
                        Fluttertoast.showToast(
                            msg: "Either select date or container no.",
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 2,
                            backgroundColor: const Color(0xFF184f8d),
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      else if(selectedvalue==null){
                        Fluttertoast.showToast(
                            msg: "Please Activity type",
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 2,
                            backgroundColor: const Color(0xFF184f8d),
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      else {
                        await datesearchIlE();
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
//tabbar///
class esealHistory extends StatelessWidget {
  const esealHistory({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(length: 2,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 10,
              backgroundColor:  const Color(0xFF184f8d),
              bottom: const TabBar(
                  labelColor: Colors.limeAccent,
                  indicatorColor: Colors.limeAccent,
                  unselectedLabelColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,),
                  tabs: [
                    Tab( text: "Container No.",),
                    Tab( text: "Date")
                  ]),
            ),
            body:   TabBarView(
              children:[
                Containersearch(),
                dateSearch()
              ],
            ),
          ),
        ));
  }
}

