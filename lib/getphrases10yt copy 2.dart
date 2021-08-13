import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';

import 'package:paginate_firestore/paginate_firestore.dart';
import 'models/phrasesmodel.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

// ignore: must_be_immutable
class GetPhrases10yt extends StatefulWidget {
  String argument;
  String p1, p2, p3, p4, p5;
  GetPhrases10yt(this.argument, this.p1, this.p2,this.p3,this.p4,this.p5,) ;

  
  @override
  _GetPhrases10ytState createState() => _GetPhrases10ytState(this.argument, this.p1, this.p2,this.p3,this.p4,this.p5);
}

  

  
class _GetPhrases10ytState extends State<GetPhrases10yt> {
  String argument;
  String p1, p2, p3, p4, p5;
  _GetPhrases10ytState(this.argument, this.p1, this.p2,this.p3,this.p4,this.p5, ) ;
  


//share에서 사용한다 
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
  void initState() {
    super.initState();
   // _getPost();
  }


  @override
  Widget build(BuildContext context) {
    void phraseSpeech(String langCode, String phrase) async {
      FlutterTts flutterTts = FlutterTts();

      await flutterTts.setLanguage(langCode);
      await flutterTts.setPitch(1);
      await flutterTts.setSpeechRate(0.8);
      await flutterTts.setVolume(0.8);
      await flutterTts.speak(phrase);
    }

    //listPage() {

    return PaginateFirestore(
      itemBuilder: (context, documentSnapshot) => ExpansionTileCard(
        baseColor: Colors.white,
        // leading: Text(
        //   documentSnapshot.data['id'].toString(),
        //   textAlign: TextAlign.right,
        //   style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       decoration: TextDecoration.none,
        //       fontSize: 11,
        //       color: Colors.black26),
        // ),
        //title: Text(documentSnapshot.data['eng']),
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    documentSnapshot.data['id'].toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        fontSize: 10,
                        color: Colors.black26),
                  ),
                  Text('                      Press sentence 🔊',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          fontSize: 10,
                          color: Colors.grey[300])),
                ],
              ),
              //여기서 부터 문장이 시작한다.(영어)
              //
              //
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: GestureDetector(
                   onTap: () =>
                            phraseSpeech(p1, documentSnapshot.data[p1]),
                            //phraseSpeech('en-US', documentSnapshot.data['eng']),
                  child: SubstringHighlight(
                    text: documentSnapshot.data[p2],
                    //text: documentSnapshot.data['eng'],
                    term: documentSnapshot.data[p4],
                    //term: documentSnapshot.data['engh'],
                    textStyle: TextStyle(
                      fontFamily: "NotoSansCJKkr",
                      fontSize: 12,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      //background: Paint()..color = Colors.white,
                    ),
                    textStyleHighlight: TextStyle(
                      fontFamily: "NotoSansCJKkr",
                      fontSize: 12,
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
                        onTap: () =>
                            phraseSpeech("ko-KR", documentSnapshot.data['kor']),
                            //phraseSpeech("ko-KR", documentSnapshot.data['kor']),
                            //phraseSpeech("ko-KR", documentSnapshot.data['kor']),
                        child: SubstringHighlight(
                          text: documentSnapshot.data['kor'],
                          term: documentSnapshot.data['korh'],
                          textStyle: TextStyle(
                            fontFamily: "NotoSansCJKkr",
                            fontSize: 12,
                            color: Colors.blue[800],
                            fontStyle: FontStyle.normal,
                            //background: Paint()..color = Colors.blue,
                          ),
                          textStyleHighlight: TextStyle(
                            fontFamily: "NotoSansCJKkr",
                            fontSize: 12,
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
                      onTap: () =>
                          phraseSpeech("ko-KR", documentSnapshot.data['kor']),
                      child: SubstringHighlight(
                        text: documentSnapshot.data['korprn'],
                        term: documentSnapshot.data['korprnh'],
                        textStyle: TextStyle(
                          fontFamily: "NotoSansCJKkr",
                          fontSize: 12,
                          color: Colors.black45,
                          fontStyle: FontStyle.normal,
                          //background: Paint()..color = Colors.white,
                        ),
                        textStyleHighlight: TextStyle(
                          fontFamily: "NotoSansCJKkr",
                          fontSize: 12,
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
                        onTap: () =>
                            phraseSpeech("ja-JP", documentSnapshot.data['jap']),
                        child: SubstringHighlight(
                          text: documentSnapshot.data['jap'],
                          term: documentSnapshot.data['japh'],
                          textStyle: TextStyle(
                            fontFamily: "NotoSansCJKkr",
                            fontSize: 12,
                            color: Colors.blue[700],
                            fontStyle: FontStyle.normal,
                            //background: Paint()..color = Colors.blue,
                          ),
                          textStyleHighlight: TextStyle(
                            fontFamily: "NotoSansCJKkr",
                            fontSize: 12,
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
                      onTap: () =>
                          phraseSpeech("ja-JP", documentSnapshot.data['jap']),
                      child: SubstringHighlight(
                        text: documentSnapshot.data['japprn'],
                        term: documentSnapshot.data['japprnh'],
                        textStyle: TextStyle(
                          fontFamily: "NotoSansCJKkr",
                          fontSize: 12,
                          color: Colors.black54,
                          fontStyle: FontStyle.normal,
                          //background: Paint()..color = Colors.white,
                        ),
                        textStyleHighlight: TextStyle(
                          fontFamily: "NotoSansCJKkr",
                          fontSize: 12,
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
            buttonHeight: 32.0,
            buttonMinWidth: 60.0,
            children: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                onPressed: () {}, //share끝나는 부분
                child: Column(
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Save'),
                  ],
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                onPressed: () {
                  slideDialog.showSlideDialog(
                    context: context,
                    child: Text(
                        "How is .the weather ...ow is .the weathow is .the weathow is .the weathow is .the weathow is .the weath \n 어떻습니까? \ㅜ 등 패턴을 넣어준다 "),
                    // barrierColor: Colors.white.withOpacity(0.7),
                    // pillColor: Colors.red,
                    // backgroundColor: Colors.yellow,
                  );
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.open_in_browser),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Pattern'),
                  ],
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                onPressed: () {
                  var string = "Dart is fun";
                  string = documentSnapshot.data['eng'] +
                      '                              \n' +
                      documentSnapshot.data['kor'] +
                      '\n' +
                      documentSnapshot.data['jap'] +
                      '\n' +
                      '😁From ENKORNESE😉';
                  Share.share(string);
                }, //share끝나는 부분
                child: Column(
                  children: <Widget>[
                    Icon(Icons.share),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Share'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      // orderBy is compulsary to enable pagination
      query: Firestore.instance.collection(widget.argument).orderBy('id'),
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
