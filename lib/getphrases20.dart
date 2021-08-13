import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/phrase.dart';
import 'models/phrasesmodel.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GetPhrases20 extends StatelessWidget {
  // final List<Phrases> phrases = [
  //   Phrases(
  //     eng: "snapshot.data[index].data['eng']",
  //     kor: "snapshot.data[index].data['kor']",
  //     korprn: "snapshot.data[index].data['korprn']",
  //     jap: "snapshot.data[index].data['jap']",
  //     japprn: "snapshot.data[index].data['japprn']",
  //   ),
  // ];
  final String argument;

  GetPhrases20({Key key, this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //listPage() {
    Future _datas;

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

    _datas = getMenus();

    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
      Container(
        width: double.infinity,
        height: 45,
        color: Colors.amber,
        child: Row(
          children: <Widget>[
            FlatButton(onPressed: null, child: Text('korean first')),
            FlatButton(onPressed: null, child: Text('japanese first')),
          ],
        ),
      ),
      FutureBuilder(
          future: _datas,
          builder: (BuildContext context,  AsyncSnapshot snapshot) {
            if(snapshot.data != null){
              print (snapshot.data);
            }
            return buildPhrases01(context, snapshot);
          }),
    ])));
  }





  Widget buildPhrases01(BuildContext context, AsyncSnapshot snapshot) {
    var phrase01 = snapshot.data;
     print (phrase01.length);

    void phraseSpeech(String langCode, String phrase) async {
      FlutterTts flutterTts = FlutterTts();

      await flutterTts.setLanguage(langCode);
      await flutterTts.setPitch(1);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(0.8);
      await flutterTts.speak(phrase);
    }

    return Flexible(
          child: ListView.builder(
          itemCount: phrase01 == null ? 0 : phrase01.length,
          itemBuilder: (BuildContext context, int index) {
            print (index);
            return Container(
                color: Color(0xFF4FC1d6),
                child: ExpansionCard(
                    borderRadius: 15.0,
                    //leading: Text("text"),
                    margin: const EdgeInsets.only(top: 30),
                    backgroundColor: Color(0xffD3D3D3),
                    title: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(phrase01[index].id.toString(),
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
                              // Text(phrase01.length.toString(),
                              //     textAlign: TextAlign.right,
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 14,
                              //         color: Colors.black26)),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(
                                    bottom: 30,
                                  ),
                                  width: 20,
                                  height: 20,
                                  child: IconButton(
                                    icon: Icon(MdiIcons.shareCircle,
                                        color: Color(0xFF4FC1d6)),
                                    onPressed: () {
                                      var string = "Dart is fun";
                                      string = phrase01[index].eng +
                                          '                              \n' +
                                          phrase01[index].kor +
                                          '\n' +
                                          phrase01[index].jap +
                                          '\n' +
                                          '😁From ENKORNESE😉';
                                      Share.share(string);
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                    bottom: 30,
                                  ),
                                  width: 20,
                                  height: 20,
                                  child: IconButton(
                                    icon: Icon(Icons.favorite_border,
                                        color: Color(0xFF4FC1d6)),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            phrase01[index].eng,
                            style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(5),
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
                                    ],
                                  ),

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
                                        onTap: () =>
                                            phraseSpeech("ko-KR", phrase01[index].kor),
                                        child: SubstringHighlight(
                                          text: phrase01[index].kor,
                                          term: "날씨",
                                          textStyle: GoogleFonts.nanumGothic(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .display1,
                                            fontSize: 22,
                                            color: Colors.black87,
                                            fontStyle: FontStyle.normal,
                                            //background: Paint()..color = Colors.blue,
                                          ),
                                          textStyleHighlight: GoogleFonts.lato(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .display1,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                      //Divider(),
                                      //한국어발음
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: GestureDetector(
                                          onTap: () =>
                                              phraseSpeech("ko-KR", phrase01[index].kor),
                                          child: SubstringHighlight(
                                            text: phrase01[index].kor,
                                            term: "nalssi",
                                            textStyle: GoogleFonts.lato(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                              fontSize: 18,
                                              color: Colors.black26,
                                              fontStyle: FontStyle.normal,
                                              //background: Paint()..color = Colors.white,
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
                                      ),
                                      Divider(),

                                      Wrap(
                                        alignment: WrapAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: CircleAvatar(
                                              child:
                                                  Image.asset('images/japan.png'),
                                              radius: 5.0,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => phraseSpeech(
                                                "ja-JP", phrase01[index].jap),
                                            child: SubstringHighlight(
                                              text: phrase01[index].jap,
                                              term: "今日",
                                              textStyle:
                                                  GoogleFonts.mPLUSRounded1c(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .display1,
                                                fontSize: 22,
                                                color: Colors.black54,
                                                fontStyle: FontStyle.normal,
                                                //background: Paint()..color = Colors.blue,
                                              ),
                                              textStyleHighlight:
                                                  GoogleFonts.mPLUSRounded1c(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .display1,
                                                fontSize: 20,
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
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: GestureDetector(
                                          onTap: () =>
                                              phraseSpeech("ja-JP", phrase01[index].jap),
                                          child: SubstringHighlight(
                                            text: phrase01[index].japprn,
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
                                ]),
                          )),
                    ]));
          }),
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
