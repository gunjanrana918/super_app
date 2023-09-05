import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:super_app/Models/SendDetails.dart';
import 'package:super_app/universal.dart';

import '../Models/Rakecontainer_model.dart';

class Rakesurvey extends StatefulWidget {
   Rakesurvey({super.key, });
  @override
  State<Rakesurvey> createState() => _RakesurveyState();
}

class _RakesurveyState extends State<Rakesurvey> {
  @override
  void initState() {
    super.initState();
    _getRakeList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("e-Rake Survey", style: TextStyle(
          fontSize: 19.0,
        ),),
        backgroundColor: Color(0xFF184f8d),
      ),
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               const Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Text("Rake No. ",style: TextStyle(
                   fontSize: 15.0,
                 ),),
               ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Flexible(
                    flex: 1,
                    child:
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      height: 30,
                      width: 150,
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
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
                                      print("_myRake");
                                      print(Globaldata.Rakeno);
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  getcontainer()));
                                    });
                                  },
                                  items: rakeList.map((item) {
                                    return DropdownMenuItem(
                                      value: item['rake'].toString(),
                                      child:  Text(item['rake']),
                                    );
                                  }).toList(),
                                ),
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
        //     Column(
        //       children: [
        //         mydata(),
        // containerdata(context)
        //       ],
        //     )

          ],
        ),
      ),
    );
  }
   List rakeList=[];
  String _myRake='';
  Future<void> _getRakeList() async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/showRake'));
    request.body = json.encode({
      "Location": Globaldata.Location,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if(response.statusCode==200){
      var Rdata= json.decode(responseData);
      print(Rdata);
      setState(() {
        rakeList = Rdata['Data'];
      });
    }


  }
}




//GetContaier//******
class getcontainer extends StatefulWidget {
  Sendcontainerdetails? uploaddata;
   getcontainer({super.key, this.uploaddata,});
  @override
  State<getcontainer> createState() => _getcontainerState();
}

class _getcontainerState extends State<getcontainer> {
  final containersearch = TextEditingController();
  final additionalremarks = TextEditingController();
  final phycustomscontrooler = TextEditingController();
  final phylinecontrooler = TextEditingController();
  final phywagoncontrooler = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<Containerrake>> key = GlobalKey();
  late  AutoCompleteTextField searchTextField;
  TextEditingController controller = TextEditingController();
  final ContainerViewModel containernewdata = ContainerViewModel();
  String dropdownvalue = '';
  String dropdownnewvalue = '';
  String dropdowncntrcondtn = '';
  bool agree = false;
  Sendcontainerdetails? uploaddata ;
  var containerstatus = [
    'Sound',
    'Damage',
  ];
  var linestatus = [
    'UTD',
    'Same',
    'Damage',
    'Mismatch',
    'Upper Stack',
  ];
  var customstatus = [
    'UTD',
    'Same',
    'Damage',
    'Mismatch',
    'Upper Stack',
  ];
  List rakeList=[];

  Future<void> _getRakeList() async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/showRake'));
    request.body = json.encode({
      "Location": Globaldata.Location,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if(response.statusCode==200){
      var Rdata= json.decode(responseData);
      print(Rdata);
      setState(() {
        rakeList = Rdata['Data'];
      });
    }


  }
  containerUpload() async {
    int index = 0;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/ContainerDetails'));
    request.body = json.encode({
      "ContainerNo":  searchTextField.textField?.controller?.text,
      "Location": Globaldata.Location
    });
    request.headers.addAll(headers);
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
    var  parsedata = Sendcontainerdetails.fromJson(jsonDecode(responseData));
      print('parsedata');
      print(parsedata);
      var message = parsedata.data[index].msg;
      print('parsedata');
      print(message);
      Globaldata.Sendmessage = message;
      if (parsedata.data[index].error == false) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
              getcontainer(uploaddata: parsedata,)));
          // code to be executed after 2 seconds
        });
        // Fluttertoast.showToast(
        //     msg: parsedata.data[index].msg,
        //     gravity: ToastGravity.BOTTOM,
        //     toastLength: Toast.LENGTH_SHORT,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Color(0xFF184f8d),
        //     textColor: Colors.white,
        //     fontSize: 16.0);
      }
      else {
        Fluttertoast.showToast(
            msg: Globaldata.Sendmessage,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {

        });
      }
    }
    else {
      Fluttertoast.showToast(
          msg: 'Data not found',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  @override
  void initState() {
    super.initState();
    _getRakeList();
    containernewdata.loadPlayers().then((value) {
      setState(() {
        containernewdata.Data;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Container Details",style: TextStyle(
          fontSize: 19.0,
        ),),
      backgroundColor: Color(0xFF184f8d),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget> [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Rake No. ",style: TextStyle(
                    fontSize: 15.0,
                  ),),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 39.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      height: 30,
                      width: 100,
                      child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: Globaldata.Rakeno,
                            labelStyle: const TextStyle(fontSize: 14.0,color: Colors.black),
                            contentPadding: const EdgeInsets.all(5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Container No. ",style: TextStyle(
                    fontSize: 15.0,
                  ),),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    height: 40,
                    width: 160,
                    child: searchTextField = AutoCompleteTextField<Containerrake>(
                        style:  const TextStyle(color: Colors.black, fontSize: 16.0),
                        decoration: const InputDecoration(
                          //hintText: Globaldata.Rcontainerno,
                            contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                            hintStyle: TextStyle(color: Colors.black),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(11),// for mobile
                        ],
                        itemSubmitted: (item) {
                          setState(() {
                            searchTextField.textField?.controller?.text = item.containerNo;
                            print(searchTextField.textField?.controller?.text);
                            Globaldata.Rcontainerno = searchTextField.textField!.controller!.text;
                            containerUpload();
                          });
                        },
                        clearOnSubmit: false,
                        key: key,
                        suggestions: containernewdata.Data,
                        itemBuilder: (context, e) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(e.containerNo,
                                style: const TextStyle(
                                    fontSize: 16.0
                                ),),
                            ],
                          );
                        },
                        itemSorter: (a, b) {
                          return a.containerNo.compareTo(b.containerNo);
                        },
                        itemFilter: (query, enteredkeyword) {
                          return query.containerNo
                              .toLowerCase()
                              .contains(enteredkeyword.toLowerCase());
                        }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            mydata(),
            const SizedBox(height: 8,),
            containerdata(context),
          ],
        ),
      ),
    );
  }
  Widget mydata (){
    int index=0;
  print('widget.uploaddata?.data[index].error');
  print(widget.uploaddata?.data[index].error);
    return widget.uploaddata?.data[index].error==false
        ? FittedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataTable(
            sortColumnIndex: 1,
            showCheckboxColumn: false,
            border: TableBorder.all(color: Color(0xFF184f8d),width: 2.0),
            columns: const[
              DataColumn(
                  label: Text("Ctr no.",style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.bold))
              ),
              DataColumn(
                  label: Text("Size",style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text("Type",style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text("From",style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text("To",style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.bold))),
            ],
            rows:   [
              DataRow(
                  cells: [
                    DataCell(
                      Text(widget.uploaddata!.data[index].containerNo.isEmpty?
                      '':widget.uploaddata!.data[index].containerNo,
                        style: TextStyle(fontSize: 18.0,color: Colors.black),),
                    ),
                    DataCell(
                        Text(widget.uploaddata!.data[index].size.isEmpty?"":
                        widget.uploaddata!.data[index].size,style: TextStyle(fontSize: 18.0,color: Colors.black),)),
                    DataCell(
                        Text(widget.uploaddata!.data[index].type.isEmpty?'':widget.uploaddata!.data[index].type,style: TextStyle(fontSize: 18.0,color: Colors.black),)),
                    DataCell(
                        Text(widget.uploaddata!.data[index].fromLocation.isEmpty?'':widget.uploaddata!.data[index].fromLocation,style: TextStyle(fontSize: 18.0,color: Colors.black),)),
                    DataCell(
                        Text(widget.uploaddata!.data[index].toLocation.isEmpty?'':widget.uploaddata!.data[index].toLocation,style: TextStyle(fontSize: 18.0,color: Colors.black),))
                  ])
            ]
        ),
      ),
    ): Container();
  }
  Widget containerdata(BuildContext context) {
    int index=0;
    return widget.uploaddata?.data[index].error==false ?
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget> [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      //label: Text('Wagon no.'),
                      labelText: 'Wagon no.',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      //alignLabelWithHint: true,
                      hintText: widget.uploaddata!.data[index].wagonno,
                      hintStyle: TextStyle(fontSize: 14.0,color: Colors.black),
                      labelStyle: const TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  readOnly: true,
                    controller: phywagoncontrooler,
                    decoration: InputDecoration(
                      labelText: "Phys.Wagon",
                      //hintText: widget.uploaddata!.data[index].wagonno.isEmpty?'':widget.uploaddata!.data[index].wagonno,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.all(6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListTile(
                  title: const Text('Same as',style: TextStyle(fontSize: 14.0),),
                  leading: Checkbox(
                    value: agree,
                    onChanged: (value) {
                      setState(() {
                        agree = value!;
                      });
                      if(value!){
                        setState(() {
                          phywagoncontrooler.text = widget.uploaddata!.data[index].wagonno;
                        });
                      }
                      else {
                        phywagoncontrooler.clear();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8,),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:<Widget> [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                          labelText: "Custm.Seal",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: widget.uploaddata!.data[index].customsSeal,
                          labelStyle: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold),
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                      )
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextField(
                      controller: phycustomscontrooler,
                      decoration: InputDecoration(
                        labelText: "Phy.Custm.Seal",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold),
                        contentPadding: const EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      )
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  //width: 1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.black)),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        isExpanded:true,
                        iconSize: 20,
                        iconEnabledColor: Color(0xFF184f8d),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        hint: Text(
                          'Select',
                          style: TextStyle(color: Colors.black),
                        ),
                        // Initial Value
                        value: dropdownvalue.isNotEmpty ? dropdownvalue : null,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items
                        items: customstatus.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items,style: TextStyle(fontSize: 14.0),),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),),]),
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                      labelText: "Line Seal",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: widget.uploaddata!.data[index].lineSealNo,
                      hintStyle: TextStyle(fontSize: 14.0,color: Colors.black),
                      labelStyle: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold),
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                  ),
                ),
              ),),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  controller: phylinecontrooler,
                  decoration: InputDecoration(
                      labelText: "Phys.Line Seal",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold),
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                  ),
                ),
              ),),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.black)),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        isExpanded:true,
                        iconSize: 25,
                        iconEnabledColor: Color(0xFF184f8d),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        hint: Text(
                          'Select',
                          style: TextStyle(color: Colors.black,fontSize: 14.0),
                        ),
                        // Initial Value
                        value: dropdownnewvalue.isNotEmpty ? dropdownnewvalue : null,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items
                        items: linestatus.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items,style: TextStyle(fontSize: 14.0)),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (newValue) {
                          setState(() {
                            dropdownnewvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),),
          ],
        ),
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget> [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Contr.Condition",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: widget.uploaddata!.data[index].containerCondition,
                      hintStyle: TextStyle(fontSize: 14.0,color: Colors.black),
                      labelStyle: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.black)),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        isExpanded:true,
                        iconSize: 25,
                        iconEnabledColor: Color(0xFF184f8d),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        hint: Text(
                          'Phys.Cntr.Cond.',
                          style: TextStyle(color: Colors.black,fontSize: 14),
                        ),
                        // Initial Value
                        value: dropdowncntrcondtn.isNotEmpty ? dropdowncntrcondtn : null,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items
                        items: containerstatus.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (newValue) {
                          setState(() {
                            dropdowncntrcondtn = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),),
          ],
        ),
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                    decoration: InputDecoration(
                      labelText: "Survyr.Remarks",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: widget.uploaddata!.data[index].surveyRemarks,
                      hintStyle: TextStyle(fontSize: 14.0,color: Colors.black),
                      labelStyle: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                    controller: additionalremarks,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: "Add.Remarks",
                      labelStyle: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 1,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SizedBox(
                    height: 50,
                    width: 70,
                    child: MaterialButton(
                      onPressed: () {
                        print("hello");
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                            getcontainer()));
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          side: BorderSide(color: Colors.black)),
                      elevation: 10.0,
                      color: Color(0xFF184f8d),
                      textColor: Colors.white,
                    ),
                  ),
                )),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SizedBox(
                    height: 50,
                    width: 60,
                    child: MaterialButton(
                      onPressed: () {
                      },
                      child: Text(
                        "Reset",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          side: BorderSide(color: Colors.black)),
                      elevation: 10.0,
                      color: Colors.red,
                      textColor: Colors.white,
                    ),
                  ),
                )),
          ],
        )
      ],

    ):Container();
  }
}






