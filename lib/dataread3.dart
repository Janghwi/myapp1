import 'package:cloud_firestore/cloud_firestore.dart';
import 'getphrases01.dart';
import 'getphrases04.dart';
import 'package:flutter/material.dart';

import 'catread1.dart';
import 'dataread33.dart';
import 'getphrases04.dart';

  class DataRead3 extends StatelessWidget {
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
            backgroundColor: Colors.blue, 
            title: new Text('Phrases'),
            elevation: 4.0, 
            centerTitle: true,
            leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => DataRead33()),
              );
            },
            ),
            ),
          body: GetPhrases01(
            screenTitle: 'phrases list',
            firestoreName: 'testcat',),
            //catno: '2'),

          );
      }
        
    }

  