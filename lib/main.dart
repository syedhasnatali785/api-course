import 'package:flutter/material.dart';
import 'package:untitled1/example_five.dart';
import 'package:untitled1/example_four.dart';
import 'package:untitled1/example_three.dart';
import 'package:untitled1/example_two.dart';
import 'package:untitled1/signup.dart';
import 'package:untitled1/upload_image.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: UploadImage(),
    );
  }
}
