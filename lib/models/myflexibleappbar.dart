import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'languageprovider.dart';

class MyFlexiableAppBar extends StatelessWidget {
  final double appBarHeight = 60.0;

  const MyFlexiableAppBar();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final langSet = Provider.of<LanguageLoad>(context, listen: true);

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + appBarHeight,
      child: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: new Text("Select my base language...",
                        style: const TextStyle(
                            color: Colors.yellowAccent,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.italic,
                            fontSize: 16.0)),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: new Image.asset('images/usa.png'),
                            tooltip: 'English Menu',
                            onPressed: langSet.engLoad,
                          ),
                          IconButton(
                            icon: new Image.asset('images/korea.png'),
                            tooltip: 'Korean Menu',
                            onPressed: langSet.korLoad,
                          ),
                          IconButton(
                            icon: new Image.asset('images/japan.png'),
                            tooltip: 'Japanese Menu',
                            onPressed: langSet.japLoad,
                          ),
                          // IconButton(
                          // icon: new Image.asset('images/china.png'),
                          // tooltip: 'Chinese Menu',
                          // onPressed: langSet.chnLoad,),
                          // IconButton(
                          // icon: new Image.asset('images/vietnam.png'),
                          // tooltip: 'Vietmese Menu',
                          // onPressed: langSet.vtnLoad,),
                          // IconButton(
                          // icon: new Image.asset('images/germany.png'),
                          // tooltip: 'German Menu',
                          // onPressed: langSet.gerLoad,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
