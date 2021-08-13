import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../homepage.dart';
import 'language.dart';


class MyFlexiableAppBar extends StatelessWidget {

  final double appBarHeight = 60.0;
  

  const MyFlexiableAppBar();
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
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
                        Container(child: new Text(
                            "English",
                            style: const TextStyle(
                                color: Colors.amber,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                                fontSize: 22.0
                            )
                        ),),
                        Container(child: new Text(
                            "Korean,Japanese",
                            style: const TextStyle(
                                color: Colors.amber,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                                fontSize: 20.0
                            )
                        ),),
                      ],),),
    
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: new Text(
                              "Language skill up",
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontFamily: 'Poppins',
                                  fontSize: 18.0
                              )
                          ),
                        ),),
    
                        Container(child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Icon(
                            FontAwesomeIcons.longArrowAltUp, color: Colors.green,),
                        ),),
                      ],),
                  ),
    
    
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0,left:8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: new Image.asset('images/usa.png'),
                                tooltip: 'English Menu',
                                onPressed: langSet.engLoad,),
                                IconButton(
                                icon: new Image.asset('images/korea.png'),
                                tooltip: 'Korean Menu',
                                onPressed: langSet.korLoad,),
                                IconButton(
                                icon: new Image.asset('images/japan.png'),
                                tooltip: 'Japanese Menu',
                                onPressed: langSet.japLoad,),
                                IconButton(
                                icon: new Image.asset('images/china.png'),
                                tooltip: 'Chinese Menu',
                                onPressed: langSet.chnLoad,),
                                IconButton(
                                icon: new Image.asset('images/vietnam.png'),
                                tooltip: 'Vietmese Menu',
                                onPressed: langSet.vtnLoad,),
                                IconButton(
                                icon: new Image.asset('images/germany.png'),
                                tooltip: 'German Menu',
                                onPressed: langSet.gerLoad,),
                            ],
                          ),
                            
                        ),
                     ),
                   ],),                  
                  ),
                ],
            ),),);
  }
}