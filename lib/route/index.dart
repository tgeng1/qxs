
import 'package:flutter/material.dart';
import './addCard.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _cardList = [];

  @override
  void initState() {
    super.initState();
    _getCardList();
  }

  // get list
  void _getCardList() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        _cardList.addAll(
          [
            { 'text': '一', 'color': Colors.red },
            { 'text': '二', 'color': Colors.blue },
            { 'text': '三', 'color': Colors.green },
            { 'text': '四', 'color': Colors.grey },
            { 'text': '五', 'color': Colors.yellow },
          ]
        );
      });
    });
  }
  
  // add card
  void _addCard(item) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddCard(title: '添加新宝藏',);
    }));
  }

  // card item
  Widget _cardItem(item) {
    String text = item['text'];
    Color color = item['color'];
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      child: Center(
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0
          ),
          itemCount: _cardList.length,
          itemBuilder: (context, index) {
            if (index == _cardList.length - 1 && _cardList.length < 10) {
              _getCardList();
            }
            return _cardItem(_cardList[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addCard({'text': '六', 'color': Colors.black});
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}