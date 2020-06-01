
import 'package:flutter/material.dart';

class AddCard extends StatefulWidget {
  AddCard({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: RaisedButton(
        child: Text('返回'),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    );
  }
}