import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Models/JO_Statusupdate.dart';
import '../Models/JOdata_submit_model.dart';
import '../Models/JobOrder_Details.dart';
import '../Models/jobcontainer_Status.dart';
import '../universal.dart';
import 'Grounding_Status.dart';
import 'package:http/http.dart'as http;

class joGroundingserach extends StatefulWidget {
  const joGroundingserach({Key? key}) : super(key: key);

  @override
  State<joGroundingserach> createState() => _joGroundingserachState();
}
// ignore: camel_case_types//
class _joGroundingserachState extends State<joGroundingserach> {
  final examinationcontroller = TextEditingController();
  final weighmemcontroller = TextEditingController();
  bool agree = false;
  bool approve = false;
  TextEditingController searchTextField = TextEditingController();
  final List<jocontainer> _allUsers = [];
  List<jocontainer> _newlist = [];
  Future<String?>getdata() async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/JoStatusUpdate'));
    request.body = json.encode({
      "Location": "ghh",
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      Map newdata = json.decode(responseData);
      var jsondata = newdata['Data'] as List;
      print("data");
      print(jsondata.length);
      for (int i = 0; i < jsondata.length; i++) {
        _allUsers.add(jocontainer.fromJson(jsondata[i]));
      }
    } else {

    }

    //TO SHOW ALL LIST AT INITIAL
    setState(() {
      _newlist = _allUsers;
    });
    return null;
  }
  void _searchlist(String value) {
    setState(() {
      if (value.isEmpty) {
        _newlist = _allUsers;
      } else {
        _newlist = _allUsers
            .where((element) => element.documentno
            .toString()
            .toLowerCase()
            .contains(value.toString().toLowerCase()))
            .toList();
      }
    });
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      getdata();
    });
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text("Job Order : ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.0)),
                ),
              ),
              Flexible(
                // flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 15.0),
                  child: Container(
                    height: 35,
                    width: 180,
                    child:
                    TextField(
                      controller: searchTextField,
                      onChanged: (value) {
                        _searchlist(value);
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Divider(height: 1,color: Colors.black,),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  "Job Order :",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
              ),
            ],
          ),
          Divider(height: 1,color: Colors.black,),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: _newlist.isNotEmpty?
              ListView.builder(
                itemCount: _newlist.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      searchTextField.text = _newlist[index].documentno;
                      Globaldata.JOdocumentno= searchTextField.text;
                      for(var i=0; i<_newlist.length;i++){
                        _newlist[index].documentno.contains(_newlist[index].containerNo);
                        Globaldata.JOContainer=_newlist[index].containerNo;
                      }
                      joboredrdata();
                    },
                    child: ListTile(
                      title: Text(_newlist[index].documentno),
                    ),
                  );
                },
              ):const Text("Job Order Not Found"),
            ),
          ),
        ],
      ),
    );
  }
  joboredrdata() async {
    int index = 0;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET', Uri.parse('http://103.25.130.254/grfl_login_api/api/JobOrder'));
    request.body = json.encode({
      "Location": Globaldata.Location,
      "Jono":  searchTextField.text,
    });
    request.headers.addAll(headers);
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var joborderparsedata =
      JobOrderdetails.fromJson(jsonDecode(responseData));
      //print(joborderparsedata);
      if (joborderparsedata.data[index].error == false) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => joborderdetailsview(
                    joorderdata: joborderparsedata,
                  )));
          // code to be executed after 2 seconds
        });
      } else {
        Fluttertoast.showToast(
            msg: "Data not found",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {});
      }
    } else {
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
}

// ignore: camel_case_types
// ignore: camel_case_types
class joborderdetailsview extends StatefulWidget {
  JobOrderdetails? joorderdata;
  JobContainerstatus? autoGenerate;
  joborderdetailsview({super.key, this.joorderdata, this.autoGenerate});

  @override
  State<joborderdetailsview> createState() => _joborderdetailsviewState();
}

// ignore: camel_case_types
class _joborderdetailsviewState extends State<joborderdetailsview> {
  final examinationcontroller = TextEditingController();
  final weighmemcontroller = TextEditingController();
  bool agree = false;
  bool approve = false;
  bool component = false;
  var jocontainer;
  var shiftingGroundng;
  var weighmentdone;
  searchJoContainer() async {
    int index = 0;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET',
        Uri.parse('http://103.25.130.254/grfl_login_api/Api/JobOrderStatus'));
    request.body = json.encode({
      "ContainerNo":  Globaldata.JOContainer,
      "Location": Globaldata.Location,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var autoGenerate = JobContainerstatus.fromJson(json.decode(responseData));
      var freshdata = autoGenerate;
      shiftingGroundng = freshdata.data[index].shiftingGroundingDone;
      weighmentdone = freshdata.data[index].weighmentdone;
      if (freshdata.data[index].error == false) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => detailStatus(
                autoGenerate: freshdata,
              ),
            ));
      } else {
        Fluttertoast.showToast(
            msg: "Status Already Updated.",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Request For",
          style: TextStyle(
            fontSize: 19.0,
          ),
        ),
        backgroundColor: const Color(0xFF184f8d),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Widgettabledata(),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widgettabledata() {
    int index=0;
    return widget.joorderdata?.data[index].error == false
        ? Column(
      children: [
        FittedBox(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: DataTable(
                // dataRowMinHeight: 80.0,
                // dataRowMaxHeight: 100.0,
                //horizontalMargin: 20,
                  columnSpacing: 0,
                  sortColumnIndex: 1,
                  //showCheckboxColumn: false,
                  border: TableBorder.all(
                      color: const Color(0xFF184f8d), width: 2.0),
                  columns: const [
                    DataColumn(
                        label: Text("Container No.",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Weighment",
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        )),
                    DataColumn(
                        label: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Examination",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        )),
                  ],
                  rows: widget.joorderdata!.data[index].details
                      .map((e) => DataRow(cells: [
                    DataCell(
                      InkWell(
                        onTap: () async {
                          jocontainer = e.containerNo;
                          Globaldata.JOContainer = jocontainer;
                          setState(() {
                            searchJoContainer();
                          });
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.only(right: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              e.containerNo,
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e.weighmentRequired,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e.examination,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ]))
                      .toList())),
        ),
      ],
    )
        : Container();
  }
}

class detailStatus extends StatefulWidget {
  JobContainerstatus? autoGenerate;
  detailStatus({super.key, this.autoGenerate});

  @override
  State<detailStatus> createState() => _detailStatusState();
}
int index=0;
class _detailStatusState extends State<detailStatus> {
  final examinationcontroller = TextEditingController();
  final weighmemcontroller = TextEditingController();
  bool agree = false;
  bool approve = false;
  var newcontainer;
  submitJOstatus() async {
    int index = 0;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('http://103.25.130.254/grfl_login_api/Api/Jostatussubmit'));
    request.body = json.encode({
      "Location": Globaldata.Location,
      "ContainerNo": Globaldata.JOContainer,
      "DocumentNo": Globaldata.JOdocumentno,
      "Shifting_GroundingDone": examinationcontroller.text,
      "WeighmentDone": weighmemcontroller.text,
    });
    request.headers.addAll(headers);
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var parsedata = JoStatusSubmit.fromJson(jsonDecode(responseData));
      if (parsedata.data[index].error == false) {
        examinationcontroller.clear();
        weighmemcontroller.clear();
        agree = false;
        approve = false;
        setState(() {
          Navigator.pop(context);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => joborderdetailsview(
          //       ),
          //     ));
          Globaldata.JOContainer = '';
        });
        Fluttertoast.showToast(
            msg: parsedata.data[index].msg,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: parsedata.data[index].msg,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {});
      }
    } else {
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
        title: Text(
          'Container No. -  ${widget.autoGenerate!.data[index].containerNo}',
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        backgroundColor: const Color(0xFF184f8d),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: MaterialButton(
                onPressed: () {
                  if (approve == false && agree == false) {
                    Fluttertoast.showToast(
                        msg: "Please select status",
                        gravity: ToastGravity.BOTTOM,
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 2,
                        backgroundColor: const Color(0xFF184f8d),
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    submitJOstatus();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
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
          ),
        ],
      ),
      body: Column(
        children: [
          statusSearch(),
        ],
      ),
    );
  }
  statusSearch() {
    if (widget.autoGenerate!.data[index].examination == "Yes" &&
        widget.autoGenerate!.data[index].weighmentRequired == "Yes") {
      if (widget.autoGenerate!.data[index].weighmentdone == 'No' &&
          widget.autoGenerate!.data[index].shiftingGroundingDone == 'No') {
        return Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Request For',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Weighment',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 13.0),
                      child: Text(
                        'Examination',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 5),
                  child:
                  Text(widget.autoGenerate!.data[index].weighmentRequired,
                      style: const TextStyle(
                        fontSize: 18,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 156.0, top: 5),
                  child: Text(widget.autoGenerate!.data[index].examination,
                      style: const TextStyle(
                        fontSize: 18,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Status',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0, top: 5),
                  child: Transform.scale(
                    scale: 1.0,
                    child: Checkbox(
                      value: approve,
                      onChanged: (value) {
                        setState(() {
                          approve = value!;
                        });
                        if (value!) {
                          setState(() {
                            weighmemcontroller.text = '1';
                          });
                        } else {
                          weighmemcontroller.text = '0';
                        }
                      },
                    ),
                  ),
                ),
                const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 13.0),
                      child: Text(
                        'Status',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0, top: 5),
                  child: Transform.scale(
                    scale: 1.0,
                    child: Checkbox(
                      //visualDensity: VisualDensity.compact,
                      value: agree,
                      onChanged: (value) {
                        setState(() {
                          agree = value!;
                        });
                        if (value!) {
                          setState(() {
                            examinationcontroller.text = '1';
                          });
                        } else {
                          examinationcontroller.text = '0';
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text('(Please Click On CheckBox to Update Status)',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ],
        );
      } else if (widget.autoGenerate!.data[index].weighmentdone == 'Yes' &&
          widget.autoGenerate!.data[index].shiftingGroundingDone == 'No') {
        return Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Request For',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 13.0),
                      child: Text(
                        'Examination',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 5),
                  child: Text(widget.autoGenerate!.data[index].examination,
                      style: const TextStyle(
                        fontSize: 18,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 13.0),
                      child: Text(
                        'Status',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0, top: 5),
                  child: Transform.scale(
                    scale: 1.0,
                    child: Checkbox(
                      //visualDensity: VisualDensity.compact,
                      value: agree,
                      onChanged: (value) {
                        setState(() {
                          agree = value!;
                        });
                        if (value!) {
                          setState(() {
                            examinationcontroller.text = '1';
                          });
                        } else {
                          examinationcontroller.text = '0';
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text('(Please Click On CheckBox to Update Status)',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ],
        );
      } else {
        return Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Request For',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 13.0),
                      child: Text(
                        'Weighment',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 5),
                  child:
                  Text(widget.autoGenerate!.data[index].weighmentRequired,
                      style: const TextStyle(
                        fontSize: 18,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 13.0),
                      child: Text(
                        'Status',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0, top: 5),
                  child: Transform.scale(
                    scale: 1.0,
                    child: Checkbox(
                      //visualDensity: VisualDensity.compact,
                      value: agree,
                      onChanged: (value) {
                        setState(() {
                          agree = value!;
                        });
                        if (value!) {
                          setState(() {
                            weighmemcontroller.text = '1';
                          });
                        } else {
                          weighmemcontroller.text = '0';
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text('(Please Click On CheckBox to Update Status)',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ],
        );
      }
    } else if (widget.autoGenerate!.data[index].examination == "Yes" &&
        widget.autoGenerate!.data[index].weighmentRequired == "No") {
      return Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Request For',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 13.0),
                    child: Text(
                      'Examination',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 5),
                child: Text(widget.autoGenerate!.data[index].examination,
                    style: const TextStyle(
                      fontSize: 18,
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 13.0),
                    child: Text(
                      'Status',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 100.0, top: 5),
                child: Transform.scale(
                  scale: 1.0,
                  child: Checkbox(
                    //visualDensity: VisualDensity.compact,
                    value: agree,
                    onChanged: (value) {
                      setState(() {
                        agree = value!;
                      });
                      if (value!) {
                        setState(() {
                          examinationcontroller.text = '1';
                        });
                      } else {
                        examinationcontroller.text = '0';
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text('(Please Click On CheckBox to Update Status)',
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Request For',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 13.0),
                    child: Text(
                      'Weighment',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 5),
                child: Text(widget.autoGenerate!.data[index].weighmentRequired,
                    style: const TextStyle(
                      fontSize: 18,
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 13.0),
                    child: Text(
                      'Status',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 5.0, top: 5),
                child: Transform.scale(
                  scale: 1.0,
                  child: Checkbox(
                    //visualDensity: VisualDensity.compact,
                    value: agree,
                    onChanged: (value) {
                      setState(() {
                        agree = value!;
                      });
                      if (value!) {
                        setState(() {
                          weighmemcontroller.text = '1';
                        });
                      } else {
                        weighmemcontroller.text = '0';
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text('(Please Click On CheckBox to Update Status)',
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ],
      );
    }
  }
}