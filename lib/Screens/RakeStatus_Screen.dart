
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Models/Fois_Rake.dart';
import '../Services/FoisController.dart';
import 'Export_rakesurvey.dart';
import 'Rake_survey.dart';

// class rakePosition extends StatefulWidget {
//   rakePosition({super.key});
//
//   @override
//   State<rakePosition> createState() => _rakePositionState();
// }
//
// class _rakePositionState extends State<rakePosition> {
//   final RakestatusController statusdata = Get.put((RakestatusController()));
//   Rakestatusupdate() async{
//     int index=0;
//     var headers = {
//       'Content-Type': 'application/json'
//     };
//     var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/FoisRake'));
//     request.body = json.encode({
//       "RakeNo": "",
//     });
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     var responseData = await response.stream.bytesToString();
//     if (response.statusCode == 200) {
//       var validdata = FoisRakeModel .fromJson(jsonDecode(responseData));
//       if(validdata.data[index].error==false){
//         Future.delayed(const Duration(seconds: 1), () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) =>
//               rakeStatus(rakeuploaddata: validdata)));
//           // code to be executed after 2 seconds
//         });
//         return validdata;
//       }
//       else {
//         Fluttertoast.showToast(
//             msg:"Data not found",
//             gravity: ToastGravity.BOTTOM,
//             toastLength: Toast.LENGTH_SHORT,
//             timeInSecForIosWeb: 2,
//             backgroundColor: const Color(0xFF184f8d),
//             textColor: Colors.white,
//             fontSize: 16.0);
//       }
//     }
//     else {
//       Fluttertoast.showToast(
//           msg:"Data not found",
//           gravity: ToastGravity.BOTTOM,
//           toastLength: Toast.LENGTH_SHORT,
//           timeInSecForIosWeb: 2,
//           backgroundColor: const Color(0xFF184f8d),
//           textColor: Colors.white,
//           fontSize: 16.0);
//     }
//
//
//   }
//   @override
//   void initState() {
//     super.initState();
//     //Rakestatusupdate();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: DefaultTabController(
//           length: 2,
//           child: Scaffold(
//             appBar: AppBar(
//               title: const Text(
//                 "Rake Position",
//                 style: TextStyle(fontSize: 17),
//               ),
//               centerTitle: true,
//               toolbarHeight: 15,
//               backgroundColor: const Color(0xFF184f8d),
//               bottom: const TabBar(
//                   labelColor: Colors.limeAccent,
//                   indicatorColor: Colors.limeAccent,
//                   unselectedLabelColor: Colors.white,
//                   labelStyle: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   tabs: [
//                     Tab(
//                       text: "Position",
//                     ),
//                     Tab(text: "Position List")
//                   ]),
//             ),
//             body: TabBarView(
//               children: [
//                 rakeStatus(), exportRakesurvey()],
//             ),
//           ),
//         ));
//   }
// }



class rakeStatus extends StatefulWidget {
  FoisRakeModel? rakeuploaddata;
   rakeStatus({super.key, this.rakeuploaddata});

  @override
  State<rakeStatus> createState() => _rakeStatusState();
}
class _rakeStatusState extends State<rakeStatus> {
  final RakestatusController statusdata = Get.put((RakestatusController()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Rake Position List",style: TextStyle(
          fontSize: 19.0,
        ),),
        backgroundColor: const Color(0xFF184f8d),
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              //physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount:widget.rakeuploaddata?.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return widget.rakeuploaddata?.data[index].error == false ?
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.rakeuploaddata!.data[index].rakeid,style: const TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold),),
                              Text( "Fois Id  : ${widget.rakeuploaddata!.data[index].foisrakeId}" ,
                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
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
                                    "From                :" ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    " ${widget.rakeuploaddata!.data[index].fromlocation}",
                                    style: const TextStyle(fontSize: 14,),
                                    //overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    //maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,),
                                  child: Text(
                                    "To                     :" ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    " ${widget.rakeuploaddata!.data[index].tolocation}",
                                    style: const TextStyle(fontSize: 14,),
                                    //overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    //maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,top: 5),
                                  child: Text(
                                    "Departure On :" ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    " ${widget.rakeuploaddata!.data[index].departureDateTime} Hrs." ,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,top: 5),
                                  child: Text(
                                    "Location         :" ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      " ${widget.rakeuploaddata!.data[index].currentlocation}",
                                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                      //overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      //maxLines: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,top: 5),
                                  child: Text(
                                    "Date & Time   :" ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    " ${widget.rakeuploaddata!.data[index].datetime} Hrs." ,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,top: 5),
                                  child: Text(
                                    "Status             :" ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    " ${widget.rakeuploaddata!.data[index].status}" ,
                                    style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                  ),
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
      ),
    );
  }
}

class listrakeStatus extends StatefulWidget {
  FoisRakeModel? listrakedata;
  listrakeStatus({super.key, this.listrakedata});

  @override
  State<listrakeStatus> createState() => _listrakeStatusState();
}
class _listrakeStatusState extends State<listrakeStatus> {
  Rakestatusupdate() async{
    int index=0;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/FoisRake'));
    request.body = json.encode({
      "RakeNo": "",

    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var validdata = FoisRakeModel .fromJson(jsonDecode(responseData));
      if(validdata.data[index].error==false){
        // Future.delayed(const Duration(seconds: 1), () {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
        //       rakeStatus(uploaddata: validdata)));
        //   // code to be executed after 2 seconds
        // });
        return validdata;
      }
      else {
        Fluttertoast.showToast(
            msg:"Data not found",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    else {
      Fluttertoast.showToast(
          msg:"Data not found",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Rake Position Detail",style: TextStyle(
          fontSize: 19.0,
        ),),
        backgroundColor: const Color(0xFF184f8d),
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              //physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount:widget.listrakedata?.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return widget.listrakedata?.data[index].error == false ?
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.listrakedata!.data[index].rakeid,style: const TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold),),
                              Text( "Fois Id  : ${widget.listrakedata!.data[index].foisrakeId}" ,
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
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
                                    "From                :" ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    " ${widget.listrakedata!.data[index].fromlocation}",
                                    style: const TextStyle(fontSize: 14,),
                                    //overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    //maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,),
                                  child: Text(
                                    "To                     :" ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    " ${widget.listrakedata!.data[index].tolocation}",
                                    style: const TextStyle(fontSize: 14,),
                                    //overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    //maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,top: 5),
                                  child: Text(
                                    "Departure On :" ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    " ${widget.listrakedata!.data[index].departureDateTime} Hrs." ,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,top: 5),
                                  child: Text(
                                    "Location         :" ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      " ${widget.listrakedata!.data[index].currentlocation}",
                                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                      //overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      //maxLines: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,top: 5),
                                  child: Text(
                                    "Date & Time   :" ,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    " ${widget.listrakedata!.data[index].datetime} Hrs." ,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible:widget.listrakedata!.data[index].jnpt !='0',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left:8.0,top: 5),
                                    child: Text(
                                      "JNPT              :" ,
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "   ${widget.listrakedata!.data[index].jnpt}" ,
                                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible:widget.listrakedata!.data[index].mdpt !='0',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left:8.0,top: 5),
                                    child: Text(
                                      "MDPT              :" ,
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      " ${widget.listrakedata!.data[index].mdpt}" ,
                                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                            visible:widget.listrakedata!.data[index].ppsp !='0',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left:8.0,top: 5),
                                    child: Text(
                                      "PPSP               :" ,
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      " ${widget.listrakedata!.data[index].ppsp}" ,
                                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible:widget.listrakedata!.data[index].gdgh !='0',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left:8.0,top: 5),
                                    child: Text(
                                      "GDGH              :" ,
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      " ${widget.listrakedata!.data[index].gdgh}" ,
                                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible:widget.listrakedata!.data[index].iagr !='0',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left:8.0,top: 5),
                                    child: Text(
                                      "IAGR                :" ,
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      " ${widget.listrakedata!.data[index].iagr}" ,
                                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible:widget.listrakedata!.data[index].pgfs !='0',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left:8.0,top: 5),
                                    child: Text(
                                      "PGFS               :" ,
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      " ${widget.listrakedata!.data[index].pgfs}" ,
                                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible:widget.listrakedata!.data[index].ksp !='0',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left:8.0,top: 5),
                                    child: Text(
                                      "KSP                :" ,
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      " ${widget.listrakedata!.data[index].ksp}" ,
                                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ):Container();
                }),
          ],
        ),
      ),
    );
  }
}
