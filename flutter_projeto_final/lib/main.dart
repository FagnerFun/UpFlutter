import 'package:flutter/material.dart';
import 'package:flutter_projeto_final/pages/IndexPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: IndexPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}