import 'package:flutter/material.dart';
import '../widgets/ListWidget.dart';
import '../widgets/DetailWidget.dart';

class PortraitViewPage extends StatefulWidget{

  @override
  @override
  State<StatefulWidget> createState() {
    return PortraitViewPageState();
  }

}

class PortraitViewPageState extends State<PortraitViewPage> {

  int itemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Week 3 Assignment",
          textDirection: TextDirection.ltr,
        ),
      ),
      drawer: Drawer(
            child : ListWidget(10,(value) {
              updateState(value);
              Navigator.pop(context);
            })
      ),
      body: DetailWidget(itemIndex),
    );
  }

  void updateState(value) {
    setState(() {
      itemIndex = value;
    });
  }
}