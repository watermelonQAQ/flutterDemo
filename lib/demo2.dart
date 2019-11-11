import 'package:flutter/material.dart';

class Demo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo 2',
      home: Scaffold(
        appBar: AppBar(
          title: Text('这是第二个demo'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Image.asset(
                "images/flutter.jpg",
              ),
              Head("这是标题", "这是内容简介", 35),
              Middle(),
              Bottom(),
            ],
          ),
        ),
      ),
    );
  }
}

class Head extends StatelessWidget {
  String title;
  String content;
  int startsCount;

  Head(this.title, this.content, this.startsCount);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Row(
        children: <Widget>[

          Container(
            child:  Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    content,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ) ,
          ),
          Icon(
            Icons.star,
            color: Colors.red,
          ),
          Text(startsCount.toString())
        ],
      ),
    );
  }
}

class Middle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 36, right: 36, bottom: 24),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
                Text(
                  "CALL",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.navigation,
                  color: Colors.blue,
                ),
                Text(
                  "ROUTE",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.share,
                  color: Colors.blue,
                ),
                Text(
                  "SHARE",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Bottom extends StatelessWidget{
  @override
  Widget build(BuildContext context) {



    return Text("dddddddddddddddddddddcsccascsadaddddddddddddddddddddd"
        "dafgfewegfwefweddddddddddddddddddddddasfasfafwqfqwfddddddddddddddddddddd"
        "afsafsaf"
        "");
  }

}
