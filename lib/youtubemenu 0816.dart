import 'package:enkornese/models/appbuilder.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:share/share.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

import 'models/customtext.dart';
import 'models/phrasesmodel.dart';

class YoutubeMenu extends StatefulWidget {
  @override
  _YoutubeMenuState createState() => _YoutubeMenuState();
}

class _YoutubeMenuState extends State<YoutubeMenu> {
  @override
  Widget build(BuildContext context) {
    return AppBuilder(
      builder: (context) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: YoutubePage(title: 'Youtube english'),
        );
      },
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

  // final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  // final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();

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
  String _line1 = 'eng';
  String _line1h = 'engh';
  String _line1prn = 'space';
  String _line1hprn = 'space';
  //String _p1prnh = null;
  String _line2 = 'kor';
  String _line2h = 'korh';
  String _line2prn = 'korprn';
  String _line2hprn = 'korhprn';

  String _line3 = 'jap';
  String _line3h = 'japh';
  String _line3prn = 'japprn';
  String _line3hprn = 'japhprn';
  bool isExplore = false;

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
                    bottom: 30,
                    child: Row(
                      children: <Widget>[
                        GFIconButton(
                          icon: new Image.asset('images/korea.png'),
                          onPressed: () {
                            _korFirst();
                          },
                        ),
                        SizedBox(width: 7),
                        GFIconButton(
                          icon: new Image.asset('images/japan.png'),
                          onPressed: () {
                            _japFirst();
                          },
                        ),
                        SizedBox(width: 7),
                        GFIconButton(
                          icon: new Image.asset('images/usa.png'),
                          onPressed: () {
                            _engFirst();
                          },
                        ),
                        SizedBox(width: 7),
                        GFIconButton(
                          icon: Icon(Icons.explore),
                          onPressed: () {
                            _isExplore();
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
                  baseColor: Colors.grey[200],
                  initiallyExpanded: isExplore,
                  title: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
/* -------------------------------------------------------------------------- */
/*                                    id시작                                    */
/* -------------------------------------------------------------------------- */

                            Text(
                              documentSnapshot.data['id'].toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  fontSize: 12,
                                  color: Colors.black26),
                            ),
                            Spacer(flex: 5),
                            IconButton(
                              icon: Icon(Icons.local_movies, size: 17),
                              color: Colors.grey,
                              onPressed: () {
                                setState(() {
                                  _controller.seekTo(Duration(
                                      seconds:
                                          documentSnapshot.data['seekto']));
                                  // _controller.seekTo(Duration(seconds: 120));
                                });
                              },
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              documentSnapshot.data['seekto'].toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  fontSize: 12,
                                  color: Colors.black26),
                            ),
                            Text(
                              ' seconds',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  fontSize: 12,
                                  color: Colors.black26),
                            ),
                          ],
                        ),

/* -------------------------------------------------------------------------- */
/*               //여기서 부터 문장이 시작한다.(영어) line1                          */
/* -------------------------------------------------------------------------- */

                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: GestureDetector(
                            // onTap: () => phraseSpeech(
                            //     'en-US', documentSnapshot.data['eng']),
                            //phraseSpeech('en-US', documentSnapshot.data['eng']),
                            child: Line1Text(documentSnapshot.data[_line1],
                                documentSnapshot.data[_line1h], 17),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: GestureDetector(
                            // onTap: () => phraseSpeech(
                            //     'en-US', documentSnapshot.data['eng']),
                            //phraseSpeech('en-US', documentSnapshot.data['eng']),
                            child: Line2Text(documentSnapshot.data[_line1prn],
                                documentSnapshot.data[_line1hprn], 14),
                          ),
                        ),
                      ],
                    ),
                  ),

/* -------------------------------------------------------------------------- */
/*                                   line2시작                                  */
/* -------------------------------------------------------------------------- */
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Image.asset(
                          //   "images/korea.png",
                          //   fit: BoxFit.cover,
                          // ),
                          //  Divider(),
                          //한국어출력
                          GestureDetector(
                            // onTap: () => phraseSpeech(
                            //     'ko-KR', documentSnapshot.data['kor']),
                            //phraseSpeech("ko-KR", documentSnapshot.data['kor']),
                            //phraseSpeech("ko-KR", documentSnapshot.data['kor']),

/* -------------------------------------------------------------------------- */
/*                                   line2h                                   */
/* -------------------------------------------------------------------------- */

                            child: Line1Text(documentSnapshot.data[_line2],
                                documentSnapshot.data[_line2h], 17),
                          ),
                          //Divider(),
                          //한국어발음
                          GestureDetector(
                            // onTap: () => phraseSpeech(
                            //     'ko-KR', documentSnapshot.data['kor']),
                            child: Line2Text(documentSnapshot.data[_line2prn],
                                documentSnapshot.data[_line2hprn], 14),
                          ),
                          Divider(),

/* -------------------------------------------------------------------------- */
/*                                    //line3 시작 부분                                   */
/* -------------------------------------------------------------------------- */

                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                          ),
                          GestureDetector(
                            // onTap: () => phraseSpeech(
                            //     'ja-JP', documentSnapshot.data['jap']),
                            child: Line1Text(documentSnapshot.data[_line3],
                                documentSnapshot.data[_line3h], 17),
                          ),

/* -------------------------------------------------------------------------- */
/*                                  //line3 발음                                  */
/* -------------------------------------------------------------------------- */

                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: GestureDetector(
                              // onTap: () => phraseSpeech(
                              //     "ja-JP", documentSnapshot.data['jap']),
                              child: Line2Text(documentSnapshot.data[_line3prn],
                                  documentSnapshot.data[_line3hprn], 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      buttonHeight: 22.0,
                      buttonMinWidth: 30.0,
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
                                    const EdgeInsets.symmetric(vertical: 1.0),
                              ),
                              Text(
                                'Save',
                                style: TextStyle(
                                  fontFamily: "NotoSansCJKkr",
                                  fontSize: 10,
                                  color: Colors.blue[800],
                                  fontStyle: FontStyle.normal,
                                  //background: Paint()..color = Colors.blue,
                                ),
                              ),
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
                              Text(
                                'Pattern',
                                style: TextStyle(
                                  fontFamily: "NotoSansCJKkr",
                                  fontSize: 10,
                                  color: Colors.blue[800],
                                  fontStyle: FontStyle.normal,
                                  //background: Paint()..color = Colors.blue,
                                ),
                              ),
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
                              Text(
                                'Share',
                                style: TextStyle(
                                  fontFamily: "NotoSansCJKkr",
                                  fontSize: 10,
                                  color: Colors.blue[800],
                                  fontStyle: FontStyle.normal,
                                  //background: Paint()..color = Colors.blue,
                                ),
                              ),
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
      //print('kor button clicked');
      // var documentSnapshot;
      //_controller.seekTo(Duration(seconds: documentSnapshot.data['seekto']));
      //_controller.seekTo(Duration(seconds: 120));
      _line1 = 'kor';
      _line1h = 'korh';
      _line1prn = 'korprn';
      _line1hprn = 'korhprn';
      _line2 = 'jap';
      _line2h = 'japh';
      _line2prn = 'japprn';
      _line2hprn = 'japhprn';
      _line3 = 'eng';
      _line3h = 'engh';
      _line3prn = 'space';
      _line3hprn = 'space';
    });
  }

  void _japFirst() {
    setState(() {
      _line1 = 'jap';
      _line1h = 'japh';
      _line1prn = 'japprn';
      _line1hprn = 'japhprn';
      _line2 = 'kor';
      _line2h = 'korh';
      _line2prn = 'korprn';
      _line2hprn = 'korhprn';
      _line3 = 'eng';
      _line3h = 'engh';
      _line3prn = 'space';
      _line3hprn = 'space';
    });
  }

  void _engFirst() {
    setState(() {
      _line1 = 'eng';
      _line1h = 'engh';
      _line1prn = 'space';
      _line2 = 'kor';
      _line2h = 'korh';
      _line2prn = 'korprn';
      _line2hprn = 'korhprn';
      _line3 = 'jap';
      _line3h = 'japh';
      _line3prn = 'japprn';
      _line3hprn = 'japhprn';
    });
  }

  void _isExplore() {
    setState(() {
      isExplore = !isExplore;
      AppBuilder.of(context).rebuild();
      //isExplore = !isExplore;
    });
  }
}
