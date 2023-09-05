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

class Warehouse extends StatefulWidget {
  const Warehouse({Key? key}) : super(key: key);

  @override
  State<Warehouse> createState() => _WarehouseState();
}

int index = 0;

class _WarehouseState extends State<Warehouse> {
  Imageupload? parsedata;
  List<Imageupload> list = [];
  String mycontainer = "";
  final TextEditingController sealcontainercontroller = TextEditingController();
  final TextEditingController remarkcontroller = TextEditingController();
  File? imageFile;
  ValidContainer? newesealdata;
  final picker = ImagePicker();
 bool Warehouseobject=false;
  String? selectedvalue;
  List<XFile>? selectedImagesList =[];
  asyncFileUpload() async {
    int index = 0;
    var request = http.MultipartRequest(
        "POST", Uri.parse("http://103.25.130.254/grfl_login_api/Api/ILE"));
    request.fields["containerno"] =
        sealcontainercontroller.text.replaceAll(":", "");
    request.fields["activitytype"] = selectedvalue.toString();
    request.fields["remarks"] = remarkcontroller.text;
    request.fields["arrivaldate"] = newesealdata!.ileTable[index].arrivalDate;
    Globaldata.ArrivalDate = newesealdata!.ileTable[index].arrivalDate;
    if (Warehouseobject==true){
      request.files.add(await http.MultipartFile.fromPath('', imageFile!.path));
    } else {
      for (int i = 0; i < selectedImagesList!.length; i++) {
        var newfile = selectedImagesList![i].path;
        request.files.add(await http.MultipartFile.fromPath('', newfile));
      }
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseToString = String.fromCharCodes(responseData);
      print("DATA1");
      print(responseToString);
      var parsedata = Imageupload.fromJson(json.decode(responseToString));
      print(parsedata.ileTable[index].msg);
      var message = parsedata.ileTable[index].msg;
      print(message);
      Globaldata.Message = message;
      print(Globaldata.Message);
      Fluttertoast.showToast(
          msg: parsedata.ileTable[index].msg,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
      sealcontainercontroller.clear();
      remarkcontroller.clear();
      setState(() {
        imageFile=null;
        selectedImagesList!.clear();
      });
    } else {
      Fluttertoast.showToast(
          msg: Globaldata.Message,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Pickimage()async {
    var selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        selectedImagesList!.addAll(selectedImages);
        Warehouseobject=false;
      });
      print(selectedImages.length);
      print(selectedImagesList?.length.toString());
    }
  }
  //****Container validate API****/////
  Validation_container() async {
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
      newesealdata = ValidContainer.fromJson(jsonDecode(responseData));
      print(newesealdata!.ileTable[index].msg);
      var mymessage = newesealdata!.ileTable[index].msg;
      Globaldata.validmessage = mymessage;
      Globaldata.ArrivalDate = newesealdata!.ileTable[index].arrivalDate;
      print(Globaldata.validmessage);
      if (newesealdata!.ileTable[index].error == false) {
        Fluttertoast.showToast(
            msg: newesealdata!.ileTable[index].msg,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
        _showDialog();
      } else {
        Fluttertoast.showToast(
            msg: "Container not in inventory",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
      }
      return newesealdata;
    } else {
      Fluttertoast.showToast(
          msg: "Container not in inventory",
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
          "Warehouse Activity",
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
                  Validation_container();
                }
              },
              child: Text(
                "Take Photo",
                style: TextStyle(fontSize: 18.0),
              ),
              color: Colors.green,
              textColor: Colors.white,
            )),
            Expanded(
                child: MaterialButton(
              onPressed: () {
                if (sealcontainercontroller.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please enter 11 digit container no.",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (remarkcontroller.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please fill remark.",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Color(0xFF184f8d),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if ((imageFile == null)&& (selectedImagesList == null)) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: const EdgeInsets.only(top: 10.0)),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left:13.0),
                  child: Text("Container No."),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 95.0),
              child: SizedBox(
                height: 40,
                width: 300,
                child: TextField(
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(11),// for mobile
                    ],
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.emailAddress,
                  controller: sealcontainercontroller,
                  decoration: InputDecoration(
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
            SizedBox(height: 10,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left:13.0),
                  child: Text("Remarks Here."),
                ),
              ],
            ),
            SizedBox(
              width: 400, // <-- TextField width
              height: 250,
              child: TextField(
                controller: remarkcontroller,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: RadioListTile(
                    title: Text(
                      "Stuffing",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    value: "1",
                    groupValue: selectedvalue,
                    onChanged: (value) {
                      setState(() {
                        selectedvalue = value.toString();
                      });
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: RadioListTile(
                      title: Text("Destuffing",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      value: "2",
                      groupValue: selectedvalue,
                      onChanged: (value) {
                        setState(() {
                          selectedvalue = value.toString();
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 5.0, left: 8.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Builder(
                      builder: (context){
                      if ((Warehouseobject!= true)) {
                        return selectedImagesList!=null?
                          SizedBox(
                          height: 300,
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing:4

                            ),
                            itemCount: selectedImagesList!.length,
                            itemBuilder: (context, int index) {
                              return
                                Stack(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      child: Image.file(
                                          File(selectedImagesList![index].path)),
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
                                              selectedImagesList!
                                                  .removeAt(index);
                                            })))
                                  ],
                                );
                            },
                          ),
                        ):Container();
                      }
                      else {
                        return imageFile!=null?
                          SizedBox(
                        height: 200,
                        child:Stack(
                          children: [
                            Container(
                              width:  150,
                              height: 120,
                              child: Image.file(
                                  File(imageFile!.path)),
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
                                      imageFile=null;
                                    })))
                          ],
                        ),
                      ):Container();
                      }
                      }
                  )
                )
              ],
            ),
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
                      //openGallery();
                      setState(() {});
                      Navigator.of(this.context).pop(false);
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  GestureDetector(
                    child: Text('Camera', style: TextStyle(fontSize: 20.0,color: Colors.red)),
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
  //select image from camera
  Future<void> openCamera() async {
    var pickedFile =
        (await picker.pickImage(source: ImageSource.camera, imageQuality: 25));
      setState(() {
        imageFile = File(pickedFile!.path);
        Warehouseobject=true;
      });

    print("ABCD");
    print(imageFile);
  }
}

//*****CAPITAL LETTERS FORMAT****////
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
