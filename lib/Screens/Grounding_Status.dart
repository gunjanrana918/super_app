import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Models/JO_Statusupdate.dart';
import '../Models/JOdata_submit_model.dart';
import '../Models/JobOrder_Details.dart';
import '../Models/jobcontainer_Status.dart';
import '../universal.dart';
import 'package:http/http.dart' as http;

import 'Grounding_Request.dart';
import 'Status_Update.dart';

class Nestedtabbar extends StatefulWidget {
  const Nestedtabbar({super.key});

  @override
  State<Nestedtabbar> createState() => _NestedtabbarState();
}

class _NestedtabbarState extends State<Nestedtabbar> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 1,
          backgroundColor: const Color(0xFF184f8d),
          bottom: const TabBar(
              labelColor: Colors.limeAccent,
              indicatorColor: Colors.limeAccent,
              unselectedLabelColor: Colors.white,
              labelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                Tab(
                  text: "Container No.",
                ),
                Tab(text: "Job Order")
              ]),
        ),
        body: const TabBarView(
            children: [
              Groundingserach(),
              joGroundingserach()]
        ),
      ),
    );
  }
}


