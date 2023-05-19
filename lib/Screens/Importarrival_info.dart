// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gateway_connect/Screens/ImpArriInfolistview.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:http/http.dart' as http;
//
// import '../Models/Node_containersearch.dart';
// import '../Services/Container_searchcontroller.dart';
// import '../universal.dart';
// class Importarrival extends StatefulWidget {
//   const Importarrival({Key? key}) : super(key: key);
//
//   @override
//   State<Importarrival> createState() => _ImportarrivalState();
// }
//
// class _ImportarrivalState extends State<Importarrival> {
//
//   final DataController obj = Get.put(DataController());
//   final namecontroller = TextEditingController();
//   AutoGenerate? fromdata ;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Import Arrival Info."),
//         backgroundColor: Color(0xFF184f8d),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               color: Colors.transparent
//             ),
//           ),
//           Padding(
//             padding: (const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0)),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Padding(padding: EdgeInsets.only(top: 10.0)),
//                     const SizedBox(
//                       height: 20.0,
//                       child: Text(
//                         "Enter Container No.",
//                         style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w500,
//                             decoration: TextDecoration.underline),
//                       ),
//                     ),
//                     const Padding(padding: const EdgeInsets.only(top: 15.0)),
//                     Container(
//                       height: 50,
//                       child: TextField(
//                         controller: obj.containercontroller,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: const InputDecoration(
//                             hintText: "Container no.",
//                             enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.black))),
//                       ),
//                     ),
//                     const Padding(padding: const EdgeInsets.only(top: 15.0)),
//                     SizedBox(
//                       height: 40,
//                       child: MaterialButton(
//                         onPressed: () async {
//                           if(obj.containercontroller.text.isNotEmpty){
//                             fromdata =  await obj.importArrival();
//                             obj.containercontroller.clear();
//                             setState(() {
//
//                             });
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>
//                                 detaislist(fromdata: fromdata),));
//                           }
//                           else{
//                             Fluttertoast.showToast(
//                                 msg: "Enter container no.!",
//                                 gravity: ToastGravity.CENTER,
//                                 toastLength: Toast.LENGTH_SHORT,
//                                 timeInSecForIosWeb: 2,
//                                 backgroundColor: Colors.red,
//                                 textColor: Colors.white,
//                                 fontSize: 18.0);
//                           }
//
//                           },
//
//
//                         color: Colors.redAccent[200],
//                         child: const Text(
//                           "Search",
//                           style: TextStyle(color: Colors.white, fontSize: 20),
//                         ),
//                       ),
//                     ),
//                   ]
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class nodeimparrival {
//   // late String BCODE;
//   late String DocumentNo;
//   late String ContainerNo;
//   late String Size;
//   late String Type;
//   late String ArrivalDtTime;
//   late String FilePath;
//
//   nodeimparrival(this.DocumentNo,
//       this.ContainerNo,
//       this.Size,
//       this.Type,
//       this.ArrivalDtTime,
//       this.FilePath);
//
//   nodeimparrival.fromJson(String DocumentNo, String ContainerNo,
//       String Size, String Type, String ArrivalDtTime, String FilePath) {
//     this.DocumentNo = DocumentNo;
//     this.ContainerNo = ContainerNo;
//     this.Size = Size;
//     this.Type = Type;
//     this.FilePath = FilePath;
//   }
// }
