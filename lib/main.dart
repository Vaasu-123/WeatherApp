import 'package:flutter/material.dart';
import './Activity/home.dart';
import './Activity/loading.dart';

void main() {
  runApp(MaterialApp(
    //home: Home(),
    routes: {
      "/": (context) => Loading(),
      "/home": (context) => Home(),
      "/loading": (context) => Loading(),
    },
  ));
}
