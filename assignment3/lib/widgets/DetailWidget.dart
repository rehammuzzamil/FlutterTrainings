import 'package:flutter/material.dart';

class DetailWidget extends StatefulWidget {
  final int data;

  DetailWidget(this.data);

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[getAvatarWithText(constraints)],
        );
      },
    );
  }


  Widget getAvatarWithText(BoxConstraints constraints) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[getImageWidget(constraints), getTextWidget(constraints)],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      padding: EdgeInsets.all(8.0),
    );
  }
  
  Widget getImageWidget(BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FittedBox(
          child: CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
        width: MediaQuery.of(context).size.width / 3,
      ),
    );
  }

  Widget getTextWidget(BoxConstraints constraints) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: FittedBox(
              child: Text(
                "VENTUREDIVE",
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              fit: BoxFit.contain),
          width: MediaQuery.of(context).size.width / 2.5,
          height: (MediaQuery.of(context).size.height / 2) * 0.2,
          color: Theme.of(context).primaryColor,
        ));
  }

}
