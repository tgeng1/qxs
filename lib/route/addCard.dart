
import 'package:flutter/material.dart';
import './index.dart';
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
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
            return MyHomePage(title: '9999',);
          }), (route) => route == null);
        },
      )
    );
  }
}