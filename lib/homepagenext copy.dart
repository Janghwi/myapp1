import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';

import 'models/languageprovider.dart';
import 'models/menucategory.dart';
import 'router/routing_constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

//import 'package:opentrivia/ui/pages/home.dart';

class HomepageNext extends StatelessWidget {
  final String argument;

  HomepageNext({Key key, this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
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
              floating: true,
              pinned: true,
              expandedHeight: 70,
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
      QuerySnapshot snapshot =
          await firestore.collection(argument).orderBy('id').getDocuments();
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
              padding: EdgeInsets.all(2),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: 2.0,
              ),
              itemBuilder: (_, index) {
                return NeumorphicButton(
                    margin: EdgeInsets.only(top: 12),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      // print(menuCategories[index].routeName);
                      // print(menuCategories.length);
                      return Navigator.pushNamed(context, PhraseViewRoute1,
                          arguments: secondMenuCategories[index].routeName);
                      //return Navigator.push(context, menuCategories[index].routeName);
                    },
                    //color: Colors.blue[100 * (index % 9)],
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            // top: 1,
                            // right: 2,
                            // left: 82,
                            // bottom: 8,
                            child: Icon(
                              secondMenuCategories[index].icon,
                              //.fiber_pin,
                              color: Colors.blueGrey,
                              size: 16.0,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "      72 Phrases",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.red,
                                            letterSpacing: 1.0,
                                            wordSpacing: 2.0),
                                        textAlign: TextAlign.center,
                                      ),
                                      Spacer(),
                                      Text(
                                        snapshot.data[index].data['id']
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black45,
                                            letterSpacing: 2.0,
                                            wordSpacing: 5.0),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                                SizedBox(height: 5.0),
                                Align(
                                  child: SizedBox(
                                    width: 185,
                                    height: 26,
                                    child: AutoSizeText(
                                      snapshot.data[index]
                                          .data['${langSet.langSet}'],
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent,
                                          letterSpacing: 1.0,
                                          wordSpacing: 1.0),
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      minFontSize: 10,
                                      maxFontSize: 16,
                                    ),
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
