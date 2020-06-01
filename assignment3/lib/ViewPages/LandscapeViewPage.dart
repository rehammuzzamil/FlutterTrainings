import 'package:flutter/material.dart';
import '../widgets/ListWidget.dart';
import '../widgets/DetailWidget.dart';

class LandscapeViewPage extends StatefulWidget {
  @override
  LandscapeViewPageState createState() {
    return LandscapeViewPageState();
  }
}

class LandscapeViewPageState extends State<LandscapeViewPage> {
  var selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
        body: Flex(direction: Axis.horizontal, children: <Widget>[
          Expanded(
            flex: 30,
            child: ListWidget(10,(value) {
              selectedValue = value;
              setState(() {

              });
            }),
          ),
          Expanded(flex: 70, child: DetailWidget(selectedValue))
        ])
    );
  }
}