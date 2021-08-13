import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'models/languageprovider.dart';
import 'models/menucategory.dart';

//import 'package:opentrivia/ui/pages/home.dart';

class SecondMenu1 extends StatelessWidget {
  final String firestoreName;

  SecondMenu1({@required this.firestoreName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
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
      // 'cat3_view': (context) =>
      //     GetPhrases01(screenTitle: 'abc', firestoreName: 'weather'),
      // 'cat4_view': (context) =>
      //     GetPhrases11(screenTitle: 'abc', firestoreName: 'weather'),
      // 'cat5_view': (context) => SecondMenu1(firestoreName: 'menu11'),
      // 'cat6_view': (context) =>
      //     GetPhrases13(screenTitle: 'abc', firestoreName: 'weather'),
      // 'cat7_view': (context) => SecondMenu2(firestoreName: 'could.you'),
      // 'cat8_view': (context) => SecondMenu3(firestoreName: 'temphangul'),
      // 'grid_view': (context) => GridViewDemo(),
      // 'custom_icons': (context) => CustomIconsDemo(),
      // 'sliver_widgets': (context) => SliverWidgetsDemo()
      //},
    );
  }

  Widget listPage(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final pokeSize = screenSize.width * 0.65;
    final pokeTop = -(screenSize.width * 0.19);
    final pokeRight = -(screenSize.width * 0.48);

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
                childAspectRatio: 1.9,
              ),
              itemBuilder: (_, index) {
                return MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      // print(menuCategories[index].routeName);
                      // print(menuCategories.length);
                      return Navigator.pushNamed(
                          context, secondMenuCategories[index].routeName);
                      //return Navigator.push(context, menuCategories[index].routeName);
                    },
                    //color: Colors.blue[100 * (index % 9)],
                    color: Color(0xFF4FC1A6),
                    splashColor: Colors.white10,
                    highlightColor: Colors.white10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: <Widget>[
                          Icon(
                            mainMenuCategories[index].icon,
                            //.fiber_pin,
                            color: Colors.blueGrey,
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
}
