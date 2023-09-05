// import 'dart:html';

import 'package:flutter/material.dart';

import '../Models/Rakehistory_model.dart';


class Rakehistorydetails extends StatefulWidget {
  Rakehistorydata? rakedata;
   Rakehistorydetails({super.key, this.rakedata});

  @override
  State<Rakehistorydetails> createState() => _RakehistorydetailsState();
}

int index = 0;
int indexx = 0;

class _RakehistorydetailsState extends State<Rakehistorydetails> {
  final examinationcontroller = TextEditingController();
  final weighmemcontroller = TextEditingController();
  bool agree = false;
  bool approve = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History Details"),
        backgroundColor: const Color(0xFF184f8d),
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListView.builder(
              //physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: widget.rakedata?.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return  widget.rakedata?.data[index].error == false ?
                  Card(
                    shadowColor: const Color(0xFF184f8d),
                    elevation: 7.0,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color(0xFF184f8d),
                      ),
                      borderRadius: BorderRadius.circular(5.0), //<-- SEE HERE
                    ),
                    child:  Column(
                      children: [
                        ExpansionTile(
                          title: Row(
                            children: [
                              Text(widget.rakedata!.data[index].containerNo,style: const TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold),),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  "| ${widget.rakedata!.data[index].size}" ,
                                  style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  "|  ${widget.rakedata!.data[index].type}" ,
                                  style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,),
                                  child: Text(
                                    "From : " ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "  ${widget.rakedata!.data[index].fromLocation}" ,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,),
                                  child: Text(
                                    " To : " ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "  ${widget.rakedata!.data[index].toLocation}" ,
                                  style: const TextStyle(fontSize: 15),
                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,top: 10),
                                  child: Text(
                                    "Wagon No.       :   " ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "   ${widget.rakedata!.data[index].wagonno}" ,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,top: 10),
                                  child: Text(
                                    "Physical No      :  " ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "  ${widget.rakedata!.data[index].surveyWagonNo}" ,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,top: 10),
                                  child: Text(
                                    "Line Seal           : " ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  " ${widget.rakedata!.data[index].lineSealNo}" ,
                                  style: const TextStyle(fontSize: 15,),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,top: 10),
                                  child: Text(
                                    "Line Seal Status : " ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  " ${widget.rakedata!.data[index].lineSealStatus}" ,
                                  style: const TextStyle(fontSize: 15,),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,top: 10),
                                  child: Text(
                                    "Customs Seal     : " ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  " ${widget.rakedata!.data[index].customSealNo}" ,
                                  style: const TextStyle(fontSize: 15,),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,top: 10),
                                  child: Text(
                                    "Customs Seal Status : ",
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  " ${widget.rakedata!.data[index].customSealStatus}",
                                  style: const TextStyle(fontSize: 15,),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,top: 10),
                                  child: Text(
                                    "Physical Condition     : " ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  " ${widget.rakedata!.data[index].surveyContainerCondition}" ,
                                  style: const TextStyle(fontSize: 15,),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ):Container();
                }),

          ],
        ),
      )
    );
  }
}



