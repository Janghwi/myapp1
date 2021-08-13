import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconCategory {
  final Icon icon;
  final routeName;
  final String title;

  const IconCategory({
    this.icon,
    this.routeName,
    this.title,
  });
}
//icon item data
const List<IconCategory> iconCategories = [
  IconCategory(  title: 'Airport\n공항',  icon: Icon(
    FontAwesomeIcons.planeDeparture, size: 30, color: Colors.lightBlue,), routeName: 'a01',),
  IconCategory(  title: '식당',           icon: Icon(
    FontAwesomeIcons.restroom,  size: 30,  color: Colors.orangeAccent, ),routeName: 'a02',),
];