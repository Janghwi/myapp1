import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splashhome.dart';
import 'homepage.dart';
import 'youtubemenu.dart';
import 'models/onephraseprovider.dart';
import 'models/languageprovider.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnePhraseProvider()),
        ChangeNotifierProvider(create: (context) => LanguageLoad()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/second', page: () => YoutubeMenu()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      //theme: appTheme(),
      // theme: ThemeData(
      //   primaryColor: new Color(0xff6a53a4),
      home: SplashHome(),
    );
  }
}
