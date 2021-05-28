import 'package:fello_app/screens/game_screen.dart';
import 'package:fello_app/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fello App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.purple,
      ),
      home: TabsScreen(),
    );
  }
}
