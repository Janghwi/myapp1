import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'package:substring_highlight/substring_highlight.dart';

import 'models/onephraseprovider.dart';
import 'models/phrasesmodel.dart';

//import 'package:opentrivia/ui/pages/home.dart';

class SecondMenu3 extends StatelessWidget {
  final String firestoreName;

  SecondMenu3({@required this.firestoreName});

  List<Phrases> phrases = [
    Phrases(
      eng: "document['eng']",
      kor: "document['kor']",
      korprn: "document['korprn']",
      jap: "document['jap']",
      japprn: "document['japprn']",
    ),
  ];
  void phraseSpeech(String langCode, String phrase) async {
    FlutterTts flutterTts = FlutterTts();

    await flutterTts.setLanguage(langCode);
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setVolume(0.8);
    await flutterTts.speak(phrase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Patern categories'),
            floating: true,
            pinned: true,
            expandedHeight: 50,
            //   flexibleSpace: FlexibleSpaceBar(
            //     background: MyFlexiableAppBar(),
            // ),
          ),
          SliverFillRemaining(
              fillOverscroll: true,
              hasScrollBody: true,
              child: listPage(context))
        ],
      ),
    );
  }

  Widget listPage(BuildContext context) {
    Future _datas;

    Future getMenus() async {
      var firestore = Firestore.instance;
      QuerySnapshot snapshot = await firestore
          .collection(firestoreName)
          .where("id", isGreaterThan: 1488).getDocuments();
          //.orderBy('id', descending: false)
          //.startAt([5]).endAt([10]).getDocuments();
      snapshot.documents.forEach((document) {
        // print (document);
        //  print (snapshot.documents);
      });

      return snapshot.documents;
    }

    _datas = getMenus();
    //provider 변수 선언
    var engpLoad = Provider.of<OnePhraseProvider>(context, listen: true);
    var korpLoad = Provider.of<OnePhraseProvider>(context, listen: true);
    var korprnpLoad = Provider.of<OnePhraseProvider>(context, listen: true);
    var jappLoad = Provider.of<OnePhraseProvider>(context, listen: true);
    var japprnpLoad = Provider.of<OnePhraseProvider>(context, listen: true);
    var idLoad = Provider.of<OnePhraseProvider>(context, listen: true);

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      decoration: BoxDecoration(
        color: Colors.amber[100],
      ),
      child: FutureBuilder(
        future: _datas,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()
                //Text("Loading"),
                );
          } else {
            return Consumer<OnePhraseProvider>(
                builder: (context, onePhraseProvider, _) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                padding: EdgeInsets.all(8),
                itemBuilder: (_, index) {
                  return Card(
                    color: Color(0xff5264e4),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (builder) {
                              return Container(
                                color: Colors.amber,
                                child: Center(
                                    child: Column(
                                  children: <Widget>[
                                    Text(snapshot.data[index].data['eng']),
                                    Text(snapshot.data[index].data['kor']),
                                    Text(snapshot.data[index].data['jap']),
                                  ],
                                )),
                              );
                            });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //첫번째 row snapshot.data[index].data['${_langSet.currentlangSet}'],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(snapshot.data[index].data['id'].toString(),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white54)),
                              Text('/',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white54)),
                              Text(snapshot.data.length.toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white54)),
                            ],
                          ),
                          //영어출력 Text(snapshot.data[index].data['eng']
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  child: Image.asset('images/usa.png'),
                                  radius: 5.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (builder) {
                                        return Container(
                                          color: Colors.amber,
                                          child: Center(
                                              child: Column(
                                            children: <Widget>[
                                              Text(snapshot
                                                  .data[index].data['eng']),
                                              Text(snapshot
                                                  .data[index].data['kor']),
                                              Text(snapshot
                                                  .data[index].data['jap']),
                                            ],
                                          )),
                                        );
                                      });
                                },

                                child: SubstringHighlight(
                                  text: snapshot.data[index].data['eng'],
                                  term: "날씨",
                                  textStyle: GoogleFonts.lato(
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textStyleHighlight: GoogleFonts.lato(
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //한국어
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  child: Image.asset('images/korea.png'),
                                  radius: 5.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (builder) {
                                        return Container(
                                          color: Colors.amber,
                                          child: Center(
                                              child: Column(
                                            children: <Widget>[
                                              Text(snapshot
                                                  .data[index].data['eng']),
                                              Text(snapshot
                                                  .data[index].data['kor']),
                                              Text(snapshot
                                                  .data[index].data['jap']),
                                            ],
                                          )),
                                        );
                                      });
                                },
                                child: SubstringHighlight(
                                  text: snapshot.data[index].data['kor'],
                                  term: "날씨",
                                  textStyle: GoogleFonts.nanumGothic(
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textStyleHighlight: GoogleFonts.lato(
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //일본어시작---------------------------------------------------------------- 
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  child: Image.asset('images/japan.png'),
                                  radius: 5.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (builder) {
                                        return Container(
                                          color: Theme.of(context).canvasColor,
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                        '    👆 Press sentence 🗣️',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                            color: Colors
                                                                .blueGrey)),
                                                    Divider(
                                                      endIndent: 26,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          var string =
                                                              "Dart is fun";
                                                          string = snapshot
                                                                  .data[index]
                                                                  .data['eng'] +
                                                              '                              \n' +
                                                              snapshot
                                                                  .data[index]
                                                                  .data['kor'] +
                                                              '\n' +
                                                              snapshot
                                                                  .data[index]
                                                                  .data['jap'] +
                                                              '\n' +
                                                              '😁From ENKORNESE😉';
                                                          Share.share(string);
                                                        },
                                                        child: Icon(Icons.share,
                                                            color:
                                                                Colors.grey)),
                                                    Divider(
                                                      endIndent: 12,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {},
                                                        child: Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color:
                                                                Colors.grey)),
                                                  ],
                                                ),
                                                Divider(
                                                  height: 10.0,
                                                ),
                                                GestureDetector(
                                                  onTap: () => phraseSpeech(
                                                      "en-US",
                                                      snapshot.data[index]
                                                          .data['eng']),
                                                  child: Text(
                                                      snapshot.data[index]
                                                          .data['eng'],
                                                      style: GoogleFonts.lato(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .display1,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      )),
                                                ),
                                                Divider(
                                                  height: 15.0,
                                                ),
                                                Text(
                                                  snapshot
                                                      .data[index].data['kor'],
                                                  style: GoogleFonts
                                                      .nanumGothicCoding(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .display1,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                                Divider(
                                                  height: 4.0,
                                                ),
                                                Text(
                                                  snapshot.data[index]
                                                      .data['korprn'],
                                                  style: GoogleFonts
                                                      .nanumGothicCoding(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .display1,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                                Divider(
                                                  height: 8.0,
                                                ),
                                                Text(
                                                  snapshot
                                                      .data[index].data['jap'],
                                                  style: GoogleFonts
                                                      .mPLUSRounded1c(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .display1,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data[index]
                                                      .data['japprn'],
                                                  style: GoogleFonts
                                                      .nanumGothicCoding(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .display1,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black45,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                                Divider(
                                                  height: 8.0,
                                                ),
                                              ],
                                            ),
                                          )),
                                        );
                                      });
                                },
                                child: SubstringHighlight(
                                  text: snapshot.data[index].data['jap'],
                                  term: "날씨",
                                  textStyle: GoogleFonts.mPLUSRounded1c(
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textStyleHighlight: GoogleFonts.lato(
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            });
          }
        },
      ),
    );
  }

  void share(BuildContext context, Phrases phrases) {
    final RenderBox box = context.findRenderObject();
    final String text =
        "${phrases.eng} - ${phrases.kor} -${phrases.korprn} -${phrases.jap}-${phrases.japprn}";
    Share.share(
      text,
      subject: phrases.eng,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }
}

// void _openModalBottomSheet(BuildContext context) {
//   // final engpLoad = Provider.of<OnePhraseProvider>(context, listen: true);
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         // ModalBottomSheet を押した時のイベントを捕まえるために
//         // GestureDetector でラップする
//         return GestureDetector(
//             onTap: () {
//               // ModalBottomSheet を押した時には何もしないようにする
//             },
//             child: new Container(
//                 // ModalBottomSheet のどこを押してもラップした GestureDetector が
//                 // 検知できるように、ラップした Container には色をつけておく
//                 color: Colors.white,
//                 padding: const EdgeInsets.all(16.0),
//                 child: new Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //Text(onePhraseProvider.),
//                     Text(
//                         '2. Quickly ship features with a focus  flexible designs.'),
//                     // Container 内の残りの空き領域をいっぱいに使いたいウィジェットは
//                     // Expanded でラップした FittedBox 内に配置する
//                     new Expanded(
//                       child: new FittedBox(
//                         fit: BoxFit.contain,
//                         // otherwise the logo will be tiny
//                         child: const FlutterLogo(),
//                       ),
//                     ),
//                     new Text(
//                         '3. Flutter’s widgets incorporate all critical platform differences such as scrolling, navigation, icons and fonts to provide full native performance on both iOS and Android. '),
//                   ],
//                 )));
//       });
