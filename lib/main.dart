import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    /*final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceIn,
      reverseCurve: Curves.easeOut,
    );

    _animation =
        Tween<double>(begin: 0, end: 2 * math.pi).animate(curvedAnimation)
          ..addListener(() {
            setState(() {});
          })*/
    _animation = Tween<double>(begin: 0, end: 2 * math.pi)
        .chain(CurveTween(curve: Curves.bounceIn))
        .animate(_animationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            }
            if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          });

    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Transform.rotate(
          angle: _animation.value,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(30.0),
            child: Image(
              image: NetworkImage(
                  'https://tse1.mm.bing.net/th?id=OIP.AaFKdPEnPWK2MpdkdUgoWQHaFj&pid=Api&P=0&w=209&h=158'),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
