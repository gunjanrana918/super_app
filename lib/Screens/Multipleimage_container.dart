
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Models/ILEDate_Search.dart';
import '../Models/ILE_Models.dart';
import '../Services/Container_searchcontroller.dart';
import 'ILESearch_Listviewbuilder.dart';

class Imagezoom extends StatefulWidget {
  DateIleSearch? gallerydata;
  int index=0;
  int indexx=0;
  Imagezoom( {Key? key,this.gallerydata, required int inndd,required int indexes }) : super(key: key){
    index=inndd;
    indexx=indexes;
  }

  @override
  State<Imagezoom> createState() => _ImagezoomState(index,indexx);
}

class _ImagezoomState extends State<Imagezoom> {
  int inddd=0;
  int indexes=0;
  _ImagezoomState( int a,int b){
    inddd=a;
    indexes=b;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF184f8d),
          title: Text("Container No."+widget.gallerydata!.data[indexes].containerNo,style: TextStyle(fontSize: 13),),
          // actions: [
          //   Text("Date: "+widget.gallerydata!.data[indexes].dtTime,style: TextStyle(fontSize: 12),),
          //   Text("Time: "+widget.gallerydata!.data[indexes].time,style: TextStyle(fontSize: 12),),
          // ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0,top: 10),
              child: Text("Date: "+widget.gallerydata!.data[indexes].dtTime,style: TextStyle(fontSize: 14),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text("Time: "+widget.gallerydata!.data[indexes].filePath[inddd].time +'Hrs',style: TextStyle(fontSize: 14),),
            ),
            Padding(
              padding: const EdgeInsets.only(left:18.0),
              child: Text(
                "Remarks " +
                    ": " +
                    widget.gallerydata!.data[indexes].filePath[inddd].remarks,
                style: TextStyle(fontSize: 15),
              ),
            ),
            InteractiveViewer(
                panEnabled: true, // Set it to false
                boundaryMargin: EdgeInsets.all(80),
                minScale: 0.5,
                maxScale: 5,
                child:  Image.network(widget.gallerydata!.data[indexes].filePath[inddd].filename)),
          ],
        ),
      ),
    );
  }
}
