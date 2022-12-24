import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'mypage.dart';



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    title: ("My Written-Exam"),
    home: const MyPage(),
  ));
}
