import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/phrasesmodel.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GetPhrases13 extends StatelessWidget {
  final List<Phrases> phrases = [
    Phrases(
      eng: "snapshot.data[index].data['eng']",
      kor: "snapshot.data[index].data['kor']",
      korprn: "snapshot.data[index].data['korprn']",
      jap: "snapshot.data[index].data['jap']",
      japprn: "snapshot.data[index].data['japprn']",
    ),
  ];

  final String screenTitle;
  final String firestoreName;

  GetPhrases13({
    @required this.screenTitle,
    @required this.firestoreName,
  });

  @override
  Widget build(BuildContext context) {
    void phraseSpeech(String langCode, String phrase) async {
      FlutterTts flutterTts = FlutterTts();

      await flutterTts.setLanguage(langCode);
      await flutterTts.setPitch(1);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(0.8);
      await flutterTts.speak(phrase);
    }

    //listPage() {
    Future _datas;

    Future getMenus() async {
      var firestore = Firestore.instance;
      QuerySnapshot snapshot = await firestore
          .collection(firestoreName)
          .orderBy('id')
          .startAt([1]).endAt([10])
          //.where("id", isGreaterThan: 1488)
          .getDocuments();
      snapshot.documents.forEach((document) {
        // print (document);
        //  print (snapshot.documents);
      });
      return snapshot.documents;
    }

    _datas = getMenus();

    // return new StreamBuilder<QuerySnapshot>(
    //   stream: Firestore.instance.collection(firestoreName).snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (!snapshot.hasData) return new Text('Loading...');

    //     final datas = snapshot.data.documents;
    //     int index = datas.length;
    //     print(index);
    //     datas.sort((a, b) {
    //       return a['id'].compareTo(b['id']);
    //     });
    return Material(
        color: Color(0xffA9A9A9),
        child: FutureBuilder(
          future: _datas,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return new Center(
                child: Text("Loading"),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  padding: EdgeInsets.all(8),
                  itemBuilder: (_, index) {
                    return ExpansionCard(
                      backgroundColor: Color(0xffD3D3D3),
                      title: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              snapshot.data[index].data['eng'],
                              style: GoogleFonts.lato(
                                textStyle: Theme.of(context).textTheme.display1,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(snapshot.data[index].data['id'].toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                        fontSize: 14,
                                        color: Colors.black26)),
                                Text('/',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                        fontSize: 14,
                                        color: Colors.black26)),
                                Text(snapshot.data.length.toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black26)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(5),
                          // decoration: BoxDecoration(
                          //     shape: BoxShape.rectangle,
                          //     //border: Border.all(color: Colors.brown),
                          //     borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(10.0),
                          //         topRight: Radius.circular(10.0),
                          //         bottomLeft: Radius.circular(10.0),
                          //         bottomRight: Radius.circular(10.0))
                          //     // image: DecorationImage(
                          //     //   fit: BoxFit.fill,
                          //     //   image: NetworkImage("https://pbs.twimg.com/profile_images/610120554738266112/I4pl2ygE_400x400.jpg")
                          //     // )
                          //     ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            //컬럼 시작
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //첫번째 row
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('   👆Press sentence 🗣️',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none,
                                            fontSize: 12,
                                            color: Colors.blueGrey[200])),
                                    Divider(
                                      endIndent: 25,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        GestureDetector(
                                            //텍스트 전달
                                            onTap: () {
                                              var string = "Dart is fun";
                                              string = snapshot
                                                      .data[index].data['eng'] +
                                                  '                              \n' +
                                                  snapshot
                                                      .data[index].data['kor'] +
                                                  '\n' +
                                                  snapshot
                                                      .data[index].data['jap'] +
                                                  '\n' +
                                                  '😁From ENKORNESE😉';
                                              Share.share(string);
                                            },
                                            child: Icon(MdiIcons.shareCircle,
                                                color: Colors.blue)),
                                      ],
                                    ),
                                    Divider(
                                      endIndent: 10,
                                    ),
                                    GestureDetector(
                                        onTap: () {},
                                        child: Icon(Icons.favorite_border,
                                            color: Colors.blue)),
                                  ],
                                ),

                                //영어출력
                                // Wrap(
                                //   alignment: WrapAlignment.start,
                                //   children: <Widget>[
                                //     Padding(
                                //       padding: const EdgeInsets.all(4.0),
                                //       child: CircleAvatar(
                                //         child: Image.asset('images/usa.png'),
                                //         radius: 5.0,
                                //       ),
                                //     ),
                                //     GestureDetector(
                                //       onTap: () =>
                                //           phraseSpeech("en-US", snapshot.data[index].data['eng']),

                                //     ),
                                //   ],
                                // ),
                                // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, decoration: TextDecoration.none,
                                // color:Colors.black87,fontFamily: "Montserrat",)),),
                                Divider(),
                                //한국어출력
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
                                      onTap: () => phraseSpeech("ko-KR",
                                          snapshot.data[index].data['kor']),
                                      child: SubstringHighlight(
                                        text: snapshot.data[index].data['kor'],
                                        term: "날씨",
                                        textStyle: GoogleFonts.nanumGothic(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .display1,
                                          fontSize: 18,
                                          color: Colors.black87,
                                          fontStyle: FontStyle.normal,
                                          //background: Paint()..color = Colors.blue,
                                        ),
                                        textStyleHighlight: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .display1,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //Divider(),
                                //한국어발음
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: GestureDetector(
                                    onTap: () => phraseSpeech("ko-KR",
                                        snapshot.data[index].data['kor']),
                                    child: SubstringHighlight(
                                      text: snapshot.data[index].data['korprn'],
                                      term: "nalssi",
                                      textStyle: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .display1,
                                        fontSize: 15,
                                        color: Colors.black26,
                                        fontStyle: FontStyle.normal,
                                        //background: Paint()..color = Colors.white,
                                      ),
                                      textStyleHighlight: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .display1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(),

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
                                      onTap: () => phraseSpeech("ja-JP",
                                          snapshot.data[index].data['jap']),
                                      child: SubstringHighlight(
                                        text: snapshot.data[index].data['jap'],
                                        term: "今日",
                                        textStyle: GoogleFonts.mPLUSRounded1c(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .display1,
                                          fontSize: 18,
                                          color: Colors.black54,
                                          fontStyle: FontStyle.normal,
                                          //background: Paint()..color = Colors.blue,
                                        ),
                                        textStyleHighlight:
                                            GoogleFonts.mPLUSRounded1c(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .display1,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //일본어 발음
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: GestureDetector(
                                    onTap: () => phraseSpeech("ja-JP",
                                        snapshot.data[index].data['jap']),
                                    child: SubstringHighlight(
                                      text: snapshot.data[index].data['japprn'],
                                      term: "Kyō wa",
                                      textStyle: GoogleFonts.mPLUSRounded1c(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .display1,
                                        fontSize: 15,
                                        color: Colors.black26,
                                        fontStyle: FontStyle.normal,
                                        //background: Paint()..color = Colors.white,
                                      ),
                                      textStyleHighlight:
                                          GoogleFonts.mPLUSRounded1c(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .display1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }
          },
        ));
  }
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
