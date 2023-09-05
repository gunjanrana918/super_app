import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../Models/Gateintransit_suggestionsearch.dart';
import '../Models/Grounddata_Upload.dart';
import 'package:http/http.dart' as http;
import '../universal.dart';
import 'Seal_verify.dart';

class Shippingcontainer extends StatefulWidget {
  const Shippingcontainer({super.key});

  @override
  State<Shippingcontainer> createState() => _ShippingcontainerState();
}

class _ShippingcontainerState extends State<Shippingcontainer> {
  Grounddataupload? parsedata;
  final TextEditingController remarkscontroller = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<Gateintransit>> key =  GlobalKey();
  late AutoCompleteTextField searchTextField;
  TextEditingController controller = TextEditingController();
  final IntransitViewModel transitdata = IntransitViewModel();
  final picker = ImagePicker();
  String selectedvalue = "3";
  File? imageFile;
  var message;
  //Imageupload function/////
  asyncFileUpload() async {
    int index = 0;
    var request = http.MultipartRequest("POST",
        Uri.parse("http://103.25.130.254/grfl_login_api/api/AddGround"));
    request.fields["containerno"] = searchTextField.textField!.controller!.text;
    request.fields["activitytype"] = selectedvalue.toString();
    request.fields["remarks"] = remarkscontroller.text;
    request.fields["Location"] = Globaldata.Location;
    request.files.add(await http.MultipartFile.fromPath('', imageFile!.path));
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var newmyparsedata = Grounddataupload.fromJson(json.decode(responseData));
      message = newmyparsedata.ileTable[index].msg;
      Globaldata.esealmessage = message;
      if (newmyparsedata.ileTable[index].error == false) {
        Fluttertoast.showToast(
            msg: newmyparsedata.ileTable[index].msg,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          remarkscontroller.clear();
          searchTextField.clear();
          imageFile = null;
        });
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => Dashboard(),
        //     ));
      }
      else {
        Fluttertoast.showToast(
            msg: "Image not upload.",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          remarkscontroller.clear();
          searchTextField.clear();
          imageFile = null;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    transitdata.loadtransitdata().then((value) {
      setState(() {
        transitdata.Data;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 40,
        child: Row(
          children: [
            Expanded(
                child: MaterialButton(
              onPressed: () {
                if (searchTextField.textField!.controller!.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please enter container no.",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: const Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  openCamera();
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: const BorderSide(color: Colors.black)),
              elevation: 10.0,
              color: Colors.green,
              textColor: Colors.white,
              child: const Text(
                "Take Photo",
                style: TextStyle(fontSize: 18.0),
              ),
            )),
            Expanded(
                child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: const BorderSide(color: Colors.black)),
              elevation: 10.0,
              onPressed: () async {
                if (searchTextField.textField!.controller!.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please enter container no.",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: const Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if ((imageFile == null)) {
                  Fluttertoast.showToast(
                      msg: "Please Upload Image",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: const Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  LoadingIndicatorDialog().show(context);
                  await asyncFileUpload();
                  LoadingIndicatorDialog().dismiss();
                }
              },
              color: Colors.redAccent,
              textColor: Colors.white,
              child: const Text("Upload", style: TextStyle(fontSize: 18.0)),
            )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text("Container No. -",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 95.0, top: 10.0),
              child: SizedBox(
                height: 40,
                width: 300,
                child: searchTextField = AutoCompleteTextField<Gateintransit>(
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                        hintStyle: TextStyle(color: Colors.black)),
                    inputFormatters: [ LengthLimitingTextInputFormatter(11),// for mobile
                    ],
                    itemSubmitted: (item) {
                      setState(() {
                        searchTextField.textField?.controller?.text = item.containerNo;
                        imageFile=null;
                      });
                    },
                    clearOnSubmit: false,
                    key: key,
                    suggestions: transitdata.Data,
                    itemBuilder: (context, item) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            item.containerNo,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ],
                      );
                    },
                    itemSorter: (a, b) {
                      return a.containerNo.compareTo(b.containerNo);
                    },
                    itemFilter: (item, enteredkeyword) {
                      return item.containerNo
                          .toLowerCase()
                          .contains(enteredkeyword.toLowerCase());
                    }),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text("Remarks -",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: SizedBox(
                width: 400, // <-- TextField width
                height: 240,
                child: TextField(
                  controller: remarkscontroller,
                  maxLines: 500,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 5.0, left: 8.0)),
            Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Builder(builder: (context) {
                  return imageFile != null
                      ? SizedBox(
                          height: 200,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 80,
                                height: 100,
                                child: Image.file(File(imageFile!.path)),
                              ),
                              Positioned(
                                  right: 15,
                                  top: -14,
                                  child: IconButton(
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 25,
                                      ),
                                      onPressed: () => setState(() {
                                            imageFile = null;
                                          })))
                            ],
                          ),
                        )
                      : Container();
                })),
          ],
        ),
      ),
    );
  }
  // Future<void> _showDialog() {
  //   // ignore: missing_return
  //   return showDialog(
  //       context: this.context,
  //       builder: (BuildContext) {
  //         return AlertDialog(
  //             contentPadding: EdgeInsets.all(10.0),
  //             shape: Border.all(color: Colors.red, width: 2),
  //             title: Text(
  //               'Select Image Source',
  //             ),
  //             content: SingleChildScrollView(
  //                 child: ListBody(
  //                   children: <Widget>[
  //                     // GestureDetector(
  //                     //   child: Text('Gallery', style: TextStyle(fontSize: 20.0)),
  //                     //   onTap: () {
  //                     //     Pickimage();
  //                     //     setState(() {});
  //                     //     Navigator.of(this.context).pop(false);
  //                     //   },
  //                     // ),
  //                     Padding(padding: EdgeInsets.only(top: 10.0)),
  //                     GestureDetector(
  //                       child: Text('Camera',
  //                           style: TextStyle(fontSize: 20.0, color: Colors.red)),
  //                       onTap: () {
  //                         openCamera();
  //                         setState(() {});
  //                         Navigator.of(this.context).pop(false);
  //                       },
  //                     ),
  //                     Padding(padding: EdgeInsets.only(top: 10.0)),
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                             child: ElevatedButton(
  //                               onPressed: () {
  //                                 Navigator.of(this.context).pop(false);
  //                               },
  //                               child: Text(
  //                                 "Cancel",
  //                                 style: TextStyle(fontSize: 20.0),
  //                               ),
  //                             ))
  //                       ],
  //                     )
  //                   ],
  //                 )));
  //       });
  // }

  //select image from camera
  Future<void> openCamera() async {
    var pickedFile =
        (await picker.pickImage(source: ImageSource.camera, imageQuality: 25));
    setState(() {
      imageFile = File(pickedFile!.path);
    });
    setState(() {});
  }
}

class Sealtabbar extends StatefulWidget {
  const Sealtabbar({super.key});

  @override
  State<Sealtabbar> createState() => _SealtabbarState();
}
int index=0;
class _SealtabbarState extends State<Sealtabbar> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 10,
              backgroundColor:  const Color(0xFF184f8d),
              bottom: const TabBar(
                  labelColor: Colors.limeAccent,
                  indicatorColor: Colors.limeAccent,
                  unselectedLabelColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,),
                  tabs: [
                    Tab( text: "Import Rail-In",),
                    Tab( text: "InYard-Seal Container")
                  ]),
            ),
            body:  const TabBarView(
                children:[
                  Shippingcontainer(),
                  AutoComplete()
                  ],
                ),
                ),
          ));
  }
}
class LoadingIndicatorDialog {
  static final LoadingIndicatorDialog _singleton = LoadingIndicatorDialog._internal();
  late BuildContext _context;
  bool isDisplayed = false;

  factory LoadingIndicatorDialog() {
    return _singleton;
  }

  LoadingIndicatorDialog._internal();

  show(BuildContext context, {String text = 'Please wait while data submitted...'}) {
    if(isDisplayed) {
      return;
    }
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _context = context;
          isDisplayed = true;
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              backgroundColor: const Color(0xFF184f8d),
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(text,style: const TextStyle(color: Colors.white,fontSize: 16),),
                      )
                    ],
                  ),
                )
              ] ,
            ),
          );
        }
    );
  }

  dismiss() {
    if(isDisplayed) {
      Navigator.of(_context).pop();
      isDisplayed = false;
    }
  }
}

