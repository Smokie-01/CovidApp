import 'dart:async';

import 'package:flutter/material.dart';
import "dart:math" as math;

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final _animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.rotate(
                    angle: _animationController.value * 2.0 * math.pi,
                    child: child);
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width * .2,
                child: Image.asset("images/virus.png", height: MediaQuery.of(context).size.height*.4,width: MediaQuery.of(context).size.width*.4 ,),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * .08,
          ),
          Align(
            alignment: Alignment.center ,
            child: Center(
              child: Text(
                "Covid19 Tracker App",
                
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
