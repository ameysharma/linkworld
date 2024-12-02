import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: 
  FirebaseOptions(
      apiKey: "AIzaSyDOp0hRTFdbl1_sxO-SHt1oVZ2ezReLu_U",
      authDomain: "b2bmarketplace-468c9.firebaseapp.com",
      projectId: "b2bmarketplace-468c9",
      storageBucket: "b2bmarketplace-468c9.firebasestorage.app",
      messagingSenderId: "638655904280",
      appId: "1:638655904280:web:d01a6a73c1b1b80955a16d",
      measurementId: "G-LPZ0WSKYMB"
      ),);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(), // Create a HomePage widget
        // '/register': (context) => RegisterPage(), // Create a RegisterPage widget
      },
    );
  }
}