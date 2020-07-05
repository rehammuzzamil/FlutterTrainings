import 'package:assignment4/widget/WeatherDetailsWidget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Prediction Application',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: WeatherDetailsWidget(),
    );
  }
}
