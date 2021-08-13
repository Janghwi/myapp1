import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../medibook.dart';
import '../youtubemenu.dart';

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
      child: Stack(children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 155),
          child: StreamBuilder(
            stream: phrasesDocStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data.documents.length > 0) {
                // get course document
                var phrasesDocument = snapshot.data.documents[0];
                // build list using names from sections
                return ListView.builder(
                  itemCount: phrasesDocument.data.length,
                  itemBuilder: (_, int index) {
                    rand = new Random().nextInt(colors.length);
                    randImg = new Random().nextInt(6) + 1;

                    return GestureDetector(
                      onTap: () {
                        Get.to(MediBook());
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: height / 5,
                              color: colors[rand],
                            ),
                          ),
                          Expanded(
                            flex: 14,
                            child: itemView(
                                phrasesDocument[(index + 1).toString()],
                                (index + 1).toString()),
                          ),
                          Expanded(
                            flex: 9,
                            child: Container(
                              padding: EdgeInsets.only(right: 15),
                              child: Card(
                                elevation: 15,
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
                      ),
                    );
                  },
                );
              } else {
                return Container(
                  child: Center(
                    child: Text("No data Found"),
                  ),
                );
              }
            },
          ),
        ),
        buildAppBar(width, height),
      ]),
    ));
  }

  Widget itemView(var item, var itemNumber) {
    return Column(
      children: <Widget>[
        //Text(item['id'].toString()),
        Text(item['title']),
        Text('Channel : ' + item['c_title']),
        //Text(item['v_id']),
        Text('Publish : ' + item['pubdate'].toString()),
        Divider(color: Colors.black38)
      ],
    );
  }
}

Widget buildAppBar(double width, double height) {
  return Container(
    height: 200,
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
