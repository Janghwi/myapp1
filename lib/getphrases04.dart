
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

  class LoadDataFromFirestore extends StatefulWidget {
      @override
      _LoadDataFromFirestoreState createState() => _LoadDataFromFirestoreState();
    }
  
    class _LoadDataFromFirestoreState extends State<LoadDataFromFirestore> {
  Stream dataList;

  @override
  @override
Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('testcat3')
            .where('h.cat2', isEqualTo: 'b')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print(snapshot.connectionState);
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data.documents.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (_, index) {
                    return Text(snapshot.data.documents[index].data["b.eng"]);
                  })
              : Text('No Data');
        });
}
    }