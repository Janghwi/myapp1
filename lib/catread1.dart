import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dataread33.dart';
import 'getphrases01.dart';
import 'getphrases04.dart';

class Palette {
  // background gradient
  static Color blueSky = Color(0xFF068FFA);
  static Color greenLand = Color(0xFF89ED91);

  // card gradient
  static Color blueSkyLight = Color(0x40068FFA);
  static Color greenLandLight = Color(0x4089ED91);

  static Color blueSkyLighter = Color(0x10068FFA);
}
  class CatRead1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });

    super.initState();
  }
    


      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(  
            backgroundColor: Palette.blueSky, 
            title: new Text("Title"),
            elevation: 4.0, 
            centerTitle: true,
            ),
          body: GetPhrases01(screenTitle: 'phrases list',firestoreName: 'basiccat')
          // GetPhrases02(
          //   screenTitle: 'phrases list',
          //   firestoreName: 'basiccat'),
        );
      }
        
    }

  