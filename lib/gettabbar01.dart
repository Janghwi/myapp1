import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'getphrases10tt.dart';
import 'getphrases10j.dart';
import 'getphrases10k.dart';
import 'models/phrasesmodel.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GetTabbar01 extends StatefulWidget {
  final String argument;

  GetTabbar01({Key key, this.argument}) : super(key: key);

  @override
  _GetTabbar01State createState() => _GetTabbar01State();
}

class _GetTabbar01State extends State<GetTabbar01> {
  final List<Phrases> phrases = [
    Phrases(
      eng: "snapshot.data[index].data['eng']",
      kor: "snapshot.data[index].data['kor']",
      korprn: "snapshot.data[index].data['korprn']",
      jap: "snapshot.data[index].data['jap']",
      japprn: "snapshot.data[index].data['japprn']",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    //listPage() {

    return  DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                //title: Text("Tabbar view"),
                elevation: 0,
                bottom: TabBar(
                    unselectedLabelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.redAccent),
                    tabs: [
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.blue, width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("English"),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.blue, width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Korean"),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.blue, width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Japanese"),
                          ),
                        ),
                      ),
                    ]),
              ),
              body: TabBarView(children: [
                GetPhrases10tt(argument: widget.argument),
                GetPhrases10k(argument: widget.argument),
                GetPhrases10j(argument: widget.argument),
              ]),
            ),);
  }

  bool isTab(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.width;
    return shortestSide >= 600;
  }
}
