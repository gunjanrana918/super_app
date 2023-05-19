// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gateway_connect/Screens/EIRContainer_details.dart';
// import 'package:gateway_connect/Screens/Eir_Download.dart';
// import 'package:gateway_connect/Services/EIR%20Controller.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
//
// import '../Models/EIR models.dart';
//
// class Documentsdownload extends StatefulWidget {
//   const Documentsdownload({Key? key}) : super(key: key);
//
//   @override
//   State<Documentsdownload> createState() => _DocumentsdownloadState();
// }
//
// class _DocumentsdownloadState extends State<Documentsdownload> {
//   final TextEditingController datepicker = TextEditingController();
//   final TextEditingController containercontroller =   TextEditingController();
//   DateTime selectedDate = DateTime.now();
//   final EIRController obj = Get.put((EIRController()));
//   Eircopy? Newdata ;
//
//   @override
//   void dispose() {
//     containercontroller.dispose();
//     datepicker.dispose();
//     super.dispose();
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     final DateTime now = DateTime.now();
//     final DateFormat formatter = DateFormat('dd-MMM-yyyy');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("EIR Copy"),
//         backgroundColor: Color(0xFF184f8d),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(color: Colors.transparent),
//           ),
//           Padding(
//             padding: (const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0)),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Padding(padding: EdgeInsets.only(top: 20.0)),
//                   SizedBox(
//                     height: 20.0,
//                     child: Text(
//                       "Enter Container No.",
//                       style: TextStyle(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.w500,
//                           decoration: TextDecoration.underline),
//                     ),
//                   ),
//                   Padding(padding: EdgeInsets.only(top: 15.0)),
//                   Container(
//                     height: 80,
//                     child: TextField(
//                       controller: obj.containercontroller,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                           hintText: "Container no.",
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.black))),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                     child: Text(
//                       "OR",
//                       style: TextStyle(
//                           fontSize: 18.0, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   Padding(padding: EdgeInsets.only(top: 15.0)),
//                   Row(children: [
//                     Expanded(
//                         child: Padding(padding: EdgeInsets.only(left: 5.0),
//                           child: SizedBox(
//                             height: 50,
//                             child: TextField(
//                               controller:obj.datepicker,
//                               decoration: const InputDecoration(
//                                   hintText: "dd-mm-yyyy",
//                                   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)
//                                   ),
//                                   suffixIcon: Icon(Icons.calendar_month,color: Colors.red,)
//                               ),
//                              // readOnly: true,
//                               onTap: () {
//                                 String formatted = formatter.format(selectedDate);
//                                 showDatePicker(
//                                     context: context,
//                                     initialDate: DateTime.now(),
//                                     firstDate: DateTime(2022, 1),
//                                     lastDate: DateTime(2050, 1),
//                                     builder: (context, picker) {
//                                       return Theme(
//                                         //TODO: change colors
//                                         data: ThemeData.dark().copyWith(
//                                           colorScheme: ColorScheme.dark(
//                                             primary: Colors.redAccent,
//                                             onPrimary: Colors.white,
//                                             surface: Colors.redAccent,
//                                             onSurface: Colors.black,
//                                           ),
//                                           dialogBackgroundColor: Colors.green[400],
//                                         ),
//                                         child: picker!,
//                                       );
//                                     }).then((selectedDate) {
//                                   if (selectedDate != null) {
//                                     obj.datepicker.value =
//                                         TextEditingValue(text: formatter.format(selectedDate));
//                                   }
//                                 });
//                               },
//                             ),
//                           ),
//                         )
//                     )
//                   ]),
//                   Padding(padding: EdgeInsets.only(top: 30.0)),
//                   SizedBox(
//                     height: 40,
//                     child: MaterialButton(
//                       onPressed: () async {
//                         if(obj.containercontroller.text.isNotEmpty || obj.datepicker.text.isNotEmpty){
//                           Newdata = await obj.EIRButton(container: obj.containercontroller.text, gatedate: obj.datepicker.text);
//                           obj.containercontroller.clear();
//                           obj.datepicker.clear();
//                           setState(() {
//                           });
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>
//                               Containerpdf(fromdata: Newdata),));
//                         }
//                         else {
//                           Fluttertoast.showToast(
//                               msg: "Please enter valid details",
//                               gravity: ToastGravity.CENTER,
//                               toastLength: Toast.LENGTH_SHORT,
//                               timeInSecForIosWeb: 2,
//                               backgroundColor: Colors.red,
//                               textColor: Colors.white,
//                               fontSize: 18.0);
//                         }
//                           },
//                       color: Colors.redAccent[200],
//                       child: const Text(
//                         "Search",
//                         style: TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                     ),
//                   )
//                 ]
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
