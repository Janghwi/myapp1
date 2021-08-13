import 'package:flutter/material.dart';
import './models/menucategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

import 'package:substring_highlight/substring_highlight.dart';

//import 'package:opentrivia/ui/pages/home.dart';

class SecondMenu2 extends StatelessWidget {
  final String firestoreName;

  SecondMenu2({@required this.firestoreName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Patern categories'),
            floating: true,
            pinned: true,
            expandedHeight: 50,
            //   flexibleSpace: FlexibleSpaceBar(
            //     background: MyFlexiableAppBar(),
            // ),
          ),
          SliverFillRemaining(
              fillOverscroll: true,
              hasScrollBody: true,
              child: listPage(context))
        ],
      ),
    );
  }

  Widget listPage(BuildContext context) {
    Future _datas;

    Future getMenus() async {
      var firestore = Firestore.instance;
      QuerySnapshot snapshot = await firestore
          .collection(firestoreName)
          .orderBy('id')
          .getDocuments();
      snapshot.documents.forEach((document) {
        // print (document);
        //  print (snapshot.documents);
      });

      return snapshot.documents;
    }

    _datas = getMenus();
    print('pressed');

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      decoration: BoxDecoration(
        color: Colors.amber[100],
      ),
      child: FutureBuilder(
        future: _datas,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading"),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                padding: EdgeInsets.all(8),
                itemBuilder: (_, index) {
                  return Card(
                    color: Color(0xFF7C538C),
                    child: InkWell(
                      onTap: () {
                        print(mainMenuCategories[index].routeName);
                        print(mainMenuCategories.length);
                        return Navigator.pushNamed(
                            context, mainMenuCategories[index].routeName);
                        //return Navigator.push(context, menuCategories[index].routeName);
                      },
                      //color: Colors.blue[100 * (index % 9)],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //첫번째 row snapshot.data[index].data['${_langSet.currentlangSet}'],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(snapshot.data[index].data['id'].toString(),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white54)),
                              Text('/',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white54)),
                              Text(snapshot.data.length.toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white54)),
                            ],
                          ),
                          //영어출력 Text(snapshot.data[index].data['eng']
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  child: Image.asset('images/usa.png'),
                                  radius: 5.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => null,
                                child: SubstringHighlight(
                                  text: snapshot.data[index].data['eng'],
                                  term: "날씨",
                                  textStyle: GoogleFonts.lato(
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textStyleHighlight: GoogleFonts.lato(
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //한국어
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: CircleAvatar(
                                  child: Image.asset('images/korea.png'),
                                  radius: 12.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => null,
                                child: SubstringHighlight(
                                  text: snapshot.data[index].data['kor'],
                                  term: "날씨",
                                  textStyle: GoogleFonts.nanumGothic(
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textStyleHighlight: GoogleFonts.lato(
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //일본어
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  child: Image.asset('images/japan.png'),
                                  radius: 5.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => null,
                                child: SubstringHighlight(
                                  text: snapshot.data[index].data['jap'],
                                  term: "날씨",
                                  textStyle: GoogleFonts.mPLUSRounded1c(
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textStyleHighlight: GoogleFonts.lato(
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Container(
                          //   width: double.infinity,
                          //   padding: EdgeInsets.only(
                          //       top: 3.0, right: 10.0, bottom: 5.0, left: 10.0),
                          //   child: Text(
                          //     snapshot.data[index].data['kor'],
                          //     textAlign: TextAlign.start,
                          //     overflow: TextOverflow.ellipsis,
                          //     style: GoogleFonts.lato(
                          //       textStyle: Theme.of(context).textTheme.display1,
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.w400,
                          //       color: Colors.white,
                          //       fontStyle: FontStyle.normal,
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   width: double.infinity,
                          //   padding: EdgeInsets.only(
                          //       right: 10.0, bottom: 5.0, left: 10.0),
                          //   child: Text(
                          //     snapshot.data[index].data['jap'],
                          //     textAlign: TextAlign.start,
                          //     overflow: TextOverflow.ellipsis,
                          //     style: GoogleFonts.mPLUSRounded1c(
                          //       textStyle: Theme.of(context).textTheme.display1,
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.w400,
                          //       color: Color(0xfffcbb71),
                          //       fontStyle: FontStyle.normal,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
