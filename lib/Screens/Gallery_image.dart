
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Models/ILE_Models.dart';
import '../Services/Container_searchcontroller.dart';
import 'ILESearch_Listviewbuilder.dart';

class Zoomimage extends StatefulWidget {
  Welcome? gallerydata;
int index=0;
  int indexx=0;
   Zoomimage( {Key? key,this.gallerydata, required int innd, required int indexes }) : super(key: key){
     index=innd;
     indexx=indexes;
   }

  @override
  State<Zoomimage> createState() => _ZoomimageState(index,indexx);
}

class _ZoomimageState extends State<Zoomimage> {
  int indd=0;
  int indexes=0;
  _ZoomimageState( int a,int b){
    indd=a;
    indexes=b;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF184f8d),
          title: Text(widget.gallerydata!.data[indexes].containerNo.toString(),style: TextStyle(fontSize: 13),),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(
                "Date " +
                    ": " +
                    widget.gallerydata!.data[indexes].filePath[indd].dtTime,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(
                "Time " +
                    ": " +
                    widget.gallerydata!.data[indexes].filePath[indd].time,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(
                "Remarks " +
                    ": " +
                    widget.gallerydata!.data[indexes].filePath[indd].remarks,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Center(
              child: InteractiveViewer(
                  panEnabled: true, // Set it to false
                  boundaryMargin: EdgeInsets.all(80),
                  minScale: 0.5,
                  maxScale: 5,
                  child: Image.network(widget.gallerydata!.data[indexes].filePath[indd].filename)),
            ),
          ],
        ),
      ),
    );
  }
}
