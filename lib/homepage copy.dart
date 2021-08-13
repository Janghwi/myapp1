import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/menucategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';

import 'models/languageprovider.dart';
import 'models/myflexibleappbar.dart';
import 'models/myappbar.dart';
import 'router/routing_constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

//import 'package:opentrivia/ui/pages/home.dart';

class HomePage extends StatefulWidget {
  final String argument;
  const HomePage({Key key, this.argument}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: MyAppBar(),
            floating: true,
            pinned: true,
            expandedHeight: 140,
            flexibleSpace: FlexibleSpaceBar(
              background: MyFlexiableAppBar(),
            ),
          ),
          SliverFillRemaining(
              fillOverscroll: true,
              hasScrollBody: true,
              child: listPage(context))
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(iconSize: 20, items: [
      //   BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text("Home"),
      //       backgroundColor: Colors.black38),
      //   BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite_border),
      //       title: Text("Favorites"),
      //       backgroundColor: Colors.black38),
      //   BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       title: Text("Search"),
      //       backgroundColor: Colors.black38),
      //   BottomNavigationBarItem(
      //       icon: Icon(Icons.transform),
      //       title: Text("Translate"),
      //       backgroundColor: Colors.black38),
      // ]),
      drawer: Drawer(
        // 리스트뷰 추가
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // 드로워해더 추가
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            // 리스트타일 추가
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // 네이게이터 팝을 통해 드로워를 닫는다.
                Navigator.pop(context);
              },
            ),
            // 리스트타일 추가
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // 드로워를 닫음
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget listPage(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;

  final pokeSize = screenSize.width * 0.65;

  Future _data;

  Future getMenus() async {
    var firestore = Firestore.instance;
    QuerySnapshot snapshot =
        await firestore.collection("mainmenu").orderBy('id').getDocuments();
    snapshot.documents.forEach((document) {
      // print (document);
      //  print (snapshot.documents);
    });
    return snapshot.documents;
  }

  //2번 로딩하는것을 막기위해서 저장
  _data = getMenus();
  //print('pressed');

  final langSet = Provider.of<LanguageLoad>(context, listen: true);

  return Container(
    width: screenSize.width,
    //duration: Duration(seconds: 1),
    // decoration: BoxDecoration(
    //   gradient: LinearGradient(
    //     begin: Alignment.topCenter,
    //     end: Alignment.bottomCenter,
    //     colors: <Color>[
    //       Colors.amber.withAlpha(0),
    //       Colors.white,
    //       Colors.white,
    //     ],
    //   ),
    // ),
    child: FutureBuilder(
      future: _data,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("Loading"),
          );
        } else {
          return GridView.builder(
            itemCount: snapshot.data.length,
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              childAspectRatio: 2.44,
            ),
            itemBuilder: (_, index) {
              return MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    return Navigator.pushNamed(context, MenuViewRoute,
                        arguments: menuCategories[index].routeName);
                    //return Navigator.push(context, menuCategories[index].routeName);
                  },
                  //color: Colors.blue[100 * (index % 9)],
                  color: Colors.black26,
                  splashColor: Colors.black45,
                  highlightColor: Colors.red,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          menuCategories[index].icon,
                          //.fiber_pin,
                          color: Colors.blueGrey,
                        ),
                        // CircleAvatar(child: 
                        // Image.asset(
                        //   "images/02.png",
                        //   width: pokeSize,
                        //   height: pokeSize,
                        //   alignment: Alignment.bottomRight,
                        //   color: Color(0xFF303943).withOpacity(0.6),
                        // ),
                       // Padding(padding: EdgeInsets.fromLTRB(0, 15, 10, 0),),
                      Padding(padding: EdgeInsets.fromLTRB(15, 20, 10, 0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width:85,
                              height:80,
                              child: AutoSizeText(
                                snapshot.data[index].data['${langSet.langSet}'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    ),
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                minFontSize: 10,
                                maxFontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          );
        }
      },
    ),
  );
}
