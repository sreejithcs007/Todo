import 'package:firebase_core/firebase_core.dart';
import 'package:firebasesample/view/homepage.dart';
import 'package:firebasesample/view/login.dart';
import 'package:flutter/material.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: FirebaseOptions(apiKey: "AIzaSyAx9CCWIBJZyPf_TrtH6FrP0IXi8zoc9C8",
         appId: "1:299880691446:android:72f9c2f9fff7051c839ed7", messagingSenderId: "", projectId:  "newtask-74490",
     storageBucket: "newtask-74490.appspot.com"
     )
   );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Login(),
    );
  }
}

