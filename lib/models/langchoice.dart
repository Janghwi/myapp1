import 'package:flutter/material.dart';

import 'menudisplay1.dart';


class LanguageChoice extends StatefulWidget {
 @override
 _LannguageChoiceState createState() => _LannguageChoiceState();
 }

class _LannguageChoiceState extends State<LanguageChoice> {

@override
Widget build(BuildContext context) {
return Wrap(
  alignment: WrapAlignment.center,
  spacing: 5.0,
  children: <Widget>[
    IconButton(
              icon: Icon(Icons.access_alarm),
              onPressed: () {
                 MenuDisplay1(language: 'eng');
              },
            ),
    IconButton(
              icon: Icon(Icons.access_alarm),
              onPressed: () {
                 MenuDisplay1(language: 'kor');
              },
            ),
    IconButton(
              icon: Icon(Icons.access_alarm),
              onPressed: () {
                 MenuDisplay1(language: 'jap');
              },
            ),
  ],
);
}
}