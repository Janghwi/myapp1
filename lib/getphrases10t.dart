import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/phrasesmodel.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class GetPhrases10t extends StatelessWidget {
  final List<Phrases> phrases = [
    Phrases(
      eng: "snapshot.data[index].data['eng']",
      kor: "snapshot.data[index].data['kor']",
      korprn: "snapshot.data[index].data['korprn']",
      jap: "snapshot.data[index].data['jap']",
      japprn: "snapshot.data[index].data['japprn']",
    ),
  ];
  final String argument;

  GetPhrases10t({Key key, this.argument}) : super(key: key);

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
    Future datas;

    Future getMenus() async {
      var firestore = Firestore.instance;
      QuerySnapshot snapshot = await firestore
          .collection(argument)
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

    datas = getMenus();

    return Material(
      color: Colors.grey,
      elevation: 4.0,
      //borderRadius: BorderRadius.circular(24.0),
      shadowColor: Colors.white38,
      child: FutureBuilder(
        future: datas,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return new SizedBox(
              width: double.maxFinite,
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                padding: EdgeInsets.all(8),
                itemBuilder: (_, index) {
                  return ExpansionTileCard(
                    leading: CircleAvatar(
                        radius: 12.0,
                        backgroundColor: Colors.blueGrey[200],
                        child: Text(
                          snapshot.data[index].data['id'].toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              fontSize: 11,
                              color: Colors.black26),
                        )),
                    //borderRadius: 15.0,
                    //leading: Text("text"),
                    //margin: const EdgeInsets.only(top: 10),
                    //backgroundColor: Colors.purple[100],
                    title: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Text(snapshot.data[index].data['id'].toString(),
                              //     textAlign: TextAlign.right,
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         decoration: TextDecoration.none,
                              //         fontSize: 12,
                              //         color: Colors.black26)),
                              // Text('/',
                              //     textAlign: TextAlign.right,
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         decoration: TextDecoration.none,
                              //         fontSize: 12,
                              //         color: Colors.black26)),
                              // Text(snapshot.data.length.toString(),
                              //     textAlign: TextAlign.right,
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 12,
                              //         color: Colors.black26)),
                              Text('                 Press sentence 🗣️',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                      fontSize: 12,
                                      color: Colors.grey[300])),
                            ],
                          ),
                          //여기서 부터 문장이 시작한다.(영어)
                          //
                          //
                          Text(
                            snapshot.data[index].data['eng'],
                            style: TextStyle(
                              fontFamily: "NotoSansCJKkr",
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 7),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          //컬럼 시작
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //  Divider(),
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
                                      textStyle: TextStyle(
                                        fontFamily: "NotoSansCJKkr",
                                        fontSize: 18,
                                        color: Colors.blue[800],
                                        fontStyle: FontStyle.normal,
                                        //background: Paint()..color = Colors.blue,
                                      ),
                                      textStyleHighlight: TextStyle(
                                        fontFamily: "NotoSansCJKkr",
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
                                    textStyle: TextStyle(
                                      fontFamily: "NotoSansCJKkr",
                                      fontSize: 16,
                                      color: Colors.black45,
                                      fontStyle: FontStyle.normal,
                                      //background: Paint()..color = Colors.white,
                                    ),
                                    textStyleHighlight: TextStyle(
                                      fontFamily: "NotoSansCJKkr",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(),
                              //일본어
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                      child: Image.asset('images/japan.png'),
                                      radius: 6.0,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => phraseSpeech("ja-JP",
                                        snapshot.data[index].data['jap']),
                                    child: SubstringHighlight(
                                      text: snapshot.data[index].data['jap'],
                                      term: "今日",
                                      textStyle: TextStyle(
                                        fontFamily: "NotoSansCJKkr",
                                        fontSize: 18,
                                        color: Colors.blue[700],
                                        fontStyle: FontStyle.normal,
                                        //background: Paint()..color = Colors.blue,
                                      ),
                                      textStyleHighlight: TextStyle(
                                        fontFamily: "NotoSansCJKkr",
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
                                    textStyle: TextStyle(
                                      fontFamily: "NotoSansCJKkr",
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontStyle: FontStyle.normal,
                                      //background: Paint()..color = Colors.white,
                                    ),
                                    textStyleHighlight: TextStyle(
                                      fontFamily: "NotoSansCJKkr",
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
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
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        buttonHeight: 52.0,
                        buttonMinWidth: 90.0,
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                            onPressed: () {}, //share끝나는 부분
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.star, color: Colors.grey),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text('Save'),
                              ],
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.open_in_browser),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text('Open'),
                              ],
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                            onPressed: () {
                              var string = "Dart is fun";
                              string = snapshot.data[index].data['eng'] +
                                  '                              \n' +
                                  snapshot.data[index].data['kor'] +
                                  '\n' +
                                  snapshot.data[index].data['jap'] +
                                  '\n' +
                                  '😁From ENKORNESE😉';
                              Share.share(string);
                            }, //share끝나는 부분
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.share),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text('Share'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                });
          }
        },
      ),
    );
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
