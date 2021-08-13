import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dataread33.dart';
import 'models/colorpalette.dart';



  class GetPhrases02 extends StatelessWidget {

    
    final String screenTitle;
    final String firestoreName ;
   
GetPhrases02({
    @required this.screenTitle,
    @required this.firestoreName,
  });


  @override
   Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(firestoreName).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        
      final datas = snapshot.data.documents;
      int index = datas.length;
      print(index);
        datas.sort((a, b) {
        return a['id'].compareTo(b['id']
        );
        
        });
        return new ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 2.0, 3.0),
              child: GestureDetector(
                onTap: () {
                  //print(document['b.eng']);
                  switch (document['id'].toString()) {
                    case '1' :  {
                      Navigator.push(
                        context, new MaterialPageRoute(builder: (context) => DataRead33()));
                        }
                        break; 
                    case '2' :  {
                      Navigator.push(
                        context, new MaterialPageRoute(builder: (context) => DataRead33()));
                        }
                        break; 
                    }
                },
                  child: Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Palette.a, Palette.b,],
                      ),
                      //color: Colors.deepPurpleAccent[150],
                      shape: BoxShape.rectangle,
                      //border: Border.all(color: Colors.brown),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)
                      )
                      // image: DecorationImage(
                      //   fit: BoxFit.fill,
                      //   image: NetworkImage("https://pbs.twimg.com/profile_images/610120554738266112/I4pl2ygE_400x400.jpg")
                      // )
                    ),
                    child: new Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //Text(document['a.id'].toString(),
                        //textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14, color:Colors.black87)),
                        Text(document['eng'],
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color:Colors.white)),
                        Text(document['kor'],
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color:Colors.yellow)),
                        Text(document['korprn'],
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color:Colors.grey)),
                        Text(document['jap'],
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color:Colors.purple[300])),
                        Text(document['japprn'],
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color:Colors.grey)),
                      ],
                      
                    ),
                  ),)
            );
          }).toList(),
        );
      },
    );
  }
}