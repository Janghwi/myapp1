import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetPhrases11ted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get the course document using a stream
    Stream<QuerySnapshot> phrasesDocStream =
        Firestore.instance.collection('ytbook001').snapshots();

    return StreamBuilder(
      stream: phrasesDocStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data.documents.length > 0) {
          // get course document
          var phrasesDocument = snapshot.data.documents[0];
          // build list using names from sections
          return ListView.builder(
            itemCount: phrasesDocument.data.length,
            itemBuilder: (_, int index) {
              return itemView(phrasesDocument[(index + 1).toString()],
                  (index + 1).toString());
            },
          );
        } else {
          return Container(
            child: Center(
              child: Text("No data Found"),
            ),
          );
        }
      },
    );
  }

  Widget itemView(var item, var itemNumber) {
    return Column(
      children: <Widget>[
        Text(item['id'].toString()),
        Text(item['title']),
        Text(item['c_title']),
        Text(item['v_id']),
        Text(item['pubdate'].toString()),
        Divider(color: Colors.black)
      ],
    );
  }
}
