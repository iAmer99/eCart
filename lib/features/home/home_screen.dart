import 'package:ecart/core/session_management.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            SessionManagement.logout();
            Get.offAllNamed(AppRoutesNames.loginScreen);
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text("Welcome ${SessionManagement.name}"),
      ),
    );
  }
}
