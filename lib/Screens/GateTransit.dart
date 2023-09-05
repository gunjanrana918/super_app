import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../Models/Esealsuggestion_search.dart';
import '../Models/Gateintransit_suggestionsearch.dart';
import '../Models/Grounddata_Upload.dart';
import 'package:http/http.dart' as http;
import '../universal.dart';

class Shippingcontainer extends StatefulWidget {
  const Shippingcontainer({super.key});

  @override
  State<Shippingcontainer> createState() => _ShippingcontainerState();
}

class _ShippingcontainerState extends State<Shippingcontainer> {
  Grounddataupload? parsedata;
  final TextEditingController remarkscontroller = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<Gateintransit>> key = new GlobalKey();
  late AutoCompleteTextField searchTextField;
  TextEditingController controller = TextEditingController();
  final IntransitViewModel transitdata = IntransitViewModel();
  final picker = ImagePicker();
  String selectedvalue = "3";
  File? imageFile;
  var message;
  void Onpressed() async {
    showLoadingIndicator();
    await asyncFileUpload();
    hideOpenDialog();
  }

  void showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              //backgroundColor: Colors.black87,
              content: Container(
                padding: EdgeInsets.all(16),
                color: Color(0xFF184f8d),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                        child: Container(
                            child: CircularProgressIndicator(strokeWidth: 3),
                            width: 32,
                            height: 32),
                        padding: EdgeInsets.only(bottom: 16)),
                    Padding(
                        child: Text(
                          'Please wait untill data submitted…',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.only(bottom: 4)),
                  ],
                ),
              ),
            ));
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }

  //Imageupload function/////
  asyncFileUpload() async {
    int index = 0;
    var request = http.MultipartRequest("POST",
        Uri.parse("http://103.25.130.254/grfl_login_api/api/AddGround"));
    request.fields["containerno"] = searchTextField.textField!.controller!.text;
    print(searchTextField.textField!.controller!.text);
    request.fields["activitytype"] = selectedvalue.toString();
    request.fields["remarks"] = remarkscontroller.text;
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
            backgroundColor: Color(0xFF184f8d),
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
            backgroundColor: Color(0xFF184f8d),
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
   // transitdata.loadtransitdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Imp-Rail-Seal Verification",
          style: TextStyle(
            fontSize: 19.0,
          ),
        ),
        backgroundColor: Color(0xFF184f8d),
        //centerTitle: true,
      ),
      bottomNavigationBar: Container(
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
                      backgroundColor: Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  openCamera();
                }
              },
              child: Text(
                "Take Photo",
                style: TextStyle(fontSize: 18.0),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(color: Colors.black)),
              elevation: 10.0,
              color: Colors.green,
              textColor: Colors.white,
            )),
            Expanded(
                child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(color: Colors.black)),
              elevation: 10.0,
              onPressed: () {
                if (searchTextField.textField!.controller!.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please enter container no.",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if ((imageFile == null)) {
                  Fluttertoast.showToast(
                      msg: "Please Upload Image",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  Onpressed();
                }
              },
              color: Colors.redAccent,
              textColor: Colors.white,
              child: Text("Upload", style: TextStyle(fontSize: 18.0)),
            )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: const EdgeInsets.only(top: 10.0)),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text("Container No."),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 95.0, top: 10.0),
              child: SizedBox(
                height: 40,
                width: 300,
                child: searchTextField = AutoCompleteTextField<Gateintransit>(
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                        hintStyle: TextStyle(color: Colors.black)),
                    inputFormatters: [new LengthLimitingTextInputFormatter(11),// for mobile
                    ],
                    itemSubmitted: (item) {
                      setState(() {
                        searchTextField.textField?.controller?.text = item.containerNo;
                        imageFile=null;
                      });
                      print("Data");
                      print(searchTextField.textField?.controller?.text);
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
                            style: TextStyle(fontSize: 16.0),
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
            SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text("Remarks"),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 400, // <-- TextField width
              height: 250,
              child: TextField(
                controller: remarkscontroller,
                maxLines: 500,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5.0, left: 8.0)),
            Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Builder(builder: (context) {
                  return imageFile != null
                      ? SizedBox(
                          height: 200,
                          child: Stack(
                            children: [
                              Container(
                                width: 80,
                                height: 100,
                                child: Image.file(File(imageFile!.path)),
                              ),
                              Positioned(
                                  right: 15,
                                  top: -14,
                                  child: IconButton(
                                      icon: Icon(
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
    print("ABCD");
    print(imageFile);
  }
}
