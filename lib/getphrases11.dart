import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/phrasesmodel.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GetPhrases11 extends StatelessWidget {
  final List<Phrases> phrases = [
    Phrases(
      eng: "document['eng']",
      kor: "document['kor']",
      korprn: "document['korprn']",
      jap: "document['jap']",
      japprn: "document['japprn']",
    ),
  ];

  final String screenTitle;
  final String firestoreName;

  GetPhrases11({
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

    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(firestoreName).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');

        final datas = snapshot.data.documents;
        int index = datas.length;
        print(index);
        datas.sort((a, b) {
          return a['id'].compareTo(b['id']);
        });
        return Material(
          color: Color(0xFFB1736C),
          child: new ListView(
            children: snapshot.data.documents.map((DocumentSnapshot document) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 3.0, 2.0, 4.0),
                //컨테이너 시작
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new ExactAssetImage('images/hawaii.jpg'),
                        fit: BoxFit.cover,
                      ),
                      // gradient: LinearGradient(
                      //   begin: Alignment.bottomRight,
                      //   end: Alignment.bottomLeft,
                      //   colors: [Colors.white, Colors.grey[300], Colors.white],
                      //   // colors: [Colors.limeAccent, Colors.yellow[300],Colors.orange[200]],
                      // ),
                      //color: Colors.deepPurpleAccent[150],
                      shape: BoxShape.rectangle,
                      //border: Border.all(color: Colors.brown),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0))
                      // image: DecorationImage(
                      //   fit: BoxFit.fill,
                      //   image: NetworkImage("https://pbs.twimg.com/profile_images/610120554738266112/I4pl2ygE_400x400.jpg")
                      // )
                      ),
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
                            Text(document['id'].toString(),
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
                            Text(datas.length.toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black26)),
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
                                      string = document['eng'] +
                                          '                              \n' +
                                          document['kor'] +
                                          '\n' +
                                          document['jap'] +
                                          '\n' +
                                          '😁From ENKORNESE😉';
                                      Share.share(string);
                                    },
                                    child: Icon(MdiIcons.shareCircle,
                                        color: Colors.grey)),
                              ],
                            ),
                            Divider(
                              endIndent: 10,
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: Icon(Icons.favorite_border,
                                    color: Colors.grey)),
                          ],
                        ),

                        //영어출력
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
                              onTap: () =>
                                  phraseSpeech("en-US", document['eng']),

                              // child: Text(document['eng'],
                              child: Text(
                                document['eng'],
                                style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.display1,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal,
                                  background: Paint()..color = Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                              onTap: () =>
                                  phraseSpeech("ko-KR", document['kor']),
                              child: SubstringHighlight(
                                text: document['kor'],
                                term: "날씨",
                                textStyle: GoogleFonts.nanumGothic(
                                  textStyle:
                                      Theme.of(context).textTheme.display1,
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal,
                                  background: Paint()..color = Colors.blue,
                                ),
                                textStyleHighlight: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.display1,
                                  fontSize: 16,
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
                            onTap: () => phraseSpeech("ko-KR", document['kor']),
                            child: SubstringHighlight(
                              text: document['korprn'],
                              term: "nalssi",
                              textStyle: GoogleFonts.lato(
                                textStyle: Theme.of(context).textTheme.display1,
                                fontSize: 14,
                                color: Colors.black26,
                                fontStyle: FontStyle.normal,
                                background: Paint()..color = Colors.white,
                              ),
                              textStyleHighlight: GoogleFonts.lato(
                                textStyle: Theme.of(context).textTheme.display1,
                                fontSize: 14,
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
                              onTap: () =>
                                  phraseSpeech("ja-JP", document['jap']),
                              child: SubstringHighlight(
                                text: document['jap'],
                                term: "今日",
                                textStyle: GoogleFonts.mPLUSRounded1c(
                                  textStyle:
                                      Theme.of(context).textTheme.display1,
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal,
                                background: Paint()..color = Colors.blue,

                                ),
                                textStyleHighlight: GoogleFonts.mPLUSRounded1c(
                                  textStyle:
                                      Theme.of(context).textTheme.display1,
                                  fontSize: 16,
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
                            onTap: () => phraseSpeech("ja-JP", document['jap']),
                            child: SubstringHighlight(
                              text: document['japprn'],
                              term: "Kyō wa",
                              textStyle: GoogleFonts.mPLUSRounded1c(
                                textStyle: Theme.of(context).textTheme.display1,
                                fontSize: 14,
                                color: Colors.black26,
                                fontStyle: FontStyle.normal,
                                background: Paint()..color = Colors.white,

                              ),
                              textStyleHighlight: GoogleFonts.mPLUSRounded1c(
                                textStyle: Theme.of(context).textTheme.display1,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),

                        //하위 4개 컨테이너  작은 컨테이너
                        Divider(
                          thickness: 3.0,
                        ),
                        SizedBox(
                          child: Card(
                            child: Text('Expand sample'),
                            color: Colors.yellowAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
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
