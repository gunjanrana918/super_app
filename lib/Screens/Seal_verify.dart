import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../Models/Container_validation model.dart';
import '../Models/ILE_Imageupload.dart';
import '../universal.dart';

class Homescreeninfo extends StatefulWidget {
  const Homescreeninfo({Key? key}) : super(key: key);

  @override
  State<Homescreeninfo> createState() => _HomescreeninfoState();
}

int index = 0;

class _HomescreeninfoState extends State<Homescreeninfo> {
  Imageupload? parsedata;
  ValidContainer? newvaliddata;
  final TextEditingController sealcontainercontroller = TextEditingController();
  final TextEditingController remarkscontroller = TextEditingController();
  final picker = ImagePicker();
  String selectedvalue = "3";
  File? imageFile;
  var message;
  bool sealobject = false;
  List<XFile>? selectedimageslist=[];
  Pickimage() async {
    var selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages.isNotEmpty) {
      selectedimageslist!.addAll(selectedImages);
      sealobject=false;
      setState(() {
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
    request.fields["containerno"] =
        sealcontainercontroller.text.replaceAll(":", "");
    request.fields["activitytype"] = selectedvalue.toString();
    request.fields["remarks"] = remarkscontroller.text;
    if (sealobject ==true) {
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
      print(message);
      Globaldata.esealmessage = message;
      print("Globaldata.Message");
      print(Globaldata.esealmessage);
      Fluttertoast.showToast(
          msg: Globaldata.esealmessage,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: Globaldata.esealmessage,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  ///****Container Validation API***////
  Valid_container() async {
    int index = 0;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET',
        Uri.parse('http://103.25.130.254/grfl_login_api/Api/Checkcontainer'));
    request.body = json.encode({
      "ContainerNo": sealcontainercontroller.text,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print(responseData);
      newvaliddata = ValidContainer.fromJson(jsonDecode(responseData));
      print(newvaliddata!.ileTable[index].msg);
      var mynewmessage = newvaliddata!.ileTable[index].msg;
      Globaldata.validsealmessage = mynewmessage;
      print(Globaldata.validsealmessage);
      if (newvaliddata!.ileTable[index].error == false) {
        Fluttertoast.showToast(
            msg: Globaldata.validsealmessage,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 5,
            backgroundColor: Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          _showDialog();
        });

        //_showDialog();
      } else {
        Fluttertoast.showToast(
            msg: newvaliddata!.ileTable[index].msg,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
      }
      return newvaliddata;
    } else {
      Fluttertoast.showToast(
          msg: newvaliddata!.ileTable[index].msg,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "e-Seal Verification",
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
                if (sealcontainercontroller.text.length != 11 &&
                    sealcontainercontroller.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please enter 11 digit container no.",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  Valid_container();
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
                if (sealcontainercontroller.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please enter 11 digit container no.",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (remarkscontroller.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please fill remark.",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                else if ((imageFile == null)&& (selectedimageslist == null)) {
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
                  asyncFileUpload();
                  sealcontainercontroller.clear();
                  remarkscontroller.clear();
                  setState(() {
                    imageFile = null;
                    selectedimageslist!.clear();
                  });

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
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                height: 45,
                width: 300,
                child: TextFormField(
                  inputFormatters: [UpperCaseTextFormatter()],
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.emailAddress,
                  controller: sealcontainercontroller,
                  decoration: InputDecoration(
                      hintText: "Please Enter Container No.",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          sealcontainercontroller.clear();
                        },
                        child: Icon(
                          Icons.clear,
                          color: Color(0xFF184f8d),
                        ),
                      )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Container(
                width: 300,
                child: TextFormField(
                  controller: remarkscontroller,
                  minLines: 2,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Type Remark Here.........",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
              thickness: 2,
            ),
            Padding(padding: EdgeInsets.only(top: 5.0, left: 8.0)),
            Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Builder(builder: (context) {
                  if (sealobject == false) {
                    return selectedimageslist!=null?
                      SizedBox(
                      height: 150,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, crossAxisSpacing: 2),
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
                  GestureDetector(
                    child: Text('Gallery', style: TextStyle(fontSize: 20.0)),
                    onTap: () {
                      Pickimage();
                      setState(() {});
                      Navigator.of(this.context).pop(false);
                    },
                  ),
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

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
