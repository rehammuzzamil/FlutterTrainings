import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Implicit Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double sliderValue = 100;
  final beginColor = Colors.yellow;
  Color endColor = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
            widget.title != null ? widget.title : "Implicit Animation Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TweenAnimationBuilder(
              tween: ColorTween(begin: beginColor, end: endColor),
              child: Image.asset('assets/sunflr.png'),
              duration: Duration(seconds: 2),
              builder: (_, Color color, myChild) {
                return ColorFiltered(
                  child: myChild,
                  colorFilter: ColorFilter.mode(color, BlendMode.modulate),
                );
              },
            ),
            Slider.adaptive(
              value: sliderValue,
              onChanged: (double value) {
                setState(() {
                  sliderValue = value;
                  endColor = Color.lerp(beginColor, Colors.red, value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
