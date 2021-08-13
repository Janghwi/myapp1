import 'dart:wasm';

import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';

class CustomText extends StatelessWidget {
  final String text;

  const CustomText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 20.0),
    );
  }
}

class Line1Text extends StatelessWidget {
  final String lineNo1;
  final String lineNo2;
  final double fsize;

  const Line1Text(
    this.lineNo1,
    this.lineNo2,
    this.fsize,
  );

  @override
  Widget build(BuildContext context) {
    return SubstringHighlight(
      text: lineNo1,
      //text: documentSnapshot.data['eng'],
      term: lineNo2,
      //term: documentSnapshot.data['engh'],
      textStyle: TextStyle(
        fontFamily: "NotoSansCJKkr",
        fontSize: fsize,
        color: Colors.black,
        fontStyle: FontStyle.normal,
        //background: Paint()..color = Colors.white,
      ),
      textStyleHighlight: TextStyle(
        fontFamily: "NotoSansCJKkr",
        fontSize: fsize,
        fontWeight: FontWeight.bold,
        color: Colors.red[300],
        fontStyle: FontStyle.normal,
      ),
    );
  }
}

class Line2Text extends StatelessWidget {
  final String line2No1;
  final String line2No2;
  final double fsize;

  const Line2Text(
    this.line2No1,
    this.line2No2,
    this.fsize,
  );

  @override
  Widget build(BuildContext context) {
    return SubstringHighlight(
      text: line2No1,
      //text: documentSnapshot.data['eng'],
      term: line2No2,
      //term: documentSnapshot.data['engh'],
      textStyle: TextStyle(
        fontFamily: "NotoSansCJKkr",
        fontSize: fsize,
        color: Colors.black45,
        fontStyle: FontStyle.normal,
        //background: Paint()..color = Colors.white,
      ),
      textStyleHighlight: TextStyle(
        fontFamily: "NotoSansCJKkr",
        fontSize: fsize,
        fontWeight: FontWeight.bold,
        color: Colors.red[300],
        fontStyle: FontStyle.normal,
      ),
    );
  }
}
