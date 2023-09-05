
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../Models/ILE_Models.dart';

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
    return  Scaffold(
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
                  padding: const EdgeInsets.only(left:8.0,top: 10),
                  child: Text(
                    "Date : ${widget.gallerydata!.data[indexes].filePath[indd].dtTime}",
                    style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:8.0,top: 10),
                  child: Text(
                    "Time : ${widget.gallerydata!.data[indexes].filePath[indd].time}Hrs",
                    style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(
                "Remarks : ${widget.gallerydata!.data[indexes].filePath[indd].remarks}",
                style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: PhotoView(
                  imageProvider: NetworkImage(widget.gallerydata!.data[indexes].filePath[indd].filename)),
            ),
          ],
        ),
    );
  }
}
