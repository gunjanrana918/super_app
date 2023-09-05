import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../Models/Container_validation model.dart';
import '../Models/ILE_Imageupload.dart';
import '../Models/Reffercontainer_model.dart';
import '../Models/Temprefeer_containermodel.dart';
import '../universal.dart';
import '../Models/Esealsuggestion_search.dart';
import 'Dashboard_screen.dart';

class Tempmonitor extends StatefulWidget {
  const Tempmonitor({Key? key}) : super(key: key);

  @override
  State<Tempmonitor> createState() => _TempmonitorState();
}

int index = 0;
class _TempmonitorState extends State<Tempmonitor> {
  Imageupload? parsedata;
  ReffercontainerModel? newvaliddata;
  final TextEditingController remarkscontroller = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<Temprefer>> key = new GlobalKey();
  late  AutoCompleteTextField searchTextField;
  TextEditingController controller = TextEditingController();
  final TempViewModel tempdata = TempViewModel();
  final picker = ImagePicker();
  String selectedvalue = "4";
  File? imageFile;
  var message;
  bool sealobject = false;
  List<XFile>? selectedimageslist=[];
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
  Pickimage() async {
    var selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        selectedimageslist!.addAll(selectedImages);
        sealobject=false;
      });
      print(selectedImages.length);
      print(selectedimageslist?.length.toString());
    }
  }
  //Imageupload function/////
  asyncFileUpload() async {
    int index = 0;
    var request = http.MultipartRequest(
        "POST", Uri.parse("http://103.25.130.254/grfl_login_api/Api/ILE"));
    request.fields["containerno"] = searchTextField.textField!.controller!.text;
    print(searchTextField.textField!.controller!.text);
    request.fields["activitytype"] = selectedvalue.toString();
    request.fields["remarks"] = remarkscontroller.text;
    request.fields["arrivaldate"] = Globaldata.refferarrivaldate ;
     print(Globaldata.refferarrivaldate);
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
            backgroundColor: Color(0xFF184f8d),
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
  ///****Container Validation API***////
  Reffer_container() async {
    int index = 0;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/CheckContainerReefer'));
    request.body = json.encode({
      "ContainerNo": searchTextField.textField!.controller!.text
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      newvaliddata = ReffercontainerModel.fromJson(json.decode(responseData));
      Globaldata.refferarrivaldate = newvaliddata!.ileTable[index].arrivalDate;
      print("Location");
      print(Globaldata.refferarrivaldate);
     openCamera();
      return newvaliddata;
    }
  }
  @override
  void initState() {
    super.initState();
    tempdata.loadreffercontainer();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text(
            "Temprature Monitoring",
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
                      }
                      else {
                        Reffer_container();
                        //openCamera();
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
                      }
                      else {
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
              const Padding(padding: EdgeInsets.only(top: 10.0)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:22.0),
                    child: Text("Container No."),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 95.0,top: 10.0),
                child: SizedBox(
                  height: 40,
                  width: 300,
                  child:
                  searchTextField = AutoCompleteTextField<Temprefer>(
                      style:  TextStyle(color: Colors.black, fontSize: 16.0),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                          hintStyle: TextStyle(color: Colors.black)),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(11),// for mobile
                      ],
                      itemSubmitted: (item) {
                        setState(() {
                          searchTextField.textField?.controller?.text = item.containerNo;
                          imageFile=null;
                        });
                      },
                      clearOnSubmit: false,
                      key: key,
                      suggestions:  tempdata.Data,
                      itemBuilder: (context, item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(item.containerNo,
                              style: TextStyle(
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
                    child: Text("Remarks"),
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
                    enabledBorder: OutlineInputBorder(
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
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5, crossAxisSpacing: 4),
                          itemCount: selectedimageslist!.length,
                          itemBuilder: (context, int index) {
                            return
                              Stack(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    child: Image.file(
                                        File(selectedimageslist![index].path)),
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
                            Container(
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
        context: this.context,
        builder: (BuildContext) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(10.0),
              shape: Border.all(color: Colors.red, width: 2),
              title: Text(
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
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      GestureDetector(
                        child: Text('Camera',
                            style: TextStyle(fontSize: 20.0, color: Colors.red)),
                        onTap: () {
                          openCamera();
                          setState(() {});
                          Navigator.of(this.context).pop(false);
                        },
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(this.context).pop(false);
                                },
                                child: Text(
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
    print("ABCD");
    print(imageFile);
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
    print("ABCD");
    print(imageFile);
  }
}


