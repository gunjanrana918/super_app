import 'package:flutter/material.dart';
import 'package:super_app/Screens/Multipleimage_container.dart';
import '../Models/ILEDate_Search.dart';

class Ilebuilder extends StatelessWidget {
  const Ilebuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: datesearchdata(),
        ));
  }
}

class datesearchdata extends StatefulWidget {
   DateIleSearch? Generate;
  datesearchdata({super.key, this.Generate,}){
    print("Generate");
    print(Generate);
  }

  @override
  State<datesearchdata> createState() => _datesearchdataState();
}

int index = 0;
int indexx = 0;

class _datesearchdataState extends State<datesearchdata> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body:
        ListView.builder(
            scrollDirection: Axis.vertical,
            //physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.Generate?.data.length,
            itemBuilder: (BuildContext context, int index) {
              return widget.Generate?.data[index].error == false
                  ? Card(
                shadowColor: Color(0xFF184f8d),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:8.0,left: 8.0),
                          child: Text(
                            widget.Generate!.data[index].activityType.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right:8.0),
                          child: Text(
                            "Date " +
                                ": " +
                                widget.Generate!.data[index].dtTime.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text(
                            "Container No. " +
                                ": " +
                                widget.Generate!.data[index].containerNo.toString(),
                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                          ),
                        ),
                        GridView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget
                              .Generate!.data[index].filePath.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 6.0,
                          ),
                          itemBuilder:
                              (BuildContext context, int index1) {
                            return GestureDetector(
                              onTap: () {
                                print(index1);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Imagezoom(
                                          gallerydata: widget.Generate,
                                          inndd: index1,
                                          indexes: index),
                                    ));
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.only(top: 5.0,right: 5.0,left: 5.0),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xFF184f8d)),
                                  ),
                                  child: Image.network(
                                    widget.Generate!.data[index]
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
                  : Text("Data not found");
            }),
      );
    }

  }

