import 'package:flutter/material.dart';

import 'HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyTune",
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        accentColor: Color.fromRGBO(218, 231, 250, 1),
        primaryColor: Colors.white,
        canvasColor: Colors.transparent,
        bottomAppBarTheme:BottomAppBarTheme(color: Colors.transparent)
      ),
      home: HomePage(),
    );
  }
}