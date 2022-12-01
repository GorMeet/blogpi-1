import 'dart:math';
import 'package:blog/Components/roundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Post extends StatefulWidget {
  final Map<String, String> blogpost;
  Post({Key? key, required this.blogpost}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool showSpinner = false;
  final dbRef = FirebaseDatabase.instance.reference().child('Posts');
  TextEditingController seachcontroller = TextEditingController();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  //final Map<String, String> post = blogpost;
  Map<String, String> get blogpost => this.blogpost;


  @override
  Widget build(BuildContext context) {
  final User? user = _auth.currentUser;
    return MaterialApp(
      title: 'Post',
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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(63, 120, 245, 1),
          title: Center(
            child: const Text('Post'),
          ),
        ),
        body: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: <Widget>[
            Text(widget.blogpost["title"].toString(),
            style: TextStyle(fontSize: 60.0),),
          Align(
            child: FadeInImage.assetNetwork(
              image: widget.blogpost["image"].toString(),
              placeholder: 'assets/images/blog.png',
              fit: BoxFit.cover,
              width: 350,
              height: 350,
            ),
          ),
            Text("Author: "+ widget.blogpost["user"].toString(),
            style: TextStyle(fontSize: 30.0, color: Colors.grey),),
            Text(widget.blogpost["description"].toString(),
            style: TextStyle(fontSize: 30.0),),
        ]
      ),
    )
    );
  }


  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
