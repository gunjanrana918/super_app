import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../Models/JO_Statusupdate.dart';
import '../Models/jobcontainer_Status.dart';
import '../universal.dart';
import 'Grounding_Status.dart';

class demoSearch extends StatefulWidget {
  const demoSearch({Key? key}) : super(key: key);
  @override
  State<demoSearch> createState() => _demoSearchState();
}

class _demoSearchState extends State<demoSearch> {
  final List<jocontainer> _allUsers = [];
  List<jocontainer> _newlist = [];
  Future<String?>getdata() async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/JoStatusUpdate'));
    request.body = json.encode({
      "Location": "ghh",
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      Map newdata = json.decode(responseData);
     var jsondata = newdata['Data'] as List;
      print("data");
      print(jsondata.length);
      for (int i = 0; i < jsondata.length; i++) {
        _allUsers.add(jocontainer.fromJson(jsondata[i]));
      }
    } else {

    }

    //TO SHOW ALL LIST AT INITIAL
    setState(() {
      _newlist = _allUsers;
    });
    return null;
  }
  void _searchlist(String value) {
    setState(() {
      if (value.isEmpty) {
        _newlist = _allUsers;
      } else {
        _newlist = _allUsers
            .where((element) => element.containerNo
            .toString()
            .toLowerCase()
            .contains(value.toString().toLowerCase()))
            .toList();
      }
    });
  }
  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child:
              TextField(
                onChanged: (value) {
                  _searchlist(value);
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: _newlist.isNotEmpty?
              ListView.builder(
                itemCount: _newlist.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => description(
                      //       context,
                      //       _newlist[index]['name'],
                      //       _newlist[index]['age'],
                      //     ),
                      //   ),
                      // );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(_newlist[index].containerNo),
                        //subtitle: Text(_newlist[index]['age'].toString()),
                      ),
                    ),
                  );
                },
              ):Text("No Data Found"),
            ),
          ),
        ],
      ),
    );
  }
}
