import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import './models/menucategory.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'getphrases10yt.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

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

  var efirst = ["en-US", "eng", "eng", "engh", ""];
  var kfirst = ["ko-KR", "kor", "kor", "korh", "korprn"];
  var jfirst = ["ja-JP", "jap", "jap", "japh", "japprn"];

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
                          onPressed: () {
                            return Get.to(GetPhrases10yt(
                              'yt01memories',
                              'ko-KR',
                              'kor',
                              'korh',
                              'ko-KR',
                              'kor',
                              'korh',
                              'korprn',
                              'korprnh',
                              'ja-JP',
                              'jap',
                              'japh',
                              'japprn',
                              'japprnh',
                            ));
                          },
                          //text: "",
                          icon: new Image.asset('images/korea.png'),
                        ),
                        SizedBox(width: 5),
                        GFIconButton(
                          onPressed: () {},
                          //text: "",
                          icon: new Image.asset('images/japan.png'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child: Expanded(
                    child: GetPhrases10yt(
                  'yt01memories',
                  'en-US',
                  'eng',
                  'engh',
                  'ko-KR',
                  'kor',
                  'korh',
                  'korprn',
                  'korprnh',
                  'ja-JP',
                  'jap',
                  'japh',
                  'japprn',
                  'japprnh',
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
