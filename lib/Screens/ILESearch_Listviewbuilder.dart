import 'package:flutter/material.dart';
import '../Models/ILE_Models.dart';
import 'Gallery_image.dart';

class Ilebuilder extends StatelessWidget {
  const Ilebuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: myclasss(),
    ));
  }
}

class myclasss extends StatefulWidget {
 late Welcome? autoGenerate;

  myclasss({super.key,  this. autoGenerate,});

  @override
  State<myclasss> createState() => _myclasssState();
}

int index = 0;
int indexx = 0;

class _myclasssState extends State<myclasss> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: Text(widget.autoGenerate!.data[index].activityType.toString(),style: const TextStyle(fontSize: 14.0),),
              ),
              Padding(
                padding: const EdgeInsets.only(right:0.0),
                child: Text(
                  "Container No. - ${widget.autoGenerate!.data[index].containerNo}",
                  style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                ),
              ),
          ],),
          backgroundColor: const Color(0xFF184f8d),
        ),
        body: ListView.builder(
          //physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.autoGenerate?.data.length,
            itemBuilder: (BuildContext context, int index) {
              return widget.autoGenerate?.data[index].error == false
                  ? Card(
                shadowColor: const Color(0xFF184f8d),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GridView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget
                              .autoGenerate!.data[index].filePath.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 6.0,
                          ),
                          itemBuilder:
                              (BuildContext context, int index1) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Zoomimage(
                                          gallerydata: widget.autoGenerate,
                                          innd: index1,
                                          indexes: index,),
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0,right: 5.0,left: 5.0),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF184f8d)),
                                  ),
                                  child: Image.network(
                                    widget.autoGenerate!.data[index]
                                        .filePath[index1].filename,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
                  : const Text("Data not found");
            }),
      );
    }

  }

