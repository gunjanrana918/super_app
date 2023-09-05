import 'package:flutter/material.dart';

class Groundinglistview extends StatefulWidget {
  const Groundinglistview({super.key});

  @override
  State<Groundinglistview> createState() => _GroundinglistviewState();
}
class _GroundinglistviewState extends State<Groundinglistview> {
  final examinationcontroller = TextEditingController();
  final weighmemcontroller = TextEditingController();
  bool agree = false;
  bool approve = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: agree,
                    onChanged: (value) {
                      setState(() {
                        agree = value!;
                      });
                      if (value!) {
                        setState(() {
                          examinationcontroller.text = '1';
                        });
                      } else {
                        examinationcontroller.text = '0';
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Text(
                      'Examination',
                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Checkbox(
                    value: approve,
                    onChanged: (value) {
                      setState(() {
                        approve = value!;
                      });
                      if (value!) {
                        setState(() {
                          weighmemcontroller.text = '1';
                        });
                      } else {
                        weighmemcontroller.text = '0';
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Text(
                      'Weighment',
                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(30.0),
              //       child: SizedBox(
              //         height: 35,
              //         width: 140,
              //         child: MaterialButton(
              //           onPressed: () {
              //             //submitJOdetails();
              //
              //           },
              //           child: Text(
              //             "Submit",
              //             style: TextStyle(fontSize: 18.0),
              //           ),
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(10.0),
              //               side: BorderSide(color: Colors.black)),
              //           elevation: 10.0,
              //           color: Color(0xFF184f8d),
              //           textColor: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
