import 'package:enkornese/models/appbuilder.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:getwidget/getwidget.dart';
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

class MediBook extends StatefulWidget {
  @override
  _MediBookState createState() => _MediBookState();
}

class _MediBookState extends State<MediBook> {
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
  var title;

  YoutubePage({Key key, this.title}) : super(key: key);

  @override
  _YoutubePageState createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'hje7FztEKSk', // id youtube video
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ));

  // final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  // final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();

  Stream<QuerySnapshot> phrasesDocStream =
      Firestore.instance.collection('medibook1').snapshots();
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
                          onPressed: () {},
                        ),
                        SizedBox(width: 7),
                        GFIconButton(
                          icon: new Image.asset('images/japan.png'),
                          onPressed: () {},
                        ),
                        SizedBox(width: 7),
                        GFIconButton(
                          icon: new Image.asset('images/usa.png'),
                          onPressed: () {},
                        ),
                        SizedBox(width: 7),
                        GFIconButton(
                          icon: Icon(Icons.explore),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  stream: phrasesDocStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data.documents.length > 0) {
                      // get course document
                      var phrasesDocument = snapshot.data.documents[0];
                      // build list using names from sections
                      return ListView.builder(
                        itemCount: phrasesDocument.data.length,
                        itemBuilder: (_, int index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(MediBook());
                            },
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 14,
                                  child: itemView(
                                      phrasesDocument[(index + 1).toString()],
                                      (index + 1).toString()),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: Text("No data Found"),
                        ),
                      );
                    }
                  },
                ),
              ),
            ]),
      ),
    ));
  }

  Widget itemView(var item, var itemNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              item['id'].toString(),
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
                  _controller.seekTo(Duration(seconds: item['seekto']));
                  // _controller.seekTo(Duration(seconds: 120));
                });
              },
            ),
            Spacer(
              flex: 1,
            ),
            Text(
              item['seekto'].toString(),
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
        Text(item['title']),
        //Text(item['titleh']),
        Divider(color: Colors.black38)
      ],
    );
  }
}
