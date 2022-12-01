import 'package:blog/Screens/loginScreen.dart';
import 'package:blog/Screens/uploadblog.dart';
import 'package:blog/Screens/profile.dart';
import 'package:blog/Screens/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:core';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final dbRef = FirebaseDatabase.instance.reference().child('Posts');
  TextEditingController seachcontroller = TextEditingController();
  String search = "";
  FirebaseAuth auth = FirebaseAuth.instance;
    
  void _onItemTapped(int index){
    setState(() {
        if (index == 0 ){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UploadBlog()));

        }
        else if (index == 2 ){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Profile()));

        }
      _selectedIndex = index;
    });
 }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(63, 120, 245, 1),
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('BlogPI feed'),
          leading: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
              child: Icon(Icons.account_circle),
            ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UploadBlog()));
              },
              child: Icon(Icons.add),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                auth.signOut().then((value) => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen())));
              },
              child: Icon(Icons.logout),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Posts',
                ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
                ),
             ],
             currentIndex: _selectedIndex,
             onTap: _onItemTapped,
             selectedItemColor: Color.fromRGBO(63, 120, 245, 1),
             unselectedItemColor: Colors.grey,
             ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                  controller: seachcontroller,
                  decoration: InputDecoration(
                      hintText: "Search with blog title",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.normal),
                      labelStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.normal)),
                  onChanged: (String value) {
                    search = value;
                  }),
            ),
            Expanded(
                child: FirebaseAnimatedList(
                    query: dbRef.child('Post List'),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      String tempTitle =
                          snapshot.child('pTitle').value.toString();
                      if (seachcontroller.text.isEmpty) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 187, 184, 184),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/blog.png',
                                      image: snapshot
                                          .child('pImage')
                                          .value!
                                          .toString(),
                                        fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child:
                                  InkWell(
                                      onTap: () {
                                          var post = {
                                            "title": snapshot.child('pTitle').value!.toString(),
                                            "description": snapshot.child('pDescription').value!.toString(),
                                            "image": snapshot.child("pImage").value!.toString(),
                                            "pId": snapshot.child("pId").value!.toString(),
                                            "user": snapshot.child("uEmail").value!.toString(),
                                          };
                                          //print(post);
                                          Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => Post(blogpost: post)));
                                        },
                                        child: new Text(
                                        snapshot
                                          .child('pTitle')
                                          .value!
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                    ),
                                    ),
                                  ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      snapshot
                                          .child('pDescription')
                                          .value!
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ));
                      } else if (tempTitle
                          .toLowerCase()
                          .contains(seachcontroller.text.toString())) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 187, 184, 184),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/images/logo.png',
                                        image: snapshot
                                            .child('pImage')
                                            .value!
                                            .toString(),
                                        width: 300,
                                        height: 10,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        snapshot
                                            .child('pTitle')
                                            .value!
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        snapshot
                                            .child('pDescription')
                                            .value!
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ]),
                            ));
                      } else {
                        return Container();
                      }
                    })),
          ],
        ),
      ),
    );
  }
}
