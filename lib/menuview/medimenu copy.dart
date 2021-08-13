import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MediMenu extends StatelessWidget {
  final String firestoreName;

  MediMenu({Key key, this.firestoreName}) : super(key: key);

  final colors = [
    Color(0xFFEF7A85),
    Color(0xFFFF90B3),
    Color(0xFFFFC2E2),
    Color(0xFF8c4fff),
    Color(0xFF826ab0),
    Color(0xFF5927b8),
    Color(0xFFB892FF),
  ];
  Stream<QuerySnapshot> phrasesDocStream =
      Firestore.instance.collection('ytbook001').snapshots();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int rand, randImg;
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 155),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, i) {
                  rand = new Random().nextInt(colors.length);
                  randImg = new Random().nextInt(6) + 1;
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: height / 5,
                          color: colors[rand],
                        ),
                      ),
                      Expanded(
                        flex: 12,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
                              child: Text(
                                "수면음악/좋은책/멋진영상/항상 새로운 아침",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "우리 영혼의 안식을 위하여.....",
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          padding: EdgeInsets.only(right: 15),
                          child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'images/girl$randImg.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              new BoxShadow(
                                  color: colors[rand],
                                  offset: Offset(20, -20),
                                  spreadRadius: -10)
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            buildAppBar(width, height),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(double width, double height) {
    return Container(
      height: 226,
//      color: Colors.blue,
      child: ClipPath(
          clipper: MyClipper(),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                  ),
                  fit: BoxFit.fill),
            ),
            child: Column(
              children: <Widget>[
                AppBar(
                  title: Text(
                    "For your better life ",
                    style: TextStyle(color: Colors.blue),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text("언제나 행복하세요"),
                    subtitle: Text("인생은 짧습니다 "),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                      ),
                      radius: 25,
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height - 50);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
