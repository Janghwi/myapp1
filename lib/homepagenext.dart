import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';

import 'menuview/basicmenu.dart';
import 'models/languageprovider.dart';
import 'models/menucategory.dart';
import 'router/routing_constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'secondmenu3.dart';

//import 'package:opentrivia/ui/pages/home.dart';

class HomepageNext extends StatelessWidget {
  final String firestoreName;

  HomepageNext({Key key, this.firestoreName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFAF6F6),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(iconSize: 20, items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              backgroundColor: Colors.black38),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              title: Text("Favorites"),
              backgroundColor: Colors.black38),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("Search"),
              backgroundColor: Colors.black38),
          BottomNavigationBarItem(
              icon: Icon(Icons.transform),
              title: Text("Translate"),
              backgroundColor: Colors.black38),
        ]),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              //leading: IconButton(icon: Icon(FontAwesomeIcons.bars), onPressed: null),
              title: Text('Categories'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              centerTitle: true,
              floating: true,
              pinned: true,
              expandedHeight: 60,
              actions: <Widget>[
                IconButton(icon: Icon(Icons.dashboard), onPressed: () {}),
              ],
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
      ),
      // routes: {
      //   "view01": (context) => GetPhrases13(screenTitle: 'abc', firestoreName: 'weather'),
      // 'cat2_view': (context) =>
      //     GetPhrases12(screenTitle: 'abc', firestoreName: 'weather'),
      //},
    );
  }

  Widget listPage(BuildContext context) {
    Future _data;

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

    _data = getMenus();
    //print('pressed');

    final langSet = Provider.of<LanguageLoad>(context, listen: true);

    return NeumorphicButton(
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
              //padding: EdgeInsets.all(2),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: 1.6,
              ),
              itemBuilder: (_, index) {
                return NeumorphicButton(
                    margin: EdgeInsets.only(top: 8),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      color: Colors.black54,
                      //color: Colors.amber[50 * (index % 3)],
                      boxShape: NeumorphicBoxShape.rect(),
                      //BorderRadius.circular(28)),
                    ),
                    onPressed: () {
                      if (secondMenuCategories[index].routeName == "youtuber") {
                        print('second if menu processed');
                        return Get.to(BasicMenu(
                            firestoreName:
                                secondMenuCategories[index].routeName));
                      } else {
                        print('second else menu processed');
                        return Navigator.pushNamed(
                          context,
                          SecondMenuViewRoute,
                        );
                        //arguments: secondMenuCategories[index].routeName);
                      }
                    },
                    //color: Colors.blue[100 * (index % 9)],
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: <Widget>[
                          // Icon(
                          //   secondMenuCategories[index].icon,
                          //   //.fiber_pin,
                          //   color: Colors.blueGrey,
                          //   size: 16.0,
                          // ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      // Text(
                                      //   "      72 Phrases",
                                      //   style: TextStyle(
                                      //       fontSize: 10,
                                      //       fontWeight: FontWeight.w400,
                                      //       color: Colors.red,
                                      //       letterSpacing: 1.0,
                                      //       wordSpacing: 2.0),
                                      //   textAlign: TextAlign.center,
                                      // ),
                                      Spacer(),
                                      Text(
                                        snapshot.data[index].data['id']
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                            letterSpacing: 2.0,
                                            wordSpacing: 5.0),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                                //SizedBox(height: 5.0),
                                Align(
                                  child: AutoSizeText(
                                    snapshot
                                        .data[index].data['${langSet.langSet}'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1.0,
                                        wordSpacing: 1.0),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    minFontSize: 10,
                                    maxFontSize: 16,
                                  ),
                                ),
                              ],
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
}
