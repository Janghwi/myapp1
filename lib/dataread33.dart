import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

    class DataRead33 extends StatelessWidget {
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
            title: new Text("Title"),
            elevation: 4.0, 
            centerTitle: true,
            ),
          body: new GetDriversList(),
        );
      }
        
    }

  class GetDriversList extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('wordstest3').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        
      final datas = snapshot.data.documents;
        datas.sort((a, b) {
        return a['a.id'].compareTo(b['a.id']
        );
        
});
        return ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new ListTile(
              leading: new Text(document['a.id'].toString()),
              title: new Text(document['b.eng']),
              subtitle: new Text(document['c.kor']),
              trailing: Icon(Icons.arrow_forward),
              isThreeLine: true,
            );
          }).toList(),
        );
        
      },
    );
  }
}