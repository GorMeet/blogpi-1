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
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool showSpinner = false;
  final postRef = FirebaseDatabase.instance.reference().child("Posts");
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

    //final FirebaseAuth _auth = FirebaseAuth.instance;
    //final User? user = _auth.currentUser;

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        leading: Icon(Icons.camera_alt),
                        title: Text("Camera"),
                      )),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        leading: Icon(Icons.photo_library),
                        title: Text("Gallery"),
                      ))
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(
            child: const Text('Profile'),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue,],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.5, 0.9],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.blue.shade300,
                        minRadius: 35.0,
                        child: Icon(
                          Icons.call,
                          size: 30.0,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 60.0,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(
                              'https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue.shade300,
                        minRadius: 35.0,
                        child: Icon(
                          Icons.message,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "User",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    //return ModalProgressHUD(
    //  inAsyncCall: showSpinner,
    //  child: Scaffold(
    //      appBar: AppBar(
    //        backgroundColor: Colors.blueAccent,
    //        title: Text('Profile'),
    //        centerTitle: true,
    //      ),
    //      body: SingleChildScrollView(
    //          child: Padding(
    //        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    //        child: Column(
    //          children: [
    //            Center(
    //              child: InkWell(
    //                onTap: () => dialog(context),
    //                child: Container(
    //                    height: MediaQuery.of(context).size.height * .4,
    //                    width: MediaQuery.of(context).size.width * 1,
    //                    child: Container(
    //                            decoration: BoxDecoration(
    //                              color: Color.fromARGB(255, 203, 201, 201),
    //                              borderRadius: BorderRadius.circular(10),
    //                            ),
    //                            width: 100,
    //                            height: 100,
    //                            child: Icon(
    //                              Icons.camera_alt,
    //                              color: Colors.blue,
    //                            ),
    //                          )),
    //              ),
    //            ),
    //            SizedBox(
    //              height: 30,
    //            ),
    //            SizedBox(height: 30),
    //            RoundButton(
    //                title: "Upload",
    //                onPress: () async {
    //                  setState(() {
    //                    showSpinner = true;
    //                  });

    //                  try {
    //                    int date = DateTime.now().microsecondsSinceEpoch;

    //                    firebase_storage.Reference ref = firebase_storage
    //                        .FirebaseStorage.instance
    //                        .ref('/blogapp$date');
    //                    var newUrl = await ref.getDownloadURL();

    //                    final User? user = _auth.currentUser;
    //                    postRef.child('Post List').child(date.toString()).set({
    //                      'pId': date.toString(),
    //                      'pTime': date.toString(),
    //                      'uEmail': user!.email.toString(),
    //                      'uId': user.uid.toString(),
    //                    }).then((value) {
    //                      toastMessage('Post Published');
    //                      setState(() {
    //                        showSpinner = false;
    //                        Navigator.pop(context);
    //                      });
    //                    }).onError((error, stackTrace) {
    //                      toastMessage(e.toString());
    //                    });
    //                  } catch (e) {
    //                    setState(() {
    //                      showSpinner = false;
    //                    });
    //                    toastMessage(e.toString());
    //                  }
    //                })
    //          ],
    //        ),
    //      ))),
    //);
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
