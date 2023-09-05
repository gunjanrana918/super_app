import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:super_app/Models/SendDetails.dart';
import 'package:super_app/universal.dart';

import '../Models/Rakecontainer_model.dart';
import '../Models/Submit_Containerdata.dart';
import '../Models/WagonDetails_Model.dart';


class exportRakesurvey extends StatefulWidget {
  exportRakesurvey({super.key, });
  @override
  State<exportRakesurvey> createState() => _exportRakesurveyState();
}

class _exportRakesurveyState extends State<exportRakesurvey> {
  bool approve = false;
  @override
  void initState() {
    super.initState();
    _getRakeList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Rake No. ",style: TextStyle(
                      fontSize: 15.0,fontWeight: FontWeight.bold
                  ),),
                ),
                Flexible(
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  getexport()));
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/ExportShowRake'));
    request.body = json.encode({
      "Location": Globaldata.Location,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if(response.statusCode==200){
      var Rdata= json.decode(responseData);
      setState(() {
        rakeList = Rdata['Data'];
      });
    }


  }
}

///Export////
class getexport extends StatefulWidget {
  Sendcontainerdetails? uploaddata;
  getexport({super.key, this.uploaddata,});
  @override
  State<getexport> createState() => _getexportState();
}
int index=0;
class _getexportState extends State<getexport> {
  GlobalKey<AutoCompleteTextFieldState<Containerrake>> key = GlobalKey();
  late  AutoCompleteTextField searchTextField;
  TextEditingController controller = TextEditingController();
  final ContainerViewModel containernewdata = ContainerViewModel();
  bool agree = false;
  Sendcontainerdetails? uploaddata ;
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
      setState(() {
        rakeList = Rdata['Data'];
      });
    }


  }
  wagondata() async {
    int index = 0;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/WagonDetails'));
    request.body = json.encode({
      "ContainerNo": searchTextField.textField?.controller?.text,
      "Location": Globaldata.Location,
      "Documentno": containernewdata.Data[index].documentno,
    });
    request.headers.addAll(headers);
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var  wagonparsedata = WagomDetails.fromJson(jsonDecode(responseData));
      var message = wagonparsedata.data[index].msg;
      if (wagonparsedata.data[index].error == false) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              exportdetails(wagondata: wagonparsedata,)));
          searchTextField.textField!.controller!.text='';
        });
      }
      else {
        Fluttertoast.showToast(
            msg: Globaldata.Sendmessage,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
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
          backgroundColor: const Color(0xFF184f8d),
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
        title: const Text("Container Details",style: TextStyle(
          fontSize: 19.0,
        ),),
        backgroundColor: const Color(0xFF184f8d),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget> [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Rake No. ",style: TextStyle(
                      fontSize: 15.0,fontWeight: FontWeight.bold
                  ),),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:  const EdgeInsets.all(7.0),
                    child: Container(
                      height: 40,
                      width: 80,
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
                Flexible(
                  // flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      height: 40,
                      width: 280,
                      child:
                      searchTextField = AutoCompleteTextField<Containerrake>(
                          style:  const TextStyle(color: Colors.black, fontSize: 14.0,),
                          decoration:  InputDecoration(
                            hintText: 'Container No.',
                            border: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5.0)),
                            contentPadding: const EdgeInsets.only(left: 5.0,bottom: 12.0,right: 5.0,top: 5.0),
                            hintStyle: const TextStyle(color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.bold),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(11),// for mobile
                          ],
                          itemSubmitted: (item) {
                            setState(() {
                              searchTextField.textField?.controller?.text = item.containerNo;
                              Globaldata.Rcontainerno = searchTextField.textField!.controller!.text;
                              searchTextField.textField!.controller!.text='';
                              wagondata();
                            });
                          },
                          clearOnSubmit: false,
                          key: key,
                          suggestions: containernewdata.Data,
                          itemBuilder: (context, e) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(e.containerNo,
                                  style: const TextStyle(
                                      fontSize: 14.0
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
                ),
              ],
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

class exportdetails extends StatefulWidget {
  WagomDetails? wagondata;
   exportdetails({super.key, this.wagondata});
  @override
  State<exportdetails> createState() => _exportdetailsState();
}

class _exportdetailsState extends State<exportdetails> {
  var tablecontainer;
  containerUpload() async {
    int index = 0;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/ContainerDetails'));
    request.body = json.encode({
      "ContainerNo": tablecontainer,
      "Location": Globaldata.Location
    });
    request.headers.addAll(headers);
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var  parsedata = Sendcontainerdetails.fromJson(jsonDecode(responseData));
      var message = parsedata.data[index].msg;
      Globaldata.Sendmessage = message;
      if (parsedata.data[index].error == false) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              exportCntrDetails(uploaddata: parsedata,)));
          // code to be executed after 2 seconds
        });
      }
      else {
        Fluttertoast.showToast(
            msg: Globaldata.Sendmessage,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
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
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Container Details",style: TextStyle(
          fontSize: 19.0,
        ),),
        backgroundColor: const Color(0xFF184f8d),
      ),
      // bottomNavigationBar: SizedBox(
      //     height: 40,
      //     child: Row(
      //       children: [
      //         Expanded(
      //           child: MaterialButton(
      //             onPressed: () {
      //               openCamera();
      //             },
      //             child: const Text(
      //               "Take Photo",
      //               style: TextStyle(fontSize: 18.0),
      //             ),
      //             shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(10.0),
      //                 side: const BorderSide(color: Colors.black)),
      //             elevation: 10.0,
      //             color: Colors.red,
      //             textColor: Colors.white,
      //           ),
      //         ),
      //         Expanded(
      //           child: MaterialButton(
      //             onPressed: () {
      //               submitContainerdetails();
      //             },
      //             shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(10.0),
      //                 side: const BorderSide(color: Colors.black)),
      //             elevation: 10.0,
      //             color: const Color(0xFF184f8d),
      //             textColor: Colors.white,
      //             child: const Text(
      //               "Submit",
      //               style: TextStyle(fontSize: 18.0),
      //             ),
      //           ),
      //         ),
      //       ],
      //     )
      // ),
      body: Column(
        children: [
          const SizedBox(height: 5,),
          mydata(),
          const SizedBox(height: 8,),
        ],
      ),
    );
  }
  Widget mydata (){
    int index=0;
    return widget.wagondata?.data[index].error==false
        ? Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Departure Date :",style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.wagondata!.data[index].departuredate),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("From Location :",style: TextStyle(fontWeight: FontWeight.bold)),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.wagondata!.data[index].details[index].fromLocation.isEmpty?"":
              widget.wagondata!.data[index].details[index].fromLocation),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("To Location :",style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.wagondata!.data[index].details[index].toLocation.isEmpty?"":
              widget.wagondata!.data[index].details[index].toLocation),
            ),

          ],
        ),
        FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DataTable(
              //horizontalMargin: 10,
              //columnSpacing: 0,
                sortColumnIndex: 1,
                showCheckboxColumn: false,
                border: TableBorder.all(color: const Color(0xFF184f8d),width: 2.0),
                columns: const[
                  DataColumn(
                      label: Text("Container No.",style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.bold))
                  ),
                  DataColumn(
                      label: Text("Size",style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text("Type",style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text("Action",style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.bold))),
                ],
                rows:  widget.wagondata!.data[index].details.map((e) => DataRow(cells: [
                  DataCell(Text(e.containerNo,style: const TextStyle(fontSize: 18.0,color: Colors.black,))),
                  DataCell(Text(e.size,style: const TextStyle(fontSize: 18.0,color: Colors.black,))),
                  DataCell(Text(e.type,style: const TextStyle(fontSize: 18.0,color: Colors.black,))),
                  DataCell(
                      InkWell(
                        onTap: () async {
                          tablecontainer= e.containerNo;
                          containerUpload();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Click Here',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      )),
                ])).toList()

            ),
          ),
        ),
      ],
    ): Container();
  }

}
class exportCntrDetails extends StatefulWidget {
  Sendcontainerdetails? uploaddata;
   exportCntrDetails({super.key,this.uploaddata});

  @override
  State<exportCntrDetails> createState() => _exportCntrDetailsState();
}

class _exportCntrDetailsState extends State<exportCntrDetails> {
  final containersearch = TextEditingController();
  final additionalremarks = TextEditingController();
  final phycustomscontrooler = TextEditingController();
  final phylinecontrooler = TextEditingController();
  final phywagoncontrooler = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<Containerrake>> key = GlobalKey();
  late  AutoCompleteTextField searchTextField;
  TextEditingController controller = TextEditingController();
  TextEditingController surveycontroller = TextEditingController();
  final ContainerViewModel containernewdata = ContainerViewModel();
  bool agree = false;
  Sendcontainerdetails? uploaddata ;
  List containerstatus =  [
    {"name": "Sound", "value": "1"},
    {"name": "Damage", "value": "2"},
  ];
  List dropDownListData = [
    {"title": "DTD", "value": "1"},
    {"title": "UpperStack", "value": "2"},
    {"title": "Mismatch", "value": "3"},
    {"title": "Damage", "value": "4"},
    {"title": "Same", "value": "5"},
  ];
  String? selectedCourseValue = "";
  String? lineCourseValue = "";
  String? physcntrValue = "";
  var tablecontainer;
  File? imageFile;
  final picker = ImagePicker();
  Future<void> openCamera() async {
    var pickedFile =
    (await picker.pickImage(source: ImageSource.camera, imageQuality: 25));
    setState(() {
      imageFile = File(pickedFile!.path);
      // sealobject = true;
    });
    setState(() {});
  }
  submitContainerdetails() async {
    int index = 0;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://103.25.130.254/grfl_login_api/Api/UpdateContainerDetails'));
    request.body = json.encode({
      "ContainerNo": widget.uploaddata!.data[index].containerNo,
      "Location": Globaldata.Location,
      "DocumentNo": widget.uploaddata!.data[index].documentNo,
      "CustomSealStatus": selectedCourseValue,
      "LineSealStatus": lineCourseValue,
      "SurveyWagonNo": phywagoncontrooler.text,
      "SurveyCustomSealNo": phycustomscontrooler.text,
      "SurveyLineSealNo": phylinecontrooler.text,
      "SurveyContainerCondition": physcntrValue,
      "SurveyRemarks": surveycontroller.text
    });
    request.headers.addAll(headers);
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var  parsedata = Submitcontainerdata.fromJson(jsonDecode(responseData));
      if (parsedata.data[index].error == false) {
        setState(() {
          widget.uploaddata!.data[index].containerNo='';
          widget.uploaddata!.data[index].documentNo='';
          widget.uploaddata!.data[index].size='';
          widget.uploaddata!.data[index].type='';
          widget.uploaddata!.data[index].lineSealNo='';
          widget.uploaddata!.data[index].wagonno='';
          widget.uploaddata!.data[index].toLocation='';
          widget.uploaddata!.data[index].fromLocation='';
          widget.uploaddata!.data[index].containerCondition='';
          widget.uploaddata!.data[index].surveyRemarks='';
          selectedCourseValue= null;
          lineCourseValue= null;
          physcntrValue= null;
          phywagoncontrooler.clear();
          phycustomscontrooler.clear();
          phylinecontrooler.clear();
          agree=false;
        });
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
          // code to be executed after 2 seconds
        });
        Fluttertoast.showToast(
            msg: parsedata.data[index].msg,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
      }
      else {
        Fluttertoast.showToast(
            msg: parsedata.data[index].msg,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {

        });
      }
    }
    else {
      Fluttertoast.showToast(
          msg: 'Data not submit',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Container No. : ${widget.uploaddata?.data[index].containerNo}", style: TextStyle(
          fontSize: 16.0,
        ),),
        backgroundColor: const Color(0xFF184f8d),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                      height: 35,
                      child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            //label: Text('Wagon no.'),
                            labelText: 'Wagon No.',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            //alignLabelWithHint: true,
                            hintText: widget.uploaddata!.data[index].wagonno,
                            hintStyle: const TextStyle(
                                fontSize: 14.0, color: Colors.black),
                            labelStyle: const TextStyle(fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            contentPadding: const EdgeInsets.all(5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                      height: 35,
                      child: TextField(
                          controller: phywagoncontrooler,
                          decoration: InputDecoration(
                            labelText: "Physical Wagon",
                            //hintText: widget.uploaddata!.data[index].wagonno.isEmpty?'':widget.uploaddata!.data[index].wagonno,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: const TextStyle(fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            contentPadding: const EdgeInsets.all(6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: agree,
                      onChanged: (value) {
                        setState(() {
                          agree = value!;
                        });
                        if (value!) {
                          setState(() {
                            phywagoncontrooler.text = widget.uploaddata!
                                .data[index].wagonno;
                          });
                        }
                        else {
                          phywagoncontrooler.clear();
                        }
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Text('Same as', style: TextStyle(fontSize: 13.0),),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: 35,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                          labelText: "Line Seal",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: widget.uploaddata!.data[index].lineSealNo,
                          hintStyle: const TextStyle(
                              fontSize: 14.0, color: Colors.black),
                          labelStyle: const TextStyle(fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          contentPadding: const EdgeInsets.all(5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                      ),
                    ),
                  ),
                ),),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: 35,
                    child: TextField(
                      controller: phylinecontrooler,
                      decoration: InputDecoration(
                          labelText: "Physical Seal",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: const TextStyle(fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          contentPadding: const EdgeInsets.all(5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                      ),
                    ),
                  ),
                ),),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Container(
                    height: 36,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const Text("Seal Status", style: TextStyle(
                              fontSize: 10.0, color: Colors.black)),
                          value: lineCourseValue,
                          isDense: true,
                          isExpanded: true,
                          // menuMaxHeight: 450,
                          items: [
                            const DropdownMenuItem(
                                value: "",
                                child: Text(
                                  "Seal Status",
                                  style: TextStyle(fontSize: 14.0),
                                )),
                            ...dropDownListData.map<DropdownMenuItem<String>>((
                                e) {
                              return DropdownMenuItem(
                                  value: e['value'],
                                  child: Text(e['title']));
                            }).toList(),
                          ],
                          onChanged: (Value) {
                            setState(() {
                              lineCourseValue = Value!;
                            },
                            );
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
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 35,
                    child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Container Condition",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: widget.uploaddata!.data[index]
                              .containerCondition,
                          hintStyle: const TextStyle(
                              fontSize: 14.0, color: Colors.black),
                          labelStyle: const TextStyle(fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          contentPadding: const EdgeInsets.all(5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        )
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.black)),
                    child:
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const Text("Physical Condition",
                            style: TextStyle(
                                fontSize: 10.0, color: Colors.black),),
                          value: physcntrValue,
                          isDense: true,
                          isExpanded: true,
                          menuMaxHeight: 350,
                          items: [
                            const DropdownMenuItem(
                                value: "",
                                child: Text(
                                  "Sound", style: TextStyle(fontSize: 14.0),
                                )),
                            ...containerstatus.map<DropdownMenuItem<String>>((
                                e) {
                              return DropdownMenuItem(
                                  value: e['value'],
                                  child: Text(e['name']));
                            }).toList(),
                          ],
                          onChanged: (myValue) {
                            setState(() {
                              physcntrValue = myValue!;
                            },
                            );
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
                  padding: const EdgeInsets.all(6.0),
                  child: TextField(
                      controller: surveycontroller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Surveyor Remarks",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // hintText: widget.uploaddata!.data[index].surveyRemarks,
                        hintStyle: const TextStyle(
                            fontSize: 14.0, color: Colors.black),
                        labelStyle: const TextStyle(fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
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
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextField(
                      controller: additionalremarks,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Additional Remarks",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
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
          const SizedBox(height: 8,),
          Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Builder(builder: (context) {
                return imageFile != null ?
                SizedBox(
                  height: 130,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.file(File(imageFile!.path)),
                      ),
                      Positioned(
                          right: 15,
                          top: -14,
                          child: IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 25,
                              ),
                              onPressed: () =>
                                  setState(() {
                                    imageFile = null;
                                  })))
                    ],
                  ),
                ) : Container();
              })),
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: MaterialButton(
                      onPressed: () {
                        openCamera();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(color: Colors.black)),
                      elevation: 10.0,
                      color: Colors.red,
                      textColor: Colors.white,
                      child: const Text(
                        "Take Photo",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: MaterialButton(
                    onPressed: () {
                      submitContainerdetails();
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                      //     getcontainer()));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.black)),
                    elevation: 10.0,
                    color: const Color(0xFF184f8d),
                    textColor: Colors.white,
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}







