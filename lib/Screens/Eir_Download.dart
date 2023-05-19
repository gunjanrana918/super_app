// import 'package:flutter/material.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:share/share.dart';
// import '../Models/EIR models.dart';
// import '../Services/EIR Controller.dart';
// import '../universal.dart';
//
// class Eirdownload extends StatefulWidget {
//   Eircopy? viewdata;
//    Eirdownload({Key? key,  this.viewdata}) : super(key: key);
//
//
//
//   @override
//   State<Eirdownload> createState() => _EirdownloadState();
// }
//
// class _EirdownloadState extends State<Eirdownload> {
//   int index = 0;
//   final EIRController obj = Get.put((EIRController()));
//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor:  Color(0xFF184f8d),
//           title: const Text("Share file"),
//           actions: [
//             IconButton(
//                 onPressed: (){
//                   _onShareWithEmptyFields(context);
//                 },
//                 icon: const Icon(Icons.share),
//               color: Colors.white,)
//           ],
//         ),
//         body: const PDF(
//           swipeHorizontal: false,
//           pageFling: true,
//           enableSwipe: true
//         ).cachedFromUrl(widget.viewdata!.eirCopy[index].filePath),
//       ),
//     );
//   }
//   _onShareWithEmptyFields(BuildContext context) async {
//     await Share.share(widget.viewdata!.eirCopy[index].filePath);
//   }
// }
