import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:super_app/universal.dart';
import '../Models/JO_Model.dart';
import 'package:http/http.dart'as http;
import '../Models/JO_detailsdata.dart';
import '../Models/Jo_submitdata_model.dart';
import 'Grounding_Status.dart';

class dropdownscreen extends StatefulWidget {
  dropdownscreen({super.key});

  @override
  State<dropdownscreen> createState() => _dropdownscreenState();
}

class _dropdownscreenState extends State<dropdownscreen> {


  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
          debugShowCheckedModeBanner: false,
          home:
          DefaultTabController(length: 2,
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
                      Tab( text: "Request",),
                      Tab( text: "Status Update")
                    ]),
              ),
              body:   TabBarView(
                children:[
                 shippingData(),
                  const Nestedtabbar(),
                ],
              ),
            ),
          )
      );
  }
}



class shippingData extends StatefulWidget {
  JoDatadetails? loaddata;
   shippingData({super.key,  this.loaddata,});
  @override
  State<shippingData> createState() => _shippingDataState();
}
class _shippingDataState extends State<shippingData> {
  GlobalKey<AutoCompleteTextFieldState<jovalue>> key = GlobalKey();
  late AutoCompleteTextField searchTextField;
  TextEditingController controller = TextEditingController();
  final joData myjoData = joData();
  final examinationcontroller = TextEditingController();
  final weighmemcontroller = TextEditingController();
  bool agree = false;
  bool approve = false;
  bool isLoading = true;
  JoDatadetails?loaddata;
  getJodetails() async {
    int index=0;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/JoDetails'));
    request.body = json.encode({
      "DocumentNo":  searchTextField.textField?.controller?.text,
      "Location": Globaldata.Location
    });
    request.headers.addAll(headers);
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var  newjodata = JoDatadetails.fromJson(jsonDecode(responseData));
      if (newjodata.data[index].error==false) {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              joDetailsdata(loaddata: newjodata,)));
          setState(() {
            searchTextField.textField?.controller?.text='';
          });
          // code to be executed after 2 seconds
      }
      else {
        Fluttertoast.showToast(
            msg: newjodata.data[index].msg,
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
    myjoData.loadjodata().then((value) {
      setState(() {
        myjoData.myData;
        isLoading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0,left: 5.0),
        child: isLoading?const Center(child: CircularProgressIndicator(strokeWidth: 4,)):
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Job Order : ",
                    style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  // flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0,left: 15.0),
                    child: Container(
                      height: 35,
                      width: 210,
                      child:
                      searchTextField = AutoCompleteTextField<jovalue>(
                          style:
                              const TextStyle(color: Colors.black, fontSize: 17.0),
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5.0)),
                            contentPadding: EdgeInsets.only(left: 10.0,top: 5.0,bottom: 10.0),
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(11), // for mobile
                          ],
                          itemSubmitted: (item) {
                            setState(() {
                              searchTextField.textField?.controller?.text = item.documentno;
                              getJodetails();
                            });
                          },
                          clearOnSubmit: false,
                          key: key,
                          suggestions: myjoData.myData,
                          itemBuilder: (context, e) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  e.documentno,
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                              ],
                            );
                          },
                          itemSorter: (a, b) {
                            return a.documentno.compareTo(b.documentno);
                          },
                          itemFilter: (query, enteredkeyword) {
                            return query.documentno
                                .toLowerCase()
                                .contains(enteredkeyword.toLowerCase());
                          }),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}



class joDetailsdata extends StatefulWidget {
  JoDatadetails? loaddata;
   joDetailsdata({super.key,this.loaddata});

  @override
  State<joDetailsdata> createState() => _joDetailsdataState();
}

class _joDetailsdataState extends State<joDetailsdata> {
  GlobalKey<AutoCompleteTextFieldState<jovalue>> key = GlobalKey();
  late AutoCompleteTextField searchTextField;
  TextEditingController controller = TextEditingController();
  final joData myjoData = joData();
  final examinationcontroller = TextEditingController();
  final weighmemcontroller = TextEditingController();
  bool agree = false;
  bool approve = false;
  JoDatadetails?loaddata;
  submitJOdetails() async {
    int index = 0;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://103.25.130.254/grfl_login_api/Api/Josubmit'));
    request.body = json.encode({
      "Location": Globaldata.Location,
      "DocumentNo": widget.loaddata!.data[index].documentno,
      "Examination": examinationcontroller.text,
      "WeighmentRequired": weighmemcontroller.text,
    });
    request.headers.addAll(headers);
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var  parsedata = JoDatasubmit.fromJson(jsonDecode(responseData));
      if (parsedata.data[index].error == false) {
          widget.loaddata!.data[index].documentno='';
          widget.loaddata!.data[index].date='';
          widget.loaddata!.data[index].igmLineno='';
          widget.loaddata!.data[index].igmno='';
          widget.loaddata!.data[index].boeDate='';
          widget.loaddata!.data[index].boeno='';
          widget.loaddata!.data[index].consigneeName='';
          examinationcontroller.clear();
          weighmemcontroller.clear();
          agree=false;
        Fluttertoast.showToast(
            msg: parsedata.data[index].msg,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              dropdownscreen()));

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
  void initState() {
    super.initState();
    myjoData.loadjodata().then((value) {
      setState(() {
        myjoData.myData;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request',
          style: TextStyle(
            fontSize: 19.0,
          ),
        ),
        backgroundColor: const Color(0xFF184f8d),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
              child: SizedBox(height: 40,child:  MaterialButton(
                onPressed: () {
                  if(approve==false && agree==false){
                    Fluttertoast.showToast(
                        msg: "Please Select Any Request",
                        gravity: ToastGravity.BOTTOM,
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 2,
                        backgroundColor: const Color(0xFF184f8d),
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else{
                    submitJOdetails();
                  }

                },
                elevation: 10.0,
                color: const Color(0xFF184f8d),
                textColor: Colors.white,
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),),

          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0,left: 5.0),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            detailData(context),
          ],
        ),
      ),
    );
  }
  Widget detailData(BuildContext context) {
    int index=0;
    return widget.loaddata?.data[index].error==false ?
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  height: 35,
                  width: 165,
                  child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        //label: Text('Wagon no.'),
                        labelText: 'Document No.',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        //alignLabelWithHint: true,
                        hintText: widget.loaddata!.data[index].documentno,
                        hintStyle: const TextStyle(
                            fontSize: 14.0, color: Colors.black,fontWeight: FontWeight.w400),
                        labelStyle: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        contentPadding: const EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      )),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child:
                SizedBox(
                  height: 35,
                  width:100,
                  child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        //label: Text('Wagon no.'),
                        labelText: 'Date',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        //alignLabelWithHint: true,
                        hintText: widget.loaddata!.data[index].date,
                        hintStyle: const TextStyle(
                            fontSize: 14.0, color: Colors.black,fontWeight: FontWeight.w400),
                        labelStyle: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        contentPadding: const EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  height: 35,
                  width: 95,
                  child: TextField(
                      readOnly: true,
                      //controller: phywagoncontrooler,
                      decoration: InputDecoration(
                        labelText: "IGM No.",
                        hintText: widget.loaddata!.data[index].igmno.isEmpty?'':widget.loaddata!.data[index].igmno,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: const TextStyle(
                            fontSize: 14.0, color: Colors.black,fontWeight: FontWeight.w400),
                        labelStyle: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        contentPadding: const EdgeInsets.all(6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      )),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SizedBox(
                  height: 35,
                  width: 95,
                  child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                          labelText: "IGM Line No.",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: widget.loaddata!.data[index].igmLineno,
                          hintStyle: const TextStyle(
                              fontSize: 14.0, color: Colors.black,fontWeight: FontWeight.w400),
                          labelStyle: const TextStyle(fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          contentPadding: const EdgeInsets.all(5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ))),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SizedBox(
                  height: 35,
                  width: 95,
                  child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                          labelText: "IGM Date",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: widget.loaddata!.data[index].igmDate,
                          hintStyle: const TextStyle(
                              fontSize: 14.0, color: Colors.black,fontWeight: FontWeight.w400),
                          labelStyle: const TextStyle(fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          contentPadding: const EdgeInsets.all(5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ))),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 35,
                width: 95,
                child: TextField(
                    readOnly: true,
                  //controller: phycustomscontrooler,
                    decoration: InputDecoration(
                      labelText: "BOE No.",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: widget.loaddata!.data[index].boeno,
                      hintStyle: const TextStyle(
                          fontSize: 14.0, color: Colors.black,fontWeight: FontWeight.w400),
                      labelStyle: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SizedBox(
                height: 35,
                width: 100,
                child: TextField(
                    readOnly: true,
                  //controller: phycustomscontrooler,
                    decoration: InputDecoration(
                      labelText: "BOE Date",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: widget.loaddata!.data[index].boeDate,
                      hintStyle: const TextStyle(
                          fontSize: 14.0, color: Colors.black,fontWeight: FontWeight.w400),
                      labelStyle: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )),
              ),
            ),
          ),
        ]),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SizedBox(
                  height: 45,
                  child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Consignee Name",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: widget.loaddata!.data[index].consigneeName,
                        hintMaxLines: 4,
                        hintStyle: const TextStyle(
                          fontSize: 15.0, color: Colors.black,fontWeight: FontWeight.w400,),
                        labelStyle: const TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold),
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
        statusContainer(),
      ],
    ):Container();
  }
  statusContainer() {
    int index=0;
    if (widget.loaddata!.data[index].examination == "NO" &&
        widget.loaddata!.data[index].weighmentRequired == "NO") {
        return Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Service Request',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left:8.0),
                      child:
                      Text(
                        'Weighment',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )),
                Padding(
                  padding:  const EdgeInsets.only(right: 5.0, top: 5),
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
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 13.0),
                      child: Text(
                        'Examination',
                        style:
                        TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          ],
        );
      }
      else if (widget.loaddata!.data[index].examination == 'NO') {
        return Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Service Request',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:  const EdgeInsets.only(right: 5.0, top: 5),
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
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 13.0),
                      child: Text(
                        'Examination',
                        style:
                        TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          ],
        );
      }
      else  {
        return Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Service Request',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:  const EdgeInsets.only(right: 5.0, top: 5),
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
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 13.0),
                      child: Text(
                        'Weighment',
                        style:
                        TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 10,),
          ],
        );
      }
    }
    }






