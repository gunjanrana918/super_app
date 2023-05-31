
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:super_app/universal.dart';
import '../Models/ILE_Models.dart';
import 'Gallery_image.dart';
class ILEListview extends StatefulWidget {
  Welcome? fromdata;
   ILEListview({Key? key, this.fromdata}) : super(key: key);

  @override
  State<ILEListview> createState() => _ILEListviewState();
}
 int index=0;
 int indexx=0;
class _ILEListviewState extends State<ILEListview> {

  @override
  void initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text( Globaldata.ContainerNo),
        backgroundColor: Color(0xFF184f8d),
      ),
      body:  SingleChildScrollView(
        child: ListView.builder(
            physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.fromdata!.data.length,
            itemBuilder: (BuildContext context, int index0){
            return
              Card(
              shadowColor: Color(0xFF184f8d),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date " + ": "+ widget.fromdata!.data[index0].dtTime,style: TextStyle(fontSize: 16), ),
                      Text("Activity Type " + ": "+ widget.fromdata!.data[index0].activityType,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold), )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Remarks " + ": "+ widget.fromdata!.data[index0].remarks,style: TextStyle(fontSize: 18), ),
                    ],
                  ),
                  GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.fromdata!.data[index0].filePath.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 6.0,
                    ),
                    itemBuilder: (BuildContext context, int index1){
                      return  GestureDetector(
                        onTap: (){
                          print("??????");
                          print(index1);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              Zoomimage(gallerydata:widget.fromdata, innd: index1),));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color:Color(0xFF184f8d) ),
                            ),
                            child: Image.network(widget.fromdata!.data[index0].filePath[index1].filename,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
            }),
      ),
          );

  }
}
