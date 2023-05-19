//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../Models/Node_containersearch.dart';
// import 'ImpArrival_download.dart';
//
// class detaislist extends StatefulWidget {
//   //final String containercontroller;
//    AutoGenerate? fromdata;
//    detaislist({Key? key, this.fromdata }) : super(key: key);
//
//   @override
//   State<detaislist> createState() => _detaislistState();
// }
// int rindex=0;
// class _detaislistState extends State<detaislist> {
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("Details"),
//           backgroundColor: Color(0xFF184f8d),
//         ),
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           width:MediaQuery.of(context).size.width,
//           child:
//           ListView.builder(
//               itemCount: widget.fromdata!.ImportArrivalInfo.length,
//               itemBuilder: (BuildContext context, index){
//                 return Card(
//                   margin: const EdgeInsets.all(10.0),
//                   color: Colors.blueAccent[300],
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),side: const BorderSide(color: Colors.blueAccent)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text("Document No :",
//                               style: const TextStyle(
//                                   fontSize: 18.0, fontWeight: FontWeight.bold,color:Color(0xFF184f8d)),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10.0),
//                               child: Text( widget.fromdata!.ImportArrivalInfo[index].DocumentNo,
//                                 style: const TextStyle(
//                                     fontSize: 18.0,color: Color(0xFF184f8d) ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Padding(padding: EdgeInsets.only(top: 5.0)),
//                         Row(
//                           children: [
//                             Text("Container no  :"+" ",
//                               style: const TextStyle(
//                                   fontSize: 18.0, fontWeight: FontWeight.bold, color:Color(0xFF184f8d)),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 8.0),
//                               child: Text(widget.fromdata!.ImportArrivalInfo[index].ContainerNo,
//                                 style: const TextStyle(
//                                     fontSize: 18.0, color:  Color(0xFF184f8d)),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Padding(padding: EdgeInsets.only(top: 5.0,)),
//                         Row(
//                           children: [
//                             Text("DateTime        :",
//                               style: const TextStyle(
//                                   fontSize: 18.0, fontWeight: FontWeight.bold,color:  Color(0xFF184f8d)),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10.0),
//                               child: Text(widget.fromdata!.ImportArrivalInfo[index].ArrivalDtTime,
//                                 style: const TextStyle(
//                                     fontSize: 18.0,color:  Color(0xFF184f8d)),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Padding(padding: EdgeInsets.only(top: 5.0)),
//                         Row(
//                           children: [
//                             Text("Size                  :" ,
//                               style: const TextStyle(
//                                   fontSize: 18.0, fontWeight: FontWeight.bold,color:  Color(0xFF184f8d)),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10.0),
//                               child: Text(widget.fromdata!.ImportArrivalInfo[index].Size,
//                                 style: const TextStyle(
//                                     fontSize: 18.0,color:  Color(0xFF184f8d)),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Padding(padding: EdgeInsets.only(top: 5.0)),
//                         Row(
//                           children: [
//                             Text("Type                 :",
//                               style: const TextStyle(
//                                   fontSize: 18.0, fontWeight: FontWeight.bold,color:  Color(0xFF184f8d)),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10.0),
//                               child: Text(widget.fromdata!.ImportArrivalInfo[index].Type,
//                                 style: const TextStyle(
//                                     fontSize: 18.0,color:  Color(0xFF184f8d)),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const  Padding(padding: EdgeInsets.only(top: 5.0)),
//                         InkWell(
//                           onTap: (){
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => ImpArridownload(newdata: widget.fromdata ),));
//                           },
//                           child: Text("FilePath :"+" " +widget.fromdata!.ImportArrivalInfo[index].FilePath,
//                             style: const TextStyle(
//                                 fontSize: 17.0, fontWeight: FontWeight.bold,color: Colors.red),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                 );
//               }),
//         ),
//       ),
//     );
//
//
//   }
// }
