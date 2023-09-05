
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../Models/ILEDate_Search.dart';

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF184f8d),
          title: Text("Container No. - ${widget.gallerydata!.data[indexes].containerNo}",style: const TextStyle(fontSize: 15),),

        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,top: 10),
                  child: Text("Date : ${widget.gallerydata!.data[indexes].dtTime}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10.0,right: 10),
                  child: Text("Time : "+widget.gallerydata!.data[indexes].filePath[inddd].time +'Hrs',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:18.0),
              child: Text(
                "Remarks :${widget.gallerydata!.data[indexes].filePath[inddd].remarks}",
                style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: PhotoView(
                imageProvider: NetworkImage(widget.gallerydata!.data[indexes].filePath[inddd].filename))),
          ],
        ),

    );
  }
}
