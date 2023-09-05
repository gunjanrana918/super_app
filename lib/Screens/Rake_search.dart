// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../Models/Rakehistory_model.dart';
import '../universal.dart';
import 'Rakehistory_details.dart';

class Rakesearch extends StatefulWidget {
   const Rakesearch({Key? key,}) : super(key: key);

  @override
  State<Rakesearch> createState() => _RakesearchState();
}
int rindex = 0;
class _RakesearchState extends State<Rakesearch> {
  TextEditingController datecontroller = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();
  Rakehistorydata? rakedata;
  // ignore: prefer_typing_uninitialized_variables
  var selectdate;
  String _myRake='';
  List rakeList=[];
  List<Rakehistorydata>? list = [];
  rakehistorysearch() async {
    int index=0;
    var headers = {
      'Content-Type': 'application/json'
    };
      var request = http.Request('GET',
          Uri.parse('http://103.25.130.254/grfl_login_api/Api/Rakehistory'));
      request.body = json.encode({
        "Location":Globaldata.Location,
        "ArrivalDate":selectdate,
        "Rake":_myRake
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var responseData = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        var autoGenerate = Rakehistorydata.fromJson(json.decode(responseData));
        var refreshdata = autoGenerate;
        if (refreshdata.data[index].error == false) {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              Rakehistorydetails(rakedata: refreshdata,),));
          setState(() {
            datecontroller.clear();
          });
        } else {
          Fluttertoast.showToast(
              msg:refreshdata.data[index].msg,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb:2,
              backgroundColor: const Color(0xFF184f8d),
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() {
            searchcontroller.clear();
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
  rakesearch() async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET',
        Uri.parse('http://103.25.130.254/grfl_login_api/Api/Getgr'));
    request.body = json.encode({
      "Location":Globaldata.Location,
      "ArrivalDate":selectdate,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var autoGenerate = json.decode(responseData);
      var refreshdata = autoGenerate;
      setState(() {
        rakeList = refreshdata['Data'];
      });
        setState(() {
          datecontroller.clear();
        });

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rake History"),
        backgroundColor: const Color(0xFF184f8d),
      ),
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Column(
              children:  [
                const SizedBox(height: 5.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 40,
                          width: 180,
                          child:
                          TextField(
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
                                  datecontroller.text = formattedDate;//set output date to TextField value.
                                  selectdate= datecontroller.text;
                                  rakesearch();
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
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: SizedBox(
                          height: 45,
                          width: 180,
                          child: 
                          rakeviewdata(context),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget rakeviewdata(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 0.0,top: 5.0),
              child: Text("Rake No. ",style: TextStyle(
                  fontSize: 15.0,fontWeight: FontWeight.bold
              ),),
            ),
            Flexible(
              flex: 1,
              child:
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  height: 36,
                  width: 150,
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: false,
                          child: DropdownButton<String>(
                            value: _myRake.isNotEmpty ? _myRake : null,
                            iconSize: 30,
                            icon: (null),
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            //hint: Text('Select Rake'),
                            onChanged: ( newValue) {
                              setState(() {
                                _myRake = newValue!;
                                Globaldata.Rakeno=_myRake;
                                rakehistorysearch();
                                //Navigator.push(context, MaterialPageRoute(builder: (context) =>  Rakehistorydetails()));

                              });
                            },
                            items: rakeList.map((item) {
                              return DropdownMenuItem(
                                value: item['RakeNo'].toString(),
                                child:  Text(item['RakeNo']),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

