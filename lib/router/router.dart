import 'package:enkornese/menuview/medimenu.dart';
import 'package:flutter/material.dart';

import '../getphrases10tt.dart';
import '../gettabbar01.dart';
import '../splashhome.dart';
import '../homepage.dart';
import '../homepagenext.dart';
import 'routing_constants.dart';
import 'undefined_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashViewRoute:
      return MaterialPageRoute(builder: (context) => SplashHome());

    case LoginViewRoute:
      return MaterialPageRoute(builder: (context) => HomePage());

    case HomepageViewRoute:
      return MaterialPageRoute(builder: (context) => HomePage());

    case MenuViewRoute:
      var menuArgument = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => HomepageNext(firestoreName: menuArgument));

    case SecondMenuViewRoute:
      var menuArgument = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => MediMenu(firestoreName: menuArgument));

    case PhraseViewRoute:
      var menuArgument = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => GetTabbar01(argument: menuArgument));

    case PhraseViewRoute1:
      var menuArgument = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => GetPhrases10tt(argument: menuArgument));

    case youtubeViewRoute:
      var menuArgument = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => GetPhrases10tt(argument: menuArgument));

    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(
                name: settings.name,
              ));
  }
}
