
import 'package:flutter/material.dart';
import 'package:super_app/Screens/Login_screen.dart';
import 'package:super_app/Screens/Splash_screen.dart';


void main()  {
  //WidgetsFlutterBinding.ensureInitialized();
  //HttpOverrides.global =  MyHttpOverrides();
  runApp( MyApp(
  ));
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Splashscreen(),
    );
  }
}


// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient (SecurityContext context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }


