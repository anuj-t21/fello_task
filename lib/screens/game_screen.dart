import 'dart:async';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  double marginTop;

  AnimationController controller;

  @override
  void initState() {
    super.initState();
  }

  void _jumpImage() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 100,
      upperBound: 200,
    );
    controller.addListener(() {
      setState(() {});
    });
    controller.forward().then((_) {
      controller.reverse();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height * 0.59,
      margin: EdgeInsets.only(top: deviceSize.height * 0.1),
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          children: [
            Spacer(),
            Container(
              height: 100,
              margin: EdgeInsets.only(
                  bottom: controller == null ? 100 : controller.value),
              child: Image.asset('assets/Logo.jpeg'),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: TextButton(
                onPressed: _jumpImage,
                child: Text(
                  'JUMP',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
