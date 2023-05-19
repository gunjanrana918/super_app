
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Models/ILE_Models.dart';
import '../Services/Container_searchcontroller.dart';
import 'ILESearch_Listviewbuilder.dart';

class Zoomimage extends StatefulWidget {
  Welcome? gallerydata;
int index=0;
   Zoomimage( {Key? key,this.gallerydata, required int innd }) : super(key: key){
     index=innd;
   }

  @override
  State<Zoomimage> createState() => _ZoomimageState(index);
}

class _ZoomimageState extends State<Zoomimage> {
  int indd=0;
  _ZoomimageState( int a){
    indd=a;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF184f8d),
          title: Text("Container Image"),
        ),
        body: Center(
          child: InteractiveViewer(
              panEnabled: true, // Set it to false
              boundaryMargin: EdgeInsets.all(80),
              minScale: 0.5,
              maxScale: 5,
              child: Image.network(widget.gallerydata!.data[index].filePath[indd].filename)),
        ),
      ),
    );
  }
}
