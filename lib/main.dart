import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snapnsnack/imagepick.dart';
import 'package:snapnsnack/info.dart';
import 'dart:async';

import 'package:snapnsnack/login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nextPage();
  }

  void nextPage() {
    Timer(Duration(seconds: 5), () {
      // 5s over, navigate to a new page
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
        ),
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('images/logo_trans.png', height: 100.0, width: 100.0,),
            ),
            Container(
              child: Text(
                'Snap n\' Snack',
                style: TextStyle(
                  fontFamily: 'Limelight',
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SpinKitThreeBounce(
              color: Colors.white.withOpacity(0.7),
              size: 25.0,
              duration: Duration(milliseconds: 1600),
            ),
          ],
        ),
      ),
    );
  }
}

