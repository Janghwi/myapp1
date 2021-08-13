import 'dart:math';

import 'package:enkornese/homepagenext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/menucategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';

import 'models/languageprovider.dart';
import 'models/myflexibleappbar.dart';
import 'models/myappbar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'youtubemenu.dart';
import 'tedmenu.dart';
import 'package:carousel_slider/carousel_slider.dart';

//import 'package:opentrivia/ui/pages/home.dart';
final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class HomePage extends StatefulWidget {
  final String argument;
  const HomePage({Key key, this.argument}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
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
      home: CustomScrollView(
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
              child: Column(
                children: <Widget>[
                  Align(child: buildSlideView()),
                  Expanded(child: listPage(context))
                ],
              ))
        ],
      ),
    );
  }
}

Widget buildSlideView() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    color: Colors.white,
    alignment: Alignment.topCenter,
    child: CarouselSlider(
      options: CarouselOptions(
        height: 100.0,
        aspectRatio: 16 / 9,
        viewportFraction: 0.7,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInExpo,
        enlargeCenterPage: true,
        //onPageChanged: callbackFunction,
        scrollDirection: Axis.horizontal,
      ),
      items: imgList
          .map((item) => Container(
                child: Center(
                    child: Image.network(item, fit: BoxFit.cover, width: 600)),
              ))
          .toList(),
    ),
  );
}

Widget listPage(BuildContext context) {
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
  //int rand;
  // final colors = [
  //   Color(0xFFe5be9e),
  //   Color(0xFFf2ce97),
  //   Color(0xFFf8d196),
  //   Color(0xFFffe2aa),
  //   Color(0xFFf6dca2),
  //   Color(0xFFffe2aa),
  //   // Color(0xFFB892FF),
  // ];

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
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.length,
            padding: EdgeInsets.all(6),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              childAspectRatio: 2.44,
            ),
            itemBuilder: (_, index) {
              //rand = new Random().nextInt(colors.length);
              return NeumorphicButton(
                  margin: EdgeInsets.only(top: 12),
                  style: NeumorphicStyle(
                    //   color: colors[rand].withOpacity(1.0),
                    color: Colors.amber[100],
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    if (mainMenuCategories[index].routeName == "youtuber") {
                      //print('youtuber passed');
                      return Get.to(YoutubeMenu());
                    } else if (mainMenuCategories[index].routeName == "teder") {
                      return Get.to(TedMenu());
                    } else if (mainMenuCategories[index].routeName ==
                        "youtuber") {
                      return Get.to(YoutubeMenu());
                    } else
                      return Get.to(HomepageNext(
                          firestoreName: mainMenuCategories[index].routeName));
                    //  return Navigator.pushNamed(context, MenuViewRoute,
                    // arguments: mainMenuCategories[index].routeName);
                    //return Navigator.push(context, menuCategories[index].routeName);
                  },
                  //color: Colors.blue[100 * (index % 9)],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Row(
                      children: <Widget>[
                        Icon(mainMenuCategories[index].icon,
                            //.fiber_pin,
                            color: Colors.red,
                            size: 20.0),
                        // CircleAvatar(child:
                        // Image.asset(
                        //   "images/02.png",
                        //   width: pokeSize,
                        //   height: pokeSize,
                        //   alignment: Alignment.bottomRight,
                        //   color: Color(0xFF303943).withOpacity(0.6),
                        // ),
                        // Padding(padding: EdgeInsets.fromLTRB(0, 15, 10, 0),),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 85,
                              height: 80,
                              child: AutoSizeText(
                                snapshot.data[index].data['${langSet.langSet}'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                ),
                                textAlign: TextAlign.center,
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
