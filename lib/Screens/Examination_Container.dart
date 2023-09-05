
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class dropdownExam extends StatelessWidget {
  const dropdownExam({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "",
                style: TextStyle(fontSize: 17),
              ),
              centerTitle: true,
              toolbarHeight: 15,
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
                      text: "Import",
                    ),
                    Tab(text: "Export")
                  ]),
            ),
            body: const TabBarView(
              children: [
                Nestedtabbar(),
                // exportRakesurvey()
              ],
            ),
          ),
        ));
  }
}

class Nestedtabbar extends StatefulWidget {
  const Nestedtabbar({super.key});

  @override
  State<Nestedtabbar> createState() => _NestedtabbarState();
}

class _NestedtabbarState extends State<Nestedtabbar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 1,
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
                  text: "Container No.",
                ),
                Tab(text: "Job Order")
              ]),
        ),
        body:  const TabBarView(
            children: [
              containerInfo(),
              //joGroundingserach()
            ]),
      ),
    );
  }
}
class containerInfo extends StatefulWidget {
  const containerInfo({super.key});

  @override
  State<containerInfo> createState() => _containerInfoState();
}

class _containerInfoState extends State<containerInfo> {
  final containercontroller =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      const containerDetails()));
                  // if (approve == false && agree == false) {
                  //   Fluttertoast.showToast(
                  //       msg: "Please select status",
                  //       gravity: ToastGravity.BOTTOM,
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       timeInSecForIosWeb: 2,
                  //       backgroundColor: const Color(0xFF184f8d),
                  //       textColor: Colors.white,
                  //       fontSize: 16.0);
                  // } else {
                  //   submitJOstatus();
                  // }
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  child: Text(
                    "Container No. :  ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                ),
                Flexible(
                  //flex: 1,
                  child: Container(
                    height: 35,
                    width: 170,
                    child: TextFormField(
                      controller: containercontroller,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 18.0),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(5.0)),
                          contentPadding:
                          const EdgeInsets.only(bottom: 15.0, left: 10.0),
                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                              11), // for mobile
                        ],
                       ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class containerDetails extends StatefulWidget {
  const containerDetails({super.key});
  @override
  State<containerDetails> createState() => _containerDetailsState();
}
class _containerDetailsState extends State<containerDetails> {
  final resourcecontroller =  TextEditingController();
  final contractorcontroller =  TextEditingController();
  final packagecontroller =  TextEditingController();
  TextEditingController startdatecontroller = TextEditingController();
  TextEditingController enddatecontroller = TextEditingController();
  TextEditingController starttimecontroller = TextEditingController();
  TextEditingController endtimecontroller = TextEditingController();
  final picker = ImagePicker();
  File? imageFile;
  bool Warehouseobject = false;
  List<XFile>? selectedImagesList = [];
  String? lineCourseValue = "";
  List dropDownListData = [
    {"title": "Upto 50 %", "value": "1"},
    {"title": "Above 50 %", "value": "2"},
    {"title": "None", "value": "3"},
    {"title": "Upto 10 %", "value": "4"},
    {"title": "Above 10 %", "value": "5"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text("NLLU2717028 | 20' | DRY",style: TextStyle(
              fontSize: 16.0,
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Tare wt : 2.32",style: TextStyle(
                  fontSize: 12.0,
                ),),
                Padding(
                  padding: EdgeInsets.only(left: 3.0),
                  child: Text("Net wt : 100",style: TextStyle(
                    fontSize: 12.0,
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.only(left:3.0),
                  child: Text("Gross wt : 100 (In MT)",style: TextStyle(
                    fontSize: 12.0,
                  ),),
                ),
              ],
            )
          ],
        ),
        backgroundColor: const Color(0xFF184f8d),
      ),
      bottomNavigationBar:  SizedBox(
        height: 40,
        child: Row(
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () {
                 _showPicker();
                },
                elevation: 10.0,
                color: Colors.green,
                textColor: Colors.white,
                child: const Text(
                  "Take Photo",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  //submitContainerdetails();
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                  //     getcontainer()));
                },
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10.0),
                //     side: const BorderSide(color: Colors.black)),
                elevation: 10.0,
                color: Colors.redAccent,
                textColor: Colors.white,
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child:
                  Text("Seal No. : ",style: TextStyle(
                    fontSize: 15.0,fontWeight: FontWeight.w500
                  ),),
                ),
                Text("12345",style: TextStyle(
                  fontSize: 15.0,
                ),),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child:
                  Text("Dec. Package : ",style: TextStyle(
                    fontSize: 15.0,fontWeight: FontWeight.w500
                  ),),
                ),
                Text("12345",style: TextStyle(
                  fontSize: 15.0,
                ),),
              ],
            ),
            const SizedBox(height: 5,),
           const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:5.0),
                  child:
                  Text("IGM No. : ",style: TextStyle(
                    fontSize: 15.0,fontWeight: FontWeight.w500
                  ),),
                ),
                Text("12345",style: TextStyle(
                  fontSize: 15.0,
                ),),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child:
                  Text("IGM Line No.  : ",style: TextStyle(
                    fontSize: 15.0,fontWeight: FontWeight.w500
                  ),),
                ),
                Text("12345",style: TextStyle(
                  fontSize: 15.0,
                ),),
              ],

            ),
            const SizedBox(height: 5,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child:
                  Text("BL No.    : ",style: TextStyle(
                      fontSize: 15.0,fontWeight: FontWeight.w500
                  ),),
                ),
                Text("12345",style: TextStyle(
                  fontSize: 15.0,
                ),),
                Padding(
                  padding: const EdgeInsets.only(left:25.0),
                  child:
                  Text("BL Date           : ",style: TextStyle(
                    fontSize: 15.0,fontWeight: FontWeight.w500
                  ),),
                ),
                Text("06-Dec-2023",style: TextStyle(
                    fontSize: 15.0,
                ),),
              ],
            ),
            const SizedBox(height: 5,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:5.0),
                  child:
                  Text("Importer : ",style: TextStyle(
                    fontSize: 15.0,fontWeight: FontWeight.w500
                  ),),
                ),
                Text("Gateway Distriparks Pvt. Ltd",style: TextStyle(
                  fontSize: 15.0,
                ),),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextField(
                        controller: contractorcontroller,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Contractor",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          // hintText: widget.uploaddata!.data[index].surveyRemarks,
                          hintStyle: const TextStyle(
                              fontSize: 14.0, color: Colors.black),
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
              ],
            ),
            const SizedBox(height: 5,),
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                    controller: resourcecontroller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: "Resource",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // hintText: widget.uploaddata!.data[index].surveyRemarks,
                      hintStyle: const TextStyle(
                          fontSize: 14.0, color: Colors.black),
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
          ],
        ),
            const SizedBox(height: 8,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 13.0),
                  child: Text(
                    "Examination Detail",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                        controller: startdatecontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Start Date",
                            hintStyle: const TextStyle(fontSize: 14.0),
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
                              startdatecontroller.text =
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
                            hintStyle: const TextStyle(fontSize: 14.0),
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
                            hintStyle: const TextStyle(fontSize: 14.0),
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
                            hintStyle: const TextStyle(fontSize: 14.0),
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
            const SizedBox(height: 8,),
           const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Package Examined",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 48.0),
                  child: Text(
                    "Examination % age",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,top:6.0),
                  child: SizedBox(
                    height: 35,
                    width: 150,
                    child: TextField(
                        controller: packagecontroller,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          // hintText: widget.uploaddata!.data[index].surveyRemarks,
                          hintStyle: const TextStyle(
                              fontSize: 14.0, color: Colors.black),
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
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,top:6.0),
                  child: Container(
                    height: 36,
                    width: 146,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const Text("",
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.black)),
                          value: lineCourseValue,
                          isDense: true,
                          isExpanded: true,
                          // menuMaxHeight: 450,
                          items: [
                            const DropdownMenuItem(
                                value: "",
                                child: Text(
                                  " ",
                                  style: TextStyle(fontSize: 14.0),
                                )),
                            ...dropDownListData
                                .map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem(
                                  value: e['value'], child: Text(e['title']));
                            }).toList(),
                          ],
                          onChanged: (Value) {
                            setState(
                                  () {
                                lineCourseValue = Value!;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
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
  Pickimage() async {
    var selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        selectedImagesList!.addAll(selectedImages);
        Warehouseobject = false;
      });
    }
  }
}



