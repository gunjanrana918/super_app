import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Models/ExportReeferTransit_Container.dart';
import '../Models/ILE_Imageupload.dart';
import '../Models/Reffercontainer_model.dart';
import '../universal.dart';

class Inyarddetail extends StatefulWidget {
  const Inyarddetail({Key? key}) : super(key: key);

  @override
  State<Inyarddetail> createState() => _InyarddetailState();
}
int indexx = 0;
class _InyarddetailState extends State<Inyarddetail> {
  Imageupload? parsedata;
  ReffercontainerModel? newvaliddata;
  final TextEditingController remarkscontroller = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<Exportrefertransit>> key = GlobalKey();
  late  AutoCompleteTextField searchTextField;
  TextEditingController controller = TextEditingController();
  final ExportreeferViewModel exportreeferdata = ExportreeferViewModel();
  final picker = ImagePicker();
  String selectedvalue = "4";
  File? imageFile;
  var message;
  bool sealobject = false;
  List<XFile>? selectedimageslist=[];
  Pickimage() async {
    var selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        selectedimageslist!.addAll(selectedImages);
        sealobject=false;
      });
    }
  }
  //Imageupload function/////
  asyncFileUpload() async {
    int index = 0;
    var request = http.MultipartRequest(
        "POST", Uri.parse("http://103.25.130.254/grfl_login_api/Api/ILE"));
    request.fields["containerno"] = searchTextField.textField!.controller!.text;
    request.fields["activitytype"] = selectedvalue.toString();
    request.fields["remarks"] = remarkscontroller.text;
    request.fields["arrivaldate"] = Globaldata.refferarrivaldate;
    request.fields["Location"] = Globaldata.Location;
    if (sealobject == true) {
      request.files.add(await http.MultipartFile.fromPath('', imageFile!.path));
    } else {
      for (int i = 0; i < selectedimageslist!.length; i++) {
        var newfile = selectedimageslist![i].path;
        request.files.add(await http.MultipartFile.fromPath('', newfile));
      }
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var newmyparsedata = Imageupload.fromJson(json.decode(responseData));
      message = newmyparsedata.ileTable[index].msg;
      Globaldata.tempmessage = message;
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
      }
      else {
        Fluttertoast.showToast(
            msg: 'Container not in inventory',
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
    exportreeferdata.loadrexporteffercontainer();
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
                      }
                      else {
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
                      }
                      else {
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
                    padding: EdgeInsets.only(left:22.0),
                    child: Text("Container No. -",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 95.0,top: 10.0),
                child: SizedBox(
                  height: 40,
                  width: 300,
                  child:
                  searchTextField = AutoCompleteTextField<Exportrefertransit>(
                      style:  const TextStyle(color: Colors.black, fontSize: 16.0),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                          hintStyle: TextStyle(color: Colors.black)),
                      inputFormatters: [
                         LengthLimitingTextInputFormatter(11),// for mobile
                      ],
                      itemSubmitted: (item) {
                        setState(() {
                          searchTextField.textField?.controller?.text = item.containerNo;
                          imageFile=null;
                        });
                      },
                      clearOnSubmit: false,
                      key: key,
                      suggestions:  exportreeferdata.exportData,
                      itemBuilder: (context, item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(item.containerNo,
                              style: const TextStyle(
                                  fontSize: 16.0
                              ),),
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
              const SizedBox(height: 10,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:22.0),
                    child: Text("Remarks -",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
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
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 5.0, left: 8.0)),
              Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Builder(builder: (context) {
                    if (sealobject == false) {
                      return selectedimageslist!=null?
                      SizedBox(
                        height: 300,
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5, crossAxisSpacing: 4),
                          itemCount: selectedimageslist!.length,
                          itemBuilder: (context, int index) {
                            return
                              Stack(
                                children: [
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: Image.file(
                                        File(selectedimageslist![index].path)),
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
                                            selectedimageslist!.removeAt(index);
                                          })))
                                ],
                              );
                          },
                        ),
                      ):Container();
                    } else {
                      return imageFile!=null?
                      SizedBox(
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
                      ):Container();
                    }
                  })),
            ],
          ),
        ),
      );
  }
  Future<void> _showDialog() {
    // ignore: missing_return
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(10.0),
              shape: Border.all(color: Colors.red, width: 2),
              title: const Text(
                'Select Image Source',
              ),
              content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      // GestureDetector(
                      //   child: Text('Gallery', style: TextStyle(fontSize: 20.0)),
                      //   onTap: () {
                      //     Pickimage();
                      //     setState(() {});
                      //     Navigator.of(this.context).pop(false);
                      //   },
                      // ),
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      GestureDetector(
                        child: const Text('Camera',
                            style: TextStyle(fontSize: 20.0, color: Colors.red)),
                        onTap: () {
                          openCamera();
                          setState(() {});
                          Navigator.of(context).pop(false);
                        },
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ))
                        ],
                      )
                    ],
                  )));
        });
  }
  Future<void> openGallery() async {
    var pickedFile =
    (await picker.pickImage(source: ImageSource.gallery, imageQuality: 25));
    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }
  //select image from camera
  Future<void> openCamera() async {
    var pickedFile =
    (await picker.pickImage(source: ImageSource.camera, imageQuality: 25));
    setState(() {
      imageFile = File(pickedFile!.path);
      sealobject = true;
    });
    setState(() {});
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