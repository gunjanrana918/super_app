// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import '../Services/typeaheadmodel.dart';
//
//
// class NetworkTypeAheadPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     body: SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.all(16),
//         child: TypeAheadField<User?>(
//           hideSuggestionsOnKeyboardHide: false,
//           textFieldConfiguration: TextFieldConfiguration(
//             decoration: InputDecoration(
//               prefixIcon: Icon(Icons.search),
//               border: OutlineInputBorder(),
//               hintText: 'Search Username',
//             ),
//           ),
//           suggestionsCallback: UserApi.getUserSuggestions,
//           itemBuilder: (context, User? suggestion) {
//             final user = suggestion!;
//
//             return ListTile(
//               title: Text(user.containerNo),
//             );
//           },
//           noItemsFoundBuilder: (context) => Container(
//             height: 100,
//             child: Center(
//               child: Text(
//                 'No Users Found.',
//                 style: TextStyle(fontSize: 24),
//               ),
//             ),
//           ),
//           onSuggestionSelected: (User? suggestion) {
//             final user = suggestion!;
//
//           },
//         ),
//       ),
//     ),
//   );
// }