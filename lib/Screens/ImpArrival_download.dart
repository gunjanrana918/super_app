// import 'package:flutter/material.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:share/share.dart';
// import '../Models/EIR models.dart';
// import '../Models/Node_containersearch.dart';
// import '../Services/EIR Controller.dart';
// import '../universal.dart';
//
// class ImpArridownload extends StatefulWidget {
//   AutoGenerate? newdata;
//   ImpArridownload({Key? key,  this.newdata,}) : super(key: key);
//
//   @override
//   State<ImpArridownload> createState() => _ImpArridownloadState();
// }
// int index = 0;
// class _ImpArridownloadState extends State<ImpArridownload> {
//   final EIRController obj = Get.put((EIRController()));
//   @override
//   Widget build(BuildContext context) {
//     print(widget.newdata!.ImportArrivalInfo[index].FilePath);
//     return  MaterialApp(
//       debugShowCheckedModeBanner: false,
//
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("Share file"),
//           backgroundColor: Color(0xFF184f8d),
//           actions: [
//             IconButton(
//               onPressed: (){
//                 _onShareWithEmptyFields(context);
//               },
//               icon: const Icon(Icons.share),
//               color: Colors.white,)
//           ],
//         ),
//         body: const PDF(
//             swipeHorizontal: false,
//             pageFling: true,
//             enableSwipe: true
//         ).cachedFromUrl(widget.newdata!.ImportArrivalInfo[index].FilePath),
//       ),
//     );
//   }
//   _onShareWithEmptyFields(BuildContext context) async {
//     await Share.share(widget.newdata!.ImportArrivalInfo[index].FilePath);
//   }
// }
