import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/menucategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'models/languageprovider.dart';
import 'models/myflexibleappbar.dart';
import 'models/myappbar.dart';
import 'router/routing_constants.dart';

//import 'package:opentrivia/ui/pages/home.dart';

class HomePage1 extends StatelessWidget {
  final String argument;
  const HomePage1({Key key, this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff84FFFF),
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
  final pokeTop = -(screenSize.width * 0.19);
  final pokeRight = -(screenSize.width * 0.48);

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

  return AnimatedContainer(
    width: screenSize.width,
    duration: Duration(seconds: 0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Colors.amber.withAlpha(0),
          Colors.amber[100],
          Colors.amber[200]
        ],
      ),
    ),
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
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    return Navigator.pushNamed(context, MenuViewRoute,
                        arguments: mainMenuCategories[index].routeName);
                    //return Navigator.push(context, menuCategories[index].routeName);
                  },
                  //color: Colors.blue[100 * (index % 9)],
                  color: Color(0xFF58ABF6),
                  splashColor: Colors.white10,
                  highlightColor: Colors.white10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 18,
                          right: 2,
                          left: 72,
                          bottom: 8,
                          child: Image.asset(
                            "images/02.png",
                            width: pokeSize,
                            height: pokeSize,
                            alignment: Alignment.bottomRight,
                            color: Color(0xFF303943).withOpacity(0.3),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            snapshot.data[index].data['${langSet.langSet}'],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2.0,
                                wordSpacing: 5.0),
                            textAlign: TextAlign.center,
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
