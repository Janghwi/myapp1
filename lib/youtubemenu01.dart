import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:share/share.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:getwidget/getwidget.dart';
import './models/menucategory.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'getphrases10yt.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'models/phrasesmodel.dart';

class YoutubeMenu01 extends StatelessWidget {
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
  static const htmlData = """
      <!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    <p><span style="color: rgb(51, 51, 51); font-family: utopia-std, Georgia, &quot;Hiragino Mincho Pro&quot;, &quot;Hiragino Mincho&quot;, serif; font-size: 18px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 200; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(251, 251, 251); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">The
        government may ask Tokyo and its neighboring prefectures of Kanagawa,
        Saitama and Chiba to make business suspension requests depending on the
        extent of the new coronavirus outbreak there, economic revitalization
        minister Yasutoshi Nishimura said Sunday.</span></p>
    <p><span style="color: rgb(51, 51, 51); font-family: utopia-std, Georgia, &quot;Hiragino Mincho Pro&quot;, &quot;Hiragino Mincho&quot;, serif; font-size: 18px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 200; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(251, 251, 251); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"><br>
      </span></p>
    <p><span style="color: rgb(51, 51, 51); font-family: utopia-std, Georgia, &quot;Hiragino Mincho Pro&quot;, &quot;Hiragino Mincho&quot;, serif; font-size: 18px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 200; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(251, 251, 251); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"><br>
      </span></p>
    <p><br>
      <span style="color: rgb(0, 0, 0); font-family: メイリオ, Meiryo, &quot;Noto Sans&quot;, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"><span

          style="color: #ff6600;">実際に</span>Sublime textは「恋に落ちるエディタ(The text
        editor you’ll fall in love with)」というキャッチフレーズがあるほどです。</span></p>
    <p><span style="color: rgb(0, 0, 0); font-family: メイリオ, Meiryo, &quot;Noto Sans&quot;, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"><span

          style="color: #ff6600;">실제로는</span> 많은 삶들이 오고가는 문제이기도 하다. <br>
      </span></p>
    <p><span style="color: rgb(0, 0, 0); font-family: メイリオ, Meiryo, &quot;Noto Sans&quot;, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"><span

          style="color: #ff6600;">In general</span> There seems to be the
        problem we want it <br>
      </span></p>
    <p><span style="color: rgb(0, 0, 0); font-family: メイリオ, Meiryo, &quot;Noto Sans&quot;, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"><br>
      </span></p>
    <p><br>
      <span style="color: rgb(51, 51, 51); font-family: &quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, &quot;Hiragino Kaku Gothic Pro&quot;, &quot;ヒラギノ角ゴ Pro W3&quot;, メイリオ, Meiryo, &quot;ＭＳ Ｐゴシック&quot;, Helvetica, Arial, Verdana, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"><span

          style="font-family: Èt¼;"><a href="https://eigoland.net/phrase/" target="_blank"><span><b

                style="color: #cc0000;">Where can I find</b></span></a><span>
            a grocery store ?</span><span><br>
          </span><span>食料品店は</span><b><span><span style="color: #cc0000;">どこで見つけ
                ることができますか</span></span><span>？</span></b></span><br>
      </span></p>
    <p><span style="color: rgb(51, 51, 51); font-family: &quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, &quot;Hiragino Kaku Gothic Pro&quot;, &quot;ヒラギノ角ゴ Pro W3&quot;, メイリオ, Meiryo, &quot;ＭＳ Ｐゴシック&quot;, Helvetica, Arial, Verdana, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">식
        료품점은 <b><span style="color: #cc0000;">어디에서 찾을수 있습니까? </span></b><br>
      </span></p>
    <p><span style="color: rgb(51, 51, 51); font-family: &quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, &quot;Hiragino Kaku Gothic Pro&quot;, &quot;ヒラギノ角ゴ Pro W3&quot;, メイリオ, Meiryo, &quot;ＭＳ Ｐゴシック&quot;, Helvetica, Arial, Verdana, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"

        role="cell"><br>
      </span></p>
  </body>
</html>

""";
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _lists = [];
  bool _loadingLists = true;
  int _perPage = 100;
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreLists = false;
  bool _moreListsAvailable = true;

  _getLists() async {
    Query q =
        _firestore.collection("yt01memories").orderBy('id').limit(_perPage);

    setState(() {
      _loadingLists = true;
    });

    QuerySnapshot querySnapshot = await q.getDocuments();
    _lists = querySnapshot.documents;
    _lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];
    print('last document' + _lastDocument.toString());

    setState(() {
      _loadingLists = false;
    });
  }

  _getMoreLists() async {
    print('get morelist called');

    if (_moreListsAvailable == false) {
      print('No more lists');
      return;
    }
    if (_moreListsAvailable == true) {
      return;
    }

    _gettingMoreLists = true;

    Query q = _firestore
        .collection("yt03memories")
        .orderBy('id')
        .startAfter([_lastDocument.data['id']]).limit(_perPage);

    QuerySnapshot querySnapshot = await q.getDocuments();
    if (querySnapshot.documents.length < _perPage) {
      _moreListsAvailable = false;
    }

    _lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];

    _lists.addAll(querySnapshot.documents);

    setState(() {});
    _gettingMoreLists = false;
  }

  @override
  void initState() {
    super.initState();
    _getLists();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.30;
      if (maxScroll - currentScroll <= delta) {
        _getMoreLists();
      }
    });
  }

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
              Container(
                child: _loadingLists == true
                    ? Center(
                        child: Text("Loading"),
                      )
                    : Expanded(
                        child: _lists.length == 0
                            ? Center(
                                child: Text(
                                    "No lists to show \n Contents preparing!!"),
                              )
                            : ListView.builder(
                                controller: _scrollController,
                                itemCount: _lists.length,
                                itemBuilder: (BuildContext ctx, int index) =>
                                    ExpansionTileCard(
                                  baseColor: Colors.white,
                                  title: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              _lists[index]
                                                  .data['id']
                                                  .toString(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 10,
                                                  color: Colors.black26),
                                            ),
                                            Text(
                                                '                      Press sentence 🔊',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 10,
                                                    color: Colors.grey[300])),
                                          ],
                                        ),
                                        //여기서 부터 문장이 시작한다.(영어)
                                        //
                                        //
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: GestureDetector(
                                            // onTap: () => phraseSpeech(
                                            //     'en-US', documentSnapshot.data['eng']),
                                            //phraseSpeech('en-US', documentSnapshot.data['eng']),
                                            child: SubstringHighlight(
                                              text: _lists[index].data[_p1],
                                              //text: documentSnapshot.data['eng'],
                                              term: _lists[index].data[_p1h],
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
                                        // Padding(
                                        //       padding: const EdgeInsets.only(left: 15.0),
                                        //       child: GestureDetector(
                                        //         // onTap: () => phraseSpeech(
                                        //         //     'ko-KR', documentSnapshot.data['kor']),
                                        //         child: SubstringHighlight(
                                        //           text: documentSnapshot.data[_p1prn],
                                        //           term: documentSnapshot.data[_p1prnh],
                                        //           textStyle: TextStyle(
                                        //             fontFamily: "NotoSansCJKkr",
                                        //             fontSize: 12,
                                        //             color: Colors.black45,
                                        //             fontStyle: FontStyle.normal,
                                        //             //background: Paint()..color = Colors.white,
                                        //           ),
                                        //           textStyleHighlight: TextStyle(
                                        //             fontFamily: "NotoSansCJKkr",
                                        //             fontSize: 12,
                                        //             fontWeight: FontWeight.bold,
                                        //             color: Colors.red,
                                        //             fontStyle: FontStyle.normal,
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                      ],
                                    ),
                                  ),
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 7),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        //컬럼 시작
                                        child: Column(
                                          //mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //  Divider(),
                                            //한국어출력
                                            Wrap(
                                              alignment: WrapAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: CircleAvatar(
                                                    child: Image.asset(
                                                        'images/korea.png'),
                                                    radius: 5.0,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  // onTap: () => phraseSpeech(
                                                  //     'ko-KR', documentSnapshot.data['kor']),
                                                  //phraseSpeech("ko-KR", documentSnapshot.data['kor']),
                                                  //phraseSpeech("ko-KR", documentSnapshot.data['kor']),
                                                  child: SubstringHighlight(
                                                    text:
                                                        _lists[index].data[_p2],
                                                    term: _lists[index]
                                                        .data[_p2h],
                                                    textStyle: TextStyle(
                                                      fontFamily:
                                                          "NotoSansCJKkr",
                                                      fontSize: 12,
                                                      color: Colors.blue[800],
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      //background: Paint()..color = Colors.blue,
                                                    ),
                                                    textStyleHighlight:
                                                        TextStyle(
                                                      fontFamily:
                                                          "NotoSansCJKkr",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //Divider(),
                                            //한국어발음
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: GestureDetector(
                                                // onTap: () => phraseSpeech(
                                                //     'ko-KR', documentSnapshot.data['kor']),
                                                child: SubstringHighlight(
                                                  text: _lists[index]
                                                      .data[_p2prn],
                                                  term: _lists[index]
                                                      .data[_p2prnh],
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
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: CircleAvatar(
                                                    child: Image.asset(
                                                        'images/japan.png'),
                                                    radius: 6.0,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  // onTap: () => phraseSpeech(
                                                  //     'ja-JP', documentSnapshot.data['jap']),
                                                  child: SubstringHighlight(
                                                    text:
                                                        _lists[index].data[_p3],
                                                    term: _lists[index]
                                                        .data[_p3h],
                                                    textStyle: TextStyle(
                                                      fontFamily:
                                                          "NotoSansCJKkr",
                                                      fontSize: 12,
                                                      color: Colors.blue[700],
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      //background: Paint()..color = Colors.blue,
                                                    ),
                                                    textStyleHighlight:
                                                        TextStyle(
                                                      fontFamily:
                                                          "NotoSansCJKkr",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //일본어 발음
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: GestureDetector(
                                                // onTap: () => phraseSpeech(
                                                //     "ja-JP", documentSnapshot.data['jap']),
                                                child: SubstringHighlight(
                                                  text: _lists[index]
                                                      .data[_p3prn],
                                                  term: _lists[index]
                                                      .data[_p3prnh],
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                          onPressed: () {}, //share끝나는 부분
                                          child: Column(
                                            children: <Widget>[
                                              Icon(Icons.star,
                                                  color: Colors.grey),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0),
                                              ),
                                              Text('Save'),
                                            ],
                                          ),
                                        ),
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                          onPressed: () {
                                            slideDialog.showSlideDialog(
                                              context: context,
                                              child: Container(
                                                height: 400,
                                                width: 400,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: <Widget>[
                                                      HtmlWidget(
                                                        htmlData,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
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
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0),
                                              ),
                                              Text('Pattern'),
                                            ],
                                          ),
                                        ),
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                          onPressed: () {
                                            var string = "Dart is fun";
                                            string = _lists[index].data['eng'] +
                                                '                              \n' +
                                                _lists[index].data['kor'] +
                                                '\n' +
                                                _lists[index].data['jap'] +
                                                '\n' +
                                                '😁From ENKORNESE😉';
                                            Share.share(string);
                                          }, //share끝나는 부분
                                          child: Column(
                                            children: <Widget>[
                                              Icon(Icons.share),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0),
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
                              ),
                      ),
              ),
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
      _p1 = 'kor';
    });
  }

  void _japFirst() {
    setState(() {
      _p1 = 'jap';
    });
  }
}
