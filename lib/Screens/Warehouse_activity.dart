// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../Models/Container_validation model.dart';
import '../Models/Esealsuggestion_search.dart';
import '../Models/ILE_Imageupload.dart';
import '../Models/Stuffing_sugestioncontainer.dart';
import '../Models/WarehouseContainer_Info.dart';
import '../universal.dart';

class warehousetab extends StatelessWidget {
  const warehousetab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 10,
            backgroundColor: const Color(0xFF184f8d),
            bottom: const TabBar(
                labelColor: Colors.limeAccent,
                indicatorColor: Colors.limeAccent,
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                tabs: [
                  Tab(
                    text: "Stuffing",
                  ),
                  Tab(text: "Destuffing")
                ]),
          ),
          body: const TabBarView(
            children: [
              stuffContainer(),
              destuffContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

//STUFFING
class Warehouse extends StatefulWidget {
  WarehouseInfo? autoGenerate;
  Warehouse({Key? key, this.autoGenerate}) : super(key: key);

  @override
  State<Warehouse> createState() => _WarehouseState();
}

int index = 0;

class _WarehouseState extends State<Warehouse> {
  Imageupload? parsedata;
  List<Imageupload> list = [];
  String mycontainer = "";
  final TextEditingController sealcontainercontroller = TextEditingController();
  final TextEditingController remarkcontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController enddatecontroller = TextEditingController();
  TextEditingController starttimecontroller = TextEditingController();
  TextEditingController endtimecontroller = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<Players>> key = GlobalKey();
  final labourcontroller = TextEditingController();
  final cranecontroller = TextEditingController();
  final forkliftcontroller = TextEditingController();
  final labourforktroller = TextEditingController();
  final kalmarcontroller = TextEditingController();
  bool labour = false;
  bool crane = false;
  bool forklift = false;
  bool labourfork = false;
  bool kalmar = false;
  File? imageFile;
  ValidContainer? newesealdata;
  final picker = ImagePicker();
  bool Warehouseobject = false;
  String? selectedvalue;
  List<XFile>? selectedImagesList = [];
  asyncFileUpload() async {
    int index = 0;
    var request = http.MultipartRequest(
        "POST", Uri.parse("http://103.25.130.254/grfl_login_api/Api/ILE"));
    request.fields["containerno"] =
        sealcontainercontroller.text.replaceAll(":", "");
    request.fields["activitytype"] = "1";
    request.fields["remarks"] = remarkcontroller.text;
    request.fields["arrivaldate"] = newesealdata!.ileTable[index].arrivalDate;
    request.fields["Location"] = Globaldata.Location;
    Globaldata.ArrivalDate = newesealdata!.ileTable[index].arrivalDate;
    if (Warehouseobject == true) {
      request.files.add(await http.MultipartFile.fromPath('', imageFile!.path));
    } else {
      for (int i = 0; i < selectedImagesList!.length; i++) {
        var newfile = selectedImagesList![i].path;
        request.files.add(await http.MultipartFile.fromPath('', newfile));
      }
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseToString = String.fromCharCodes(responseData);
      var parsedata = Imageupload.fromJson(json.decode(responseToString));
      var message = parsedata.ileTable[index].msg;
      Globaldata.Message = message;
      Fluttertoast.showToast(
          msg: parsedata.ileTable[index].msg,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
      sealcontainercontroller.clear();
      remarkcontroller.clear();
      setState(() {
        imageFile = null;
        selectedImagesList!.clear();
      });
    } else {
      Fluttertoast.showToast(
          msg: Globaldata.Message,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  Pickimage() async {
    var selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        selectedImagesList!.addAll(selectedImages);
        Warehouseobject = false;
      });
    }
  }
  //****Container validate API****/////
  Validation_container() async {
    int index = 0;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET',
        Uri.parse('http://103.25.130.254/grfl_login_api/Api/Checkcontainer'));
    request.body = json.encode({
      "ContainerNo": sealcontainercontroller.text,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      newesealdata = ValidContainer.fromJson(jsonDecode(responseData));
      var mymessage = newesealdata!.ileTable[index].msg;
      Globaldata.validmessage = mymessage;
      Globaldata.ArrivalDate = newesealdata!.ileTable[index].arrivalDate;
      if (newesealdata!.ileTable[index].error == false) {
        Fluttertoast.showToast(
            msg: newesealdata!.ileTable[index].msg,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
        _showPicker;
      } else {
        Fluttertoast.showToast(
            msg: "Container not in inventory",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
      }
      return newesealdata;
    } else {
      Fluttertoast.showToast(
          msg: "Container not in inventory",
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stuffing - ${widget.autoGenerate!.data[index].containerNo} | ${widget.autoGenerate!.data[index].size} | ${widget.autoGenerate!.data[index].type}",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        backgroundColor: const Color(0xFF184f8d),
        //centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
        height: 40,
        child: Row(
          children: [
            Expanded(
                child: MaterialButton(
              onPressed: _showPicker,
              color: Colors.green,
              textColor: Colors.white,
              child: const Text(
                "Take Photo",
                style: TextStyle(fontSize: 18.0),
              ),
            )),
            Expanded(
                child: MaterialButton(
              onPressed: () {
                if (enddatecontroller.text.compareTo(datecontroller.text) < 0) {
                  Fluttertoast.showToast(
                      msg: "End date must be greater than Start date",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 2,
                      backgroundColor: const Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                else if ((datecontroller.text.compareTo(enddatecontroller.text) == 0) && (endtimecontroller.text.compareTo(starttimecontroller.text)<0)) {
                  Fluttertoast.showToast(
                      msg: "End time must be greater than Start time",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 2,
                      backgroundColor: const Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                else if (remarkcontroller.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please fill remark.",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 2,
                      backgroundColor: const Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if ((imageFile == null) || (selectedImagesList == null)) {
                  Fluttertoast.showToast(
                      msg: "Please Upload Image",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: const Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  asyncFileUpload();
                }
              },
              color: Colors.redAccent,
              textColor: Colors.white,
              child: const Text("Upload", style: TextStyle(fontSize: 18.0)),
            )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10.0)),
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
                            //label: Text('Wagon no.'),
                            labelText: 'Shipping Line',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            //alignLabelWithHint: true,
                            hintText: widget
                                .autoGenerate!.data[index].shippingLineName,
                            hintStyle: const TextStyle(
                                fontSize: 14.0, color: Colors.black),
                            labelStyle: const TextStyle(
                                fontSize: 16.0,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      width: 150,
                      child: TextFormField(
                        controller: datecontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Start Date",
                            hintStyle: TextStyle(fontSize: 14.0),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            suffixIcon: const Icon(
                              Icons.calendar_month,
                              color: Color(0xFF184f8d),
                              size: 20,
                            )),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2023), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('dd-MMM-yyyy').format(pickedDate);
                            //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement
                            setState(() {
                              datecontroller.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
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
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      width: 150,
                      child: TextField(
                        controller: enddatecontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "End Date",
                            hintStyle: TextStyle(fontSize: 14.0),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            suffixIcon: const Icon(
                              Icons.calendar_month,
                              color: Color(0xFF184f8d),
                              size: 20,
                            )),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2023), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('dd-MMM-yyyy').format(pickedDate);
                            //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement
                            setState(() {
                              enddatecontroller.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 5.0, right: 5),
                    child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      height: 40,
                      width: 150,
                      child: TextField(
                        controller: starttimecontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Start Time",
                            hintStyle: TextStyle(fontSize: 14.0),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            suffixIcon: const Icon(
                              Icons.access_time,
                              color: Color(0xFF184f8d),
                              size: 20,
                            )),
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null) {
                            //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(picked.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            //output 1970-01-01 22:53:00.000
                            String formattedTime = DateFormat('HH:mm:ss')
                                .format(parsedTime); //output 14:59:00
                            setState(() {
                              starttimecontroller.text =
                                  formattedTime; //set output date to TextField value.
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Time is not selected',
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
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 5.0, right: 5),
                    child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      height: 40,
                      width: 150,
                      child: TextField(
                        controller: endtimecontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "End Time",
                            hintStyle: TextStyle(fontSize: 14.0),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            suffixIcon: const Icon(
                              Icons.access_time,
                              color: Color(0xFF184f8d),
                              size: 20,
                            )),
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null) {
                            //pickedDate output format => 2021-03-10 00:00:00.000//output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(picked.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            setState(() {
                              endtimecontroller.text =
                                  formattedTime; //set output date to TextField value.
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Time is not selected',
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
              ],
            ),
            //Remarks////
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 13.0),
                  child: Text(
                    "Remarks -",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400, // <-- TextField width
                height: 100,
                child: TextField(
                  controller: remarkcontroller,
                  maxLines: 500,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Additional Resources',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Labour',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Checkbox(
                  value: labour,
                  onChanged: (value) {
                    setState(() {
                      labour = value!;
                    });
                    if (value!) {
                      setState(() {
                        labourcontroller.text = '1';
                      });
                    } else {
                      labourcontroller.text = '0';
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 4.0),
                  child: Text(
                    'Crane',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Checkbox(
                  value: crane,
                  onChanged: (value) {
                    setState(() {
                      crane = value!;
                    });
                    if (value!) {
                      setState(() {
                        cranecontroller.text = '1';
                      });
                    } else {
                      cranecontroller.text = '0';
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 4.0),
                  child: Text(
                    'Kalmar',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Checkbox(
                  value: kalmar,
                  onChanged: (value) {
                    setState(() {
                      kalmar = value!;
                    });
                    if (value!) {
                      setState(() {
                        kalmarcontroller.text = '1';
                      });
                    } else {
                      kalmarcontroller.text = '0';
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Labour + Fork lift',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Checkbox(
                  value: labourfork,
                  onChanged: (value) {
                    setState(() {
                      labourfork = value!;
                    });
                    if (value!) {
                      setState(() {
                        labourforktroller.text = '1';
                      });
                    } else {
                      labourforktroller.text = '0';
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 4.0),
                  child: Text(
                    'Fork Lift',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Checkbox(
                  value: forklift,
                  onChanged: (value) {
                    setState(() {
                      forklift = value!;
                    });
                    if (value!) {
                      setState(() {
                        forkliftcontroller.text = '1';
                      });
                    } else {
                      forkliftcontroller.text = '0';
                    }
                  },
                ),
              ],
            ),
            //imageshow///
            Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 5.0, left: 8.0)),
                Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Builder(builder: (context) {
                      if ((Warehouseobject != true)) {
                        return selectedImagesList != null
                            ? SizedBox(
                                height: 300,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5,
                                          crossAxisSpacing: 4),
                                  itemCount: selectedImagesList!.length,
                                  itemBuilder: (context, int index) {
                                    return Stack(
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Image.file(File(
                                              selectedImagesList![index].path)),
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
                                                onPressed: () => setState(() {
                                                      selectedImagesList!
                                                          .removeAt(index);
                                                    })))
                                      ],
                                    );
                                  },
                                ),
                              )
                            : Container();
                      } else {
                        return imageFile != null
                            ? SizedBox(
                                height: 200,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      height: 80,
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
                                            onPressed: () => setState(() {
                                                  imageFile = null;
                                                })))
                                  ],
                                ),
                              )
                            : Container();
                      }
                    }))
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future _showPicker() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(10.0),
              shape: Border.all(color: Colors.red, width: 2),
              title: const Text(
                'Select Image Source',
              ),
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child:
                        const Text('Gallery', style: TextStyle(fontSize: 20.0)),
                    onTap: () {
                      Navigator.of(context).pop();
                      Pickimage();
                      //openGallery();
                      //setState(() {});
                      //Navigator.pop(context);
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10.0)),
                  GestureDetector(
                    child: const Text('Camera',
                        style: TextStyle(fontSize: 20.0, color: Colors.red)),
                    onTap: () {
                      Navigator.of(context).pop();
                      openCamera();
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10.0)),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
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
  //select image from camera
  openCamera() async {
    var pickedFile =
        (await picker.pickImage(source: ImageSource.camera, imageQuality: 25));
    setState(() {
      imageFile = File(pickedFile!.path);
      Warehouseobject = true;
    });
  }
  Future<void> openGallery() async {
    var pickedFile =
        (await picker.pickImage(source: ImageSource.gallery, imageQuality: 25));
    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }
}

//DESTUFFING/////
class destuffWarehouse extends StatefulWidget {
  WarehouseInfo? autoGenerate;
  destuffWarehouse({Key? key, this.autoGenerate}) : super(key: key);

  @override
  State<destuffWarehouse> createState() => _destuffWarehouseState();
}

int indexx = 0;

class _destuffWarehouseState extends State<destuffWarehouse> {
  Imageupload? parsedata;
  List<Imageupload> list = [];
  String mycontainer = "";
  final TextEditingController sealcontainercontroller = TextEditingController();
  final TextEditingController remarkcontroller = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  TextEditingController starttimecontroller = TextEditingController();
  TextEditingController endtimecontroller = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<Players>> key = GlobalKey();
  final labourcontroller = TextEditingController();
  final cranecontroller = TextEditingController();
  final forkliftcontroller = TextEditingController();
  final labourforktroller = TextEditingController();
  final kalmarcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKeys = GlobalKey<FormState>();
  bool labour = false;
  bool crane = false;
  bool forklift = false;
  bool labourfork = false;
  bool kalmar = false;
  File? imageFile;
  ValidContainer? newesealdata;
  final picker = ImagePicker();
  bool Warehouseobject = false;
  String? selectedvalue;
  var warehousenewdata;
  List<XFile>? selectedImagesList = [];
  asyncFileUpload() async {
    int index = 0;
    var request = http.MultipartRequest(
        "POST", Uri.parse("http://103.25.130.254/grfl_login_api/Api/ILE"));
    request.fields["containerno"] =
        sealcontainercontroller.text.replaceAll(":", "");
    request.fields["activitytype"] = "2";
    request.fields["remarks"] = remarkcontroller.text;
    request.fields["arrivaldate"] = newesealdata!.ileTable[index].arrivalDate;
    request.fields["Location"] = Globaldata.Location;
    Globaldata.ArrivalDate = newesealdata!.ileTable[index].arrivalDate;
    if (Warehouseobject == true) {
      request.files.add(await http.MultipartFile.fromPath('', imageFile!.path));
    } else {
      for (int i = 0; i < selectedImagesList!.length; i++) {
        var newfile = selectedImagesList![i].path;
        request.files.add(await http.MultipartFile.fromPath('', newfile));
      }
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseToString = String.fromCharCodes(responseData);
      var parsedata = Imageupload.fromJson(json.decode(responseToString));
      var message = parsedata.ileTable[index].msg;
      Globaldata.Message = message;
      Fluttertoast.showToast(
          msg: parsedata.ileTable[index].msg,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
      sealcontainercontroller.clear();
      remarkcontroller.clear();
      setState(() {
        imageFile = null;
        selectedImagesList!.clear();
      });
    } else {
      Fluttertoast.showToast(
          msg: Globaldata.Message,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  Pickimage() async {
    var selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        selectedImagesList!.addAll(selectedImages);
        Warehouseobject = false;
      });
    }
  }
  //****Container validate API****/////
  Validation_container() async {
    int index = 0;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET',
        Uri.parse('http://103.25.130.254/grfl_login_api/Api/Checkcontainer'));
    request.body = json.encode({
      "ContainerNo": sealcontainercontroller.text,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      newesealdata = ValidContainer.fromJson(jsonDecode(responseData));
      var mymessage = newesealdata!.ileTable[index].msg;
      Globaldata.validmessage = mymessage;
      Globaldata.ArrivalDate = newesealdata!.ileTable[index].arrivalDate;
      if (newesealdata!.ileTable[index].error == false) {
        Fluttertoast.showToast(
            msg: newesealdata!.ileTable[index].msg,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
        _showPicker();
      } else {
        Fluttertoast.showToast(
            msg: "Container not in inventory",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
      }
      return newesealdata;
    } else {
      Fluttertoast.showToast(
          msg: "Container not in inventory",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  //Container Details///
  Containerdetails() async {
    int index = 0;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/Warehouse'));
    request.body = json.encode({
      "Location": Globaldata.Location,
      "ContainerNo": Globaldata.Warehousecontainer,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      warehousenewdata = responseData;
      var updatedata = WarehouseInfo.fromJson(jsonDecode(warehousenewdata));
      if (updatedata.data[index].error == false) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => destuffWarehouse(
                autoGenerate: updatedata,
              ),
            ));
        _showPicker();
      } else {
        Fluttertoast.showToast(
            msg: "Container not in inventory",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
      }
      return warehousenewdata;
    } else {
      Fluttertoast.showToast(
          msg: "Container not in inventory",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  DateTime? startDate, endData;
  //start date validator//
  Text startDateValidator(value) {
    if (startDate == null) {
    }
    return Text("select date");
  }

  String? endDateValidator(value) {
    // if (startDate != null && endData == null) {
    //   return "select Both data";
    // }
    if (endData == null) return "select the date";
    print(startDate);
    if (endData!.isBefore(startDate!)) {
      return 'End date after startDate ';
    }
    return null;
  }

  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2999),
    );
  }

  Future<TimeOfDay?> pickTime() async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Destuffing - ${widget.autoGenerate!.data[index].containerNo} | ${widget.autoGenerate!.data[index].size} | ${widget.autoGenerate!.data[index].type}",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        backgroundColor: const Color(0xFF184f8d),
        //centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
        height: 40,
        child: Row(
          children: [
            Expanded(
                child: MaterialButton(
              onPressed: _showPicker,
              color: Colors.green,
              textColor: Colors.white,
              child: const Text(
                "Take Photo",
                style: TextStyle(fontSize: 18.0),
              ),
            )),
            Expanded(
                child: MaterialButton(
              onPressed: () {
                if (endDateController.text.compareTo(startDateController.text) < 0) {
                  Fluttertoast.showToast(
                      msg: "End date must be greater than Start date",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 2,
                      backgroundColor: const Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                else if ((startDateController.text.compareTo(endDateController.text) == 0) && (endtimecontroller.text.compareTo(starttimecontroller.text)<0)) {
                  Fluttertoast.showToast(
                      msg: "End time must be greater than Start time",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 2,
                      backgroundColor: const Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                else if (remarkcontroller.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please fill remark.",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 2,
                      backgroundColor: const Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if ((imageFile == null) ||
                    (selectedImagesList == null)) {
                  Fluttertoast.showToast(
                      msg: "Please Upload Image",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: const Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  asyncFileUpload();
                }
              },
              color: Colors.redAccent,
              textColor: Colors.white,
              child: const Text("Upload", style: TextStyle(fontSize: 18.0)),
            )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10.0)),
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
                            //label: Text('Wagon no.'),
                            labelText: 'Shipping Line',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            //alignLabelWithHint: true,
                            hintText: widget.autoGenerate!.data[index]
                                    .shippingLineName.isEmpty
                                ? ''
                                : widget
                                    .autoGenerate!.data[index].shippingLineName,
                            hintStyle: const TextStyle(
                                fontSize: 14.0, color: Colors.black),
                            labelStyle: const TextStyle(
                                fontSize: 16.0,
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
            Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        width: 150,
                        child: TextFormField(
                          controller: startDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Start Date",
                              hintStyle: TextStyle(fontSize: 14.0),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              suffixIcon: const Icon(
                                Icons.calendar_month,
                                color: Color(0xFF184f8d),
                                size: 20,
                              )),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2023), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                              DateFormat('dd-MMM-yyyy').format(pickedDate);
                              //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement
                              setState(() {
                                startDateController.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
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
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        width: 150,
                        child: TextField(
                          controller: endDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "End Date",
                              hintStyle: TextStyle(fontSize: 14.0),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              suffixIcon: const Icon(
                                Icons.calendar_month,
                                color: Color(0xFF184f8d),
                                size: 20,
                              )),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2023), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                              DateFormat('dd-MMM-yyyy').format(pickedDate);
                              //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement
                              setState(() {
                                endDateController.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
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
                ],
              ),
            ),
            Form(
              key: _formKeys,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, top: 5.0, right: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        height: 40,
                        width: 150,
                        child: TextFormField(
                          controller: starttimecontroller,
                          readOnly: true,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Start Time",
                              fillColor: Colors.white,
                              hintStyle: TextStyle(fontSize: 14.0),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              suffixIcon: const Icon(
                                Icons.access_time,
                                color: Color(0xFF184f8d),
                                size: 20,
                              )),
                          onTap: () async {
                            TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              //output 10:51 PM
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(picked.format(context).toString());
                              //converting to DateTime so that we can further format on different pattern.
                              var starttime =
                                  DateFormat('HH:mm:ss').format(parsedTime);
                              setState(() {
                                starttimecontroller.text =
                                    starttime; //set output date to TextField value.
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Time is not selected',
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
                      padding:
                          const EdgeInsets.only(left: 10.0, top: 5.0, right: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        height: 40,
                        width: 150,
                        child: TextFormField(
                          controller: endtimecontroller,
                          readOnly: true,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "End Time",
                              fillColor: Colors.white,
                              hintStyle: TextStyle(fontSize: 14.0),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              suffixIcon: const Icon(
                                Icons.access_time,
                                color: Color(0xFF184f8d),
                                size: 20,
                              )),
                          onTap: () async {
                            TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              //pickedDate output format => 2021-03-10 00:00:00.000//output 10:51 PM
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(picked.format(context).toString());
                              //converting to DateTime so that we can further format on different pattern.
                              var endtime =
                                  DateFormat('HH:mm:ss').format(parsedTime);
                              setState(() {
                                endtimecontroller.text =
                                    endtime; //set output date to TextField value.
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Time is not selected',
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
                  )
                ],
              ),
            ),
            //Remarks////
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 13.0,top: 10),
                  child: Text(
                    "Remarks -",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400, // <-- TextField width
                height: 100,
                child: TextField(
                  controller: remarkcontroller,
                  maxLines: 500,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Additional Resources',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Labour',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Checkbox(
                  value: labour,
                  onChanged: (value) {
                    setState(() {
                      labour = value!;
                    });
                    if (value!) {
                      setState(() {
                        labourcontroller.text = '1';
                      });
                    } else {
                      labourcontroller.text = '0';
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 4.0),
                  child: Text(
                    'Crane',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Checkbox(
                  value: crane,
                  onChanged: (value) {
                    setState(() {
                      crane = value!;
                    });
                    if (value!) {
                      setState(() {
                        cranecontroller.text = '1';
                      });
                    } else {
                      cranecontroller.text = '0';
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 4.0),
                  child: Text(
                    'Kalmar',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Checkbox(
                  value: kalmar,
                  onChanged: (value) {
                    setState(() {
                      kalmar = value!;
                    });
                    if (value!) {
                      setState(() {
                        kalmarcontroller.text = '1';
                      });
                    } else {
                      kalmarcontroller.text = '0';
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Labour + Fork Lift',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Checkbox(
                  value: labourfork,
                  onChanged: (value) {
                    setState(() {
                      labourfork = value!;
                    });
                    if (value!) {
                      setState(() {
                        labourforktroller.text = '1';
                      });
                    } else {
                      labourforktroller.text = '0';
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 4.0),
                  child: Text(
                    'Fork Lift',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Checkbox(
                  value: forklift,
                  onChanged: (value) {
                    setState(() {
                      forklift = value!;
                    });
                    if (value!) {
                      setState(() {
                        forkliftcontroller.text = '1';
                      });
                    } else {
                      forkliftcontroller.text = '0';
                    }
                  },
                ),
              ],
            ),
            //imageshow//
            Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 5.0, left: 8.0)),
                Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Builder(builder: (context) {
                      if ((Warehouseobject != true)) {
                        return selectedImagesList != null
                            ? SizedBox(
                                height: 300,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5,
                                          crossAxisSpacing: 4),
                                  itemCount: selectedImagesList!.length,
                                  itemBuilder: (context, int index) {
                                    return Stack(
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Image.file(File(
                                              selectedImagesList![index].path)),
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
                                                onPressed: () => setState(() {
                                                      selectedImagesList!
                                                          .removeAt(index);
                                                    })))
                                      ],
                                    );
                                  },
                                ),
                              )
                            : Container();
                      } else {
                        return imageFile != null
                            ? SizedBox(
                                height: 200,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      height: 80,
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
                                            onPressed: () => setState(() {
                                                  imageFile = null;
                                                })))
                                  ],
                                ),
                              )
                            : Container();
                      }
                    }))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future _showPicker() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(10.0),
              shape: Border.all(color: Colors.red, width: 2),
              title: const Text(
                'Select Image Source',
              ),
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child:
                        const Text('Gallery', style: TextStyle(fontSize: 20.0)),
                    onTap: () {
                      Navigator.of(context).pop();
                      Pickimage();
                      //openGallery();
                      //setState(() {});
                      //Navigator.pop(context);
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10.0)),
                  GestureDetector(
                    child: const Text('Camera',
                        style: TextStyle(fontSize: 20.0, color: Colors.red)),
                    onTap: () {
                      Navigator.of(context).pop();
                      openCamera();
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10.0)),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
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

  //select image from camera
  Future<void> openCamera() async {
    var pickedFile =
        (await picker.pickImage(source: ImageSource.camera, imageQuality: 25));
    if (mounted) {
      setState(() {
        imageFile = File(pickedFile!.path);
        Warehouseobject = true;
      });
    }
  }

  Future<void> openGallery() async {
    var pickedFile =
        (await picker.pickImage(source: ImageSource.gallery, imageQuality: 25));
    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }
}

//*****CAPITAL LETTERS FORMAT****////
class destuffContainer extends StatefulWidget {
  const destuffContainer({super.key});
  @override
  State<destuffContainer> createState() => _destuffContainerState();
}

class _destuffContainerState extends State<destuffContainer> {
  GlobalKey<AutoCompleteTextFieldState<Players>> key = GlobalKey();
  late AutoCompleteTextField searchTextField;
  TextEditingController controller = TextEditingController();
  final PlayersViewModel newdata = PlayersViewModel();
  var warehousenewdata;
  Containerdetails() async {
    int index = 0;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/Warehouse'));
    request.body = json.encode({
      "Location": Globaldata.Location,
      "ContainerNo": Globaldata.Warehousecontainer,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      warehousenewdata = responseData;
      var updatedata = WarehouseInfo.fromJson(jsonDecode(warehousenewdata));
      if (updatedata.data[index].error == false) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => destuffWarehouse(
                autoGenerate: updatedata,
              ),
            ));
        // Fluttertoast.showToast(
        //     msg: updatedata.data[index].msg,
        //     gravity: ToastGravity.BOTTOM,
        //     toastLength: Toast.LENGTH_SHORT,
        //     timeInSecForIosWeb: 2,
        //     backgroundColor: const Color(0xFF184f8d),
        //     textColor: Colors.white,
        //     fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Container not in inventory",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
      }
      return warehousenewdata;
    } else {
      Fluttertoast.showToast(
          msg: "Container not in inventory",
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
    newdata.loadPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Container Details",
      //     style: TextStyle(
      //       fontSize: 19.0,
      //     ),
      //   ),
      //   backgroundColor: Color(0xFF184f8d),
      //   //centerTitle: true,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 13.0),
                child: Text(
                  "Container No. -",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  height: 30,
                  width: 150,
                  child: searchTextField = AutoCompleteTextField<Players>(
                      style:
                          const TextStyle(color: Colors.black, fontSize: 18.0),
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                          //hintText: Globaldata.Warehousecontainer,
                          hintStyle: TextStyle(color: Colors.black)),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11), // for mobile
                      ],
                      itemSubmitted: (item) {
                        setState(() {
                          searchTextField.textField?.controller?.text =
                              item.containerNo;
                          Globaldata.Warehousecontainer =
                              searchTextField.textField!.controller!.text;
                          Containerdetails();
                          searchTextField.textField!.controller!.text = '';
                          setState(() {});
                          //imageFile=null;
                        });
                      },
                      clearOnSubmit: false,
                      key: key,
                      suggestions: newdata.Data,
                      itemBuilder: (context, item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              item.containerNo,
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ],
                        );
                      },
                      itemSorter: (a, b) {
                        return a.containerNo.compareTo(b.containerNo);
                      },
                      itemFilter: (item, enteredkeyword) {
                        return item.containerNo
                            .toLowerCase()
                            .contains(enteredkeyword.toLowerCase());
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

///Stuff Container////
class stuffContainer extends StatefulWidget {
  const stuffContainer({super.key});
  @override
  State<stuffContainer> createState() => _stuffContainerState();
}

class _stuffContainerState extends State<stuffContainer> {
  GlobalKey<AutoCompleteTextFieldState<stuffing>> key = GlobalKey();
  late AutoCompleteTextField searchTextField;
  TextEditingController controller = TextEditingController();
  final StuffingViewModel newdata = StuffingViewModel();
  var warehousenewdata;
  Containerdetails() async {
    int index = 0;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/Warehouse'));
    request.body = json.encode({
      "Location": Globaldata.Location,
      "ContainerNo": Globaldata.Warehousecontainer,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      warehousenewdata = responseData;
      var updatedata = WarehouseInfo.fromJson(jsonDecode(warehousenewdata));
      if (updatedata.data[index].error == false) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Warehouse(
                autoGenerate: updatedata,
              ),
            ));
        // Fluttertoast.showToast(
        //     msg: updatedata.data[index].msg,
        //     gravity: ToastGravity.BOTTOM,
        //     toastLength: Toast.LENGTH_SHORT,
        //     timeInSecForIosWeb: 2,
        //     backgroundColor: const Color(0xFF184f8d),
        //     textColor: Colors.white,
        //     fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Container not in inventory",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
      }
      return warehousenewdata;
    } else {
      Fluttertoast.showToast(
          msg: "Container not in inventory",
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
    newdata.loadstuffing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Container Details",
      //     style: TextStyle(
      //       fontSize: 19.0,
      //     ),
      //   ),
      //   backgroundColor: Color(0xFF184f8d),
      //   //centerTitle: true,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 13.0),
                child: Text(
                  "Container No. -",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  height: 30,
                  width: 150,
                  child: searchTextField = AutoCompleteTextField<stuffing>(
                      style:
                          const TextStyle(color: Colors.black, fontSize: 18.0),
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                          //hintText: Globaldata.Warehousecontainer,
                          hintStyle: TextStyle(color: Colors.black)),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11), // for mobile
                      ],
                      itemSubmitted: (item) {
                        setState(() {
                          searchTextField.textField?.controller?.text =
                              item.containerNo;
                          Globaldata.Warehousecontainer =
                              searchTextField.textField!.controller!.text;
                          Containerdetails();
                          searchTextField.textField!.controller!.text = '';
                          setState(() {});
                          //imageFile=null;
                        });
                      },
                      clearOnSubmit: false,
                      key: key,
                      suggestions: newdata.Data,
                      itemBuilder: (context, item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              item.containerNo,
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ],
                        );
                      },
                      itemSorter: (a, b) {
                        return a.containerNo.compareTo(b.containerNo);
                      },
                      itemFilter: (item, enteredkeyword) {
                        return item.containerNo
                            .toLowerCase()
                            .contains(enteredkeyword.toLowerCase());
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
