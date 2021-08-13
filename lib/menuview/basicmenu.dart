import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enkornese/models/customtext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../medibook.dart';
import 'package:firebase_image/firebase_image.dart';

import '../youtubemenu.dart';

class BasicMenu extends StatefulWidget {
  String firestoreName;

  BasicMenu({Key key, this.firestoreName}) : super(key: key);

  @override
  _BasicMenuState createState() => _BasicMenuState();
}

class _BasicMenuState extends State<BasicMenu> {
  String firestoreName;

  final colors = [
    Color(0xFFEF7A85),
    Color(0xFFFF90B3),
    Color(0xFFFFC2E2),
    Color(0xFF8c4fff),
    Color(0xFF826ab0),
    Color(0xFF5927b8),
    Color(0xFFB892FF),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int rand;
    //int randImg;
    String imgId = 'WqGfsp2EY9U.jpg';

    return SafeArea(
      child: Scaffold(
        body: PaginateFirestore(
          itemBuilder: (context, documentSnapshot) => Container(
            padding: EdgeInsets.all(15),
            child: InkWell(
              onTap: () {
                print([documentSnapshot.data['space']]);
                Get.toNamed('/second',
                    arguments: documentSnapshot.data['space']);
              },
              // onTap: () async {
              //   firestoreName = documentSnapshot.data['space'];
              //   print(firestoreName);
              //   firestoreName = await Get.toNamed(YoutubeMenu(result: documentSnapshot.data['space']));
              //   setState(() {});
              // },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          //Text(documentSnapshot.data['id'].toString()),
                          Text(documentSnapshot.data['eng']),
                          //Text(documentSnapshot.data['c_title']),
                          //Text('Channel : ' + documentSnapshot.data['c_title']),
                          //Text(documentSnapshot.data['v_id']),
                          //Text('Publish : ' +
                          //    documentSnapshot.data['pubdate'].toString()),
                          Divider(color: Colors.black38)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    //flex: 9,
                    child: Container(
                      padding: EdgeInsets.only(right: 15),
                      child: Card(
                        elevation: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: FirebaseImage(
                                //   documentSnapshot.data['v_id'].toString()),
                                'gs://eloquent-theme-266209.appspot.com/lang01/Slide1.jpg'),
                            //"gs://eloquent-theme-266209.appspot.com/lang01/documentSnapshot.data['v_id'].toString())",
                            // Works with standard parameters, e.g.
                            fit: BoxFit.fitWidth,
                            width: 80,
                            // ... etc.
                          ),
                          // Image.asset(
                          //   'images/girl$randImg.jpg',
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                      ),
                      // decoration: BoxDecoration(
                      //   boxShadow: [
                      //     new BoxShadow(
                      //         color: colors[rand],
                      //         offset: Offset(20, -20),
                      //         spreadRadius: -10)
                      //   ],
                      // ),
                    ),
                  ),
                  // child: Image(
                  //   image: FirebaseImage(
                  //       'gs://eloquent-theme-266209.appspot.com/lang01/documentSnapshot.data[v_id].jpg'),
                  //   // Works with standard parameters, e.g.
                  //   fit: BoxFit.fitWidth,
                  //   width: 100,
                  //   // ... etc.
                  // ),
                  // Image.asset(
                  //   'images/girl$randImg.jpg',
                  //   fit: BoxFit.fill,
                  // ),
                ],
              ),
            ),
          ),
          query: Firestore.instance.collection('basic01c').orderBy('id'),
        ),
      ),
    );
  }
}
