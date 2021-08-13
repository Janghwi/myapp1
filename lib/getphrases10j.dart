import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/phrasesmodel.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GetPhrases10j extends StatelessWidget {
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

  GetPhrases10j({Key key, this.argument}) : super(key: key);

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

    return Material(
        color: Colors.grey,
        child: FutureBuilder(
          future: _datas,
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
                    return ExpansionCard(
                        borderRadius: 15.0,
                        //leading: Text("text"),
                        margin: const EdgeInsets.only(top: 10),
                        backgroundColor: Color(0xffD3D3D3),
                        title: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      snapshot.data[index].data['id']
                                          .toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none,
                                          fontSize: 12,
                                          color: Colors.black26)),
                                  Text('/',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none,
                                          fontSize: 12,
                                          color: Colors.black26)),
                                  Text(snapshot.data.length.toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black26)),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      margin: EdgeInsets.only(
                                        bottom: 20,
                                      ),
                                      width: 20,
                                      height: 20,
                                      child: IconButton(
                                        icon: Icon(MdiIcons.shareCircle,
                                            color: Color(0xFF4FC1d6)),
                                        onPressed: () {
                                          var string = "Dart is fun";
                                          string = snapshot
                                                  .data[index].data['eng'] +
                                              '                              \n' +
                                              snapshot.data[index].data['kor'] +
                                              '\n' +
                                              snapshot.data[index].data['jap'] +
                                              '\n' +
                                              '😁From ENKORNESE😉';
                                          Share.share(string);
                                        }, //share끝나는 부분
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                        bottom: 20,
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
                              //여기서 부터 문장이 시작한다.(일본)
                              //
                              //
                              //
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    //child: Image.asset('images/korea.png'),
                                  ),
                                  GestureDetector(
                                    onTap: () => phraseSpeech("ja-JP",
                                        snapshot.data[index].data['jap']),
                                    child: SubstringHighlight(
                                      text: snapshot.data[index].data['jap'],
                                      term: "날씨",
                                      textStyle: GoogleFonts.mPLUSRounded1c(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        fontSize: 19,
                                        color: Colors.black,
                                        fontStyle: FontStyle.normal,
                                        //background: Paint()..color = Colors.blue,
                                      ),
                                      textStyleHighlight: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //Divider(),
                              //일본어발음
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: GestureDetector(
                                  onTap: () => phraseSpeech("ja-JP",
                                      snapshot.data[index].data['jap']),
                                  child: SubstringHighlight(
                                    text: snapshot.data[index].data['japprn'],
                                    term: "nalssi", 
                                    textStyle: GoogleFonts.mPLUSRounded1c(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText1,
                                      fontSize: 12,
                                      color: Colors.black45,
                                      fontStyle: FontStyle.normal,
                                      //background: Paint()..color = Colors.white,
                                    ),
                                    textStyleHighlight: GoogleFonts.lato(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText1,
                                      fontSize: 19,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('   👆 Press sentence 🗣️',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.none,
                                                fontSize: 12,
                                                color: Colors.blueGrey[200])),
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
                                    //영어출력
                                    Wrap(
                                      alignment: WrapAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: CircleAvatar(
                                            child:
                                                Image.asset('images/usa.png'),
                                            radius: 5.0,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => phraseSpeech("en-US",
                                              snapshot.data[index].data['eng']),
                                          child: SubstringHighlight(
                                            text: snapshot
                                                .data[index].data['eng'],
                                            term: "날씨",
                                            textStyle: GoogleFonts.pTSerif(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                              fontSize: 19,
                                              color: Colors.blue[800],
                                              fontStyle: FontStyle.normal,
                                              //background: Paint()..color = Colors.blue,
                                            ),
                                            textStyleHighlight:
                                                GoogleFonts.lato(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                              fontSize: 19,
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
                                    Wrap(
                                  alignment: WrapAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CircleAvatar(
                                        child:
                                            Image.asset('images/kor.png'),
                                        radius: 5.0,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => phraseSpeech("ko-KR",
                                          snapshot.data[index].data['kor']),
                                      child: SubstringHighlight(
                                        text:
                                            snapshot.data[index].data['kor'],
                                        term: "날씨",
                                        textStyle: GoogleFonts.nanumMyeongjo(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          fontSize: 19,
                                          color: Colors.blue[800],
                                          fontStyle: FontStyle.normal,
                                          //background: Paint()..color = Colors.blue,
                                        ),
                                        textStyleHighlight: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          fontSize: 19,
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
                                      text:
                                          snapshot.data[index].data['korprn'],
                                      term: "nalssi",
                                      textStyle: GoogleFonts.nanumMyeongjo(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        fontSize: 19,
                                        color: Colors.black45,
                                        fontStyle: FontStyle.normal,
                                        //background: Paint()..color = Colors.white,
                                      ),
                                      textStyleHighlight: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                  ],
                                ),
                              ))
                        ]);
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
