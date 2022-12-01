import 'package:blog/Screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromARGB(63, 120, 245, 1),
          accentColor: Colors.white,
          scaffoldBackgroundColor: Color.fromRGBO(30, 30, 30, 1),
          textTheme: const TextTheme(bodyText2: TextStyle(color: Color.fromRGBO(243, 243, 243, 1))),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.grey,),
            labelStyle: TextStyle(color: Colors.white,),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        home: SplashScreen());
  }
}  
