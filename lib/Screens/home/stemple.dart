import 'package:flutter/material.dart';

class Stemple extends StatefulWidget {
  Stemple({Key? key}) : super(key: key);

  @override
  State<Stemple> createState() => _StempleState();
}

class _StempleState extends State<Stemple> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text("Stemple")
    ],);
  }
}