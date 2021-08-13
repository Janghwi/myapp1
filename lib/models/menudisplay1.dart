import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'menucategory.dart';

class MenuDisplay1 extends StatefulWidget {
  final String language;

  MenuDisplay1({Key key, @required this.language}) : super(key: key);

  @override
  _MenuDisplay1State createState() => _MenuDisplay1State(language);
}

class _MenuDisplay1State extends State<MenuDisplay1> {
  Future _data;

  //var language;

  final String language;
  _MenuDisplay1State(this.language);

  Future getMenus() async {
    var firestore = Firestore.instance;
    QuerySnapshot snapshot =
        await firestore.collection("mainmenu").orderBy('id').getDocuments();
    snapshot.documents.forEach((document) {
      print(this.language);
      // print (document);
      //  print (snapshot.documents);
    });
    return snapshot.documents;
  }

  @override //이 문장이 여러번 DB를 불러오는것을 방지한다
  void initState() {
    super.initState();
    _data = getMenus();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 10),
      decoration: BoxDecoration(
        color: Colors.amber[100],
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
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.8,
              ),
              itemBuilder: (_, index) {
                return FlatButton(
                  onPressed: () {
                    print(mainMenuCategories[index].routeName);
                    print(mainMenuCategories.length);
                    return Navigator.pushNamed(
                        context, mainMenuCategories[index].routeName);
                  },
                  //color: Colors.blue[100 * (index % 9)],
                  color: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.yellowAccent),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              snapshot.data[index].data[widget.language],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
