import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'getphrases11ted.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TedMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'TED english'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'bW941OpsnMM', // id youtube video
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
            ),
            Container(
              height: 36,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'english',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'korean',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'japanese',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.circular(18),
              // ),
            ),
            //Expanded(child: GetPhrases10ted(argument: 'yt01memories')),
            Expanded(child: GetPhrases11ted()),
          ],
        ),
      ),
    );
  }
}
