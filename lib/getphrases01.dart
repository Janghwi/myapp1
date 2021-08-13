import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/phrasesmodel.dart';

class GetPhrases01 extends StatelessWidget {
  List<Phrases> phrases = [
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

  GetPhrases01({
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
          color: Color(0xFFF7786B),
          child: new ListView(
            children: snapshot.data.documents.map((DocumentSnapshot document) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 10.0, 2.0, 10.0),
                child: AnimatedContainer(
                  duration: Duration(seconds: 0),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.white, Colors.grey[300], Colors.white],
                        // colors: [Colors.limeAccent, Colors.yellow[300],Colors.orange[200]],
                      ),
                      //color: Colors.deepPurpleAccent[150],
                      shape: BoxShape.rectangle,
                      //border: Border.all(color: Colors.brown),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(13.0),
                          topRight: Radius.circular(13.0),
                          bottomLeft: Radius.circular(13.0),
                          bottomRight: Radius.circular(13.0))
                      // image: DecorationImage(
                      //   fit: BoxFit.fill,
                      //   image: NetworkImage("https://pbs.twimg.com/profile_images/610120554738266112/I4pl2ygE_400x400.jpg")
                      // )
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(document['id'].toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
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
                                    fontSize: 10,
                                    color: Colors.blueGrey)),
                            Divider(
                              endIndent: 26,
                            ),
                            GestureDetector(
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
                                child: Icon(Icons.share, color: Colors.grey)),
                            Divider(
                              endIndent: 10,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: Icon(Icons.favorite_border,
                                    color: Colors.grey)),
                          ],
                        ),

                        GestureDetector(
                          onTap: () => phraseSpeech("en-US", document['eng']),
                          child: Text(
                            document['eng'],
                            style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, decoration: TextDecoration.none,
                        // color:Colors.black87,fontFamily: "Montserrat",)),),
                        Divider(),
                        SizedBox(
                          height: 10.0,
                        ),

                        GestureDetector(
                          onTap: () => phraseSpeech("ko-KR", document['kor']),
                          child: Text(
                            document['kor'],
                            style: GoogleFonts.nanumGothicCoding(
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        //Divider(),

                        GestureDetector(
                          onTap: () => phraseSpeech("ko-KR", document['kor']),
                          child: Text(document['korprn'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  decoration: TextDecoration.none,
                                  color: Colors.black26)),
                        ),
                        Divider(),
                        SizedBox(
                          height: 10.0,
                        ),

                        GestureDetector(
                          onTap: () => phraseSpeech("ja-JP", document['jap']),
                          child: Text(
                            document['jap'],
                            style: GoogleFonts.mPLUSRounded1c(
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        //Divider(),

                        GestureDetector(
                          onTap: () => phraseSpeech("ja-JP", document['jap']),
                          child: Text(document['japprn'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  decoration: TextDecoration.none,
                                  color: Colors.black26)),
                        ),
                        SizedBox(
                          height: 10.0,
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
