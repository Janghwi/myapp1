import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:getflutter/getflutter.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:share/share.dart';
import 'package:substring_highlight/substring_highlight.dart';
import './models/menucategory.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'getphrases10yt.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'models/phrasesmodel.dart';

class YoutubeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: YoutubePage(title: 'Youtube english'),
    );
  }
}

class YoutubePage extends StatefulWidget {
  YoutubePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _YoutubePageState createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'SlPhMPnQ58k', // id youtube video
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ));

  final List<Phrases> phrases = [
    Phrases(
      eng: "snapshot.data[index].data['eng']",
      kor: "snapshot.data[index].data['kor']",
      korprn: "snapshot.data[index].data['korprn']",
      jap: "snapshot.data[index].data['jap']",
      japprn: "snapshot.data[index].data['japprn']",
    ),
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   // _langOrder();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   void phraseSpeech(String langCode, String phrase) async {
  //     FlutterTts flutterTts = FlutterTts();

  //     await flutterTts.setLanguage(langCode);
  //     await flutterTts.setPitch(1);
  //     await flutterTts.setSpeechRate(0.8);
  //     await flutterTts.setVolume(0.8);
  //     await flutterTts.speak(phrase);
  //   }
  // String _us = 'en-US';
  // String _kr = 'ko-KR';
  // String _jp = 'ja-JP';
  String _p1 = 'eng';
  String _p1h = 'engh';
  String _p1prn = null;
  //String _p1prnh = null;
  String _p2 = 'kor';
  String _p2h = 'korh';
  String _p2prn = 'korprn';
  String _p2prnh = 'korprnh';
  String _p3 = 'jap';
  String _p3h = 'japh';
  String _p3prn = 'japprn';
  String _p3prnh = 'japprnh';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.blueAccent,
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Row(
                      children: <Widget>[
                        GFIconButton(
                          icon: new Image.asset('images/korea.png'),
                          onPressed: () {
                            _korFirst();
                          },
                        ),
                        SizedBox(width: 5),
                        GFIconButton(
                          icon: new Image.asset('images/japan.png'),
                          onPressed: () {
                            _japFirst();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: PaginateFirestore(
                itemBuilder: (context, documentSnapshot) => ExpansionTileCard(
                  baseColor: Colors.white,
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
                            // onTap: () => phraseSpeech(
                            //     'en-US', documentSnapshot.data['eng']),
                            //phraseSpeech('en-US', documentSnapshot.data['eng']),
                            child: SubstringHighlight(
                              text: documentSnapshot.data[_p1],
                              //text: documentSnapshot.data['eng'],
                              term: documentSnapshot.data[_p1h],
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
                                  // onTap: () => phraseSpeech(
                                  //     'ko-KR', documentSnapshot.data['kor']),
                                  //phraseSpeech("ko-KR", documentSnapshot.data['kor']),
                                  //phraseSpeech("ko-KR", documentSnapshot.data['kor']),
                                  child: SubstringHighlight(
                                    text: documentSnapshot.data[_p2],
                                    term: documentSnapshot.data[_p2h],
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
                                // onTap: () => phraseSpeech(
                                //     'ko-KR', documentSnapshot.data['kor']),
                                child: SubstringHighlight(
                                  text: documentSnapshot.data[_p2prn],
                                  term: documentSnapshot.data[_p2prnh],
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
                                  // onTap: () => phraseSpeech(
                                  //     'ja-JP', documentSnapshot.data['jap']),
                                  child: SubstringHighlight(
                                    text: documentSnapshot.data[_p3],
                                    term: documentSnapshot.data[_p3h],
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
                                // onTap: () => phraseSpeech(
                                //     "ja-JP", documentSnapshot.data['jap']),
                                child: SubstringHighlight(
                                  text: documentSnapshot.data[_p3prn],
                                  term: documentSnapshot.data[_p3prnh],
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
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
                ),
                // orderBy is compulsary to enable pagination
                query:
                    Firestore.instance.collection('yt01memories').orderBy('id'),
              )),
            ],
          ),
        ),
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

  void _korFirst() {
    setState(() {
      print('kor button clicked');
      _controller.seekTo(Duration(seconds: documentSnapshot.data['seekto']));
      _p1 = 'kor';
    });
  }

  void _japFirst() {
    setState(() {
      _p1 = 'jap';
    });
  }
}
