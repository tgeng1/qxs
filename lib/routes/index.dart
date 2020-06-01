import 'package:flutter/material.dart';
import 'package:qxs/api/booksServiceApi.dart';
import './addCard.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _controller = new ScrollController();
  List<dynamic> _cardList = [];
  int _totalCount = 0;
  int pageNo = 1;
  int pageSize = 18;
  bool isSetting = false;
  bool isLoading = false; // refresh
  bool showMore = false;  // footer  loading
  bool offState = false;  //  init loading
  Map<String, Color> _colorList = {
    'black': Colors.black,
    'gray': Colors.grey,
    'yellow': Colors.yellow,
    'blue': Colors.blue,
  };

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('到底了------->');
        if (_cardList.length < _totalCount) {
          setState(() {
            showMore = true;
          });
          _getCardList(true);
        } else {
          print('没有了----》');
        }
      }
    });
    _getCardList();
  }

  @override
  dispose() {
    super.dispose();
    _controller.dispose();
  }

  // Widget showMoreLoadingWidget() {
  //   return Container(
  //     height: 50.0,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         Text('加载中...', style: TextStyle(fontSize: 16.0),)
  //       ],
  //     ),
  //   );
  // }

  // get list
  Future _getCardList([bool _isLoadMore = false]) async{
    if (isLoading) return null;
    setState(() {
      isLoading = true;
      pageNo = _isLoadMore ? pageNo + 1 : pageNo;
    });
    var result = await BooksServiceApi.getBookList(pageNo, pageSize);
    if (result['msg'] == 'success') {
      if (!_isLoadMore) {
        setState(() {
          isLoading = false;
          _cardList = result['data']['result'];
          _totalCount = result['data']['count'];
        });
        print('get book list success ----- refresh!');
      } else {
        setState(() {
          isLoading = false;
          _cardList.addAll(result['data']['result']);
          _totalCount = result['data']['count'];
        });
        print('get book list success ----- loadMore!');
      }
    }
  }
  
  // add card
  void _addCard(item) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddCard(title: '添加',);
    }));
  }

  // click toggle setting
  void _onClickToggleSetting() {
    setState(() {
      isSetting = !isSetting;
    });
  }

  //close setting
  void _onClickCloseSetting() {
    setState(() {
      isSetting = false;
    });
  }

  void _deleteItem(item) {
    setState(() {
      _cardList.remove(item);
    });
  }

  // card item
  Widget _cardItem(item) {
    String text = item['title'];
    Color _color = _colorList[item['color']];
    List<Widget> _card = isSetting ? [
      Center(
        child: Text(text),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: IconButton(icon: Icon(Icons.delete, color: Colors.white,), onPressed: () => _deleteItem(item)),
      )
    ] : [
      Center(
        child: Text(text),
      ),
    ];
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: _card,
        ),
      ),
      onLongPress: () => _onClickToggleSetting(),
      onTap: () {
        return false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('道藏'),
      ),
      body: RefreshIndicator(
        child: GestureDetector(
          child: GridView.builder(
            padding: EdgeInsets.all(16.0),
            controller: _controller,
            itemCount: _cardList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0
            ),
            itemBuilder: (context, index) {
              return _cardItem(_cardList[index]);
            },
          ),
          onTap: () => _onClickCloseSetting(),
        ),
        onRefresh: () => _getCardList(),
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