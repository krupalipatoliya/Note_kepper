import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final spinKit = SpinKitCircle(
    itemBuilder: (context,i){
      return CircleAvatar(
        backgroundColor: Colors.white,
      );
    },
  );

  @override
  void initState() {
    Timer(Duration(seconds: 5), () {

      Get.offAndToNamed('/');

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.deepOrangeAccent,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  SizedBox(height: 150),
                  Text(
                    "MyNote",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: "Fluo Gums",
                        letterSpacing: 2),
                  ),
                ],
              ),
              spinKit,
            ],
          ),

          Positioned(
            top: Get.height * 0.20,
            left: Get.width * 0.39,
            child: Image.asset(
              "assets/logo/logo.png",
              scale: 8,
            ),
          ),
        ],
      ),
    );
  }
}
