import 'package:flutter/material.dart';
import 'routing_constants.dart';
import 'router.dart' as router;



class UndefinedView extends StatelessWidget {
  final String name;
  const UndefinedView({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  title: 'Named Routing',
  onGenerateRoute: router.generateRoute,
  onUnknownRoute: (settings) => MaterialPageRoute(
      builder: (context) => UndefinedView(
            name: settings.name,
          )),
  initialRoute: HomepageViewRoute,
);
  }
}