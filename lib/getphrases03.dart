import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dataread33.dart';



  class GetPhrases03 extends StatelessWidget {
    final String screenTitle;
    final String firestoreName ;
    final String catno;
   
GetPhrases03({
    @required this.screenTitle,
    @required this.firestoreName,
    this.catno,
  });
    
  @override
   Widget build(BuildContext context) {
     CollectionReference collectionReference =
    Firestore.instance.collection(firestoreName);
    print(firestoreName);
    return new StreamBuilder<QuerySnapshot>(
      stream: collectionReference.where
        ("h.cat2", isEqualTo:catno).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        
      final datas = snapshot.data.documents;
      int index = datas.length;
      print(index);
        datas.sort((a, b) {
        return a['a.id'].compareTo(b['a.id']
        );
        
        });
        return new ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 2.0, 3.0),
              child: GestureDetector(
                onTap: () {
                  //print(document['b.eng']);
                  switch (document['a.id'].toString()) {
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
                        colors: [Colors.white, Colors.yellow[300]],
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
                        Text(document['b.eng'],
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color:Colors.black87)),
                        Text(document['c.kor'],
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color:Colors.blue[500])),
                        Text(document['d.korprn'],
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color:Colors.black26)),
                        Text(document['e.jap'],
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color:Colors.purple[300])),
                        Text(document['f.japprn'],
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color:Colors.black26)),
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