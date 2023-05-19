// import 'package:flutter/material.dart';
// import 'package:gateway_connect/Models/EIR%20models.dart';
// import 'package:gateway_connect/Screens/Eir_Download.dart';
// import 'package:gateway_connect/Services/EIR%20Controller.dart';
// import 'package:get/get.dart';
//
// import '../Models/Node_containersearch.dart';
// import '../universal.dart';
//
// class Containerpdf extends StatefulWidget {
//   Eircopy? fromdata;
//    Containerpdf({Key? key, this.fromdata}) : super(key: key);
//
//   @override
//   State<Containerpdf> createState() => _ContainerpdfState();
// }
//
//
// class _ContainerpdfState extends State<Containerpdf> {
//   int index = 0;
//   @override
//   Widget build(BuildContext context) {
//     final EIRController obj = Get.put(EIRController());
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Download PDF"),
//         centerTitle: true,
//         backgroundColor: Color(0xFF184f8d),
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width:MediaQuery.of(context).size.width,
//         child: Padding(
//           padding: EdgeInsets.only(top: 20.0),
//           child:
//           ListView.builder(
//               itemCount: widget.fromdata!.eirCopy.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                   margin: EdgeInsets.all(10.0),
//                   color: Colors.grey[200],
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                   side: BorderSide(color: Colors.blue,width: 1)
//                   ),
//                   shadowColor: Colors.red,
//                   elevation: 8,
//                   child: Column(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(height: 5,),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 8.0),
//                                 child: Text('Container no:',style: TextStyle(fontSize: 18.0,
//                                     fontWeight: FontWeight.bold,color: Color(0xFF184f8d)),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 8.0),
//                                 child: Text( widget.fromdata!.eirCopy[index].containerNo,style: TextStyle(fontSize: 18.0,color: Color(0xFF184f8d)),
//                                 ),
//                               ),],
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 8.0,top: 5.0),
//                                 child: Text('GateIN Date:' ,style: TextStyle(fontSize: 18.0,
//                                     fontWeight: FontWeight.bold,color: Color(0xFF184f8d)
//                                 ),),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 13.0,top: 5.0),
//                                 child: Text(widget.fromdata!.eirCopy[index].gateInDt.toLocal().toString().replaceRange(10, 23, ' '),
//                                   style: TextStyle(fontSize: 18.0,
//                                     color: Color(0xFF184f8d)
//                                 ),),
//                               ),
//                             ],
//                           ),],
//                       ),
//                   Padding(padding: EdgeInsets.only(top: 10.0),),
//                       Container(
//                         height: 50,
//                         width: 130,
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 10.0),
//                           child: MaterialButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>  Eirdownload(viewdata:widget.fromdata)));
//                               //Navigator.of(this.context).pop(true);
//                               },
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15.0)),
//                             color: Colors.redAccent[200],
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text('View PDF',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18.0),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//         ),
//       ),
//     );
//   }
// }
