import 'dart:async';

import 'package:ecart/core/session_management.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    Timer(Duration(seconds: 1), () {
      _animationController.forward();
      Timer(Duration(seconds: 2),(){
        if(SessionManagement.isGuest || SessionManagement.isUser){
          Get.offNamed(AppRoutesNames.bottomBarScreen);
        }else{
          Get.offNamed(AppRoutesNames.registerScreen);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Image.asset('assets/images/Logo.png', height: 35 * imageSizeMultiplier,),
        ),
      ),
      backgroundColor: Color(0xff020428),
    );
  }
}
