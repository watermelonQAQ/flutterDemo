
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/demo3.dart';
import 'package:flutter_demo/permission_demo.dart';
import 'package:flutter_demo/plugin_test.dart';
import 'package:lcfarm_flutter_umeng/lcfarm_flutter_umeng.dart';

import 'blue_demo.dart';
import 'demo2.dart';
import 'keychain.dart';

//void main() => runApp(new FlutterBlueApp());
//void main() => runApp(new PluginTestWidget());
//void main() => runApp(new UmengTest());
void main() {

  FlutterError.onError = (FlutterErrorDetails details){
    debugPrint("测试1---"+details.toString()+"---结束");
  };

  runZoned(
        () => runApp(CrashTest()),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
//        debugPrint("测试3---"+line+"---结束");
        parent.print(zone, "Intercepted: $line");

      },
    ),
    onError: (Object obj, StackTrace stack) {
      debugPrint("测试2---"+obj.toString()+"*******"+stack.toString()+"---结束");
//      debugPrint("测试2---"+stack.toString()+"---结束");
//      debugPrint("测试2---"+obj.toString()+"---结束");

//      var details = makeDetails(obj, stack);
//      reportErrorAndLog(details);
    },
  );

//  runApp(new CrashTest());
}
//void main() =>   runApp(MaterialApp(home: ItemsWidget()));


class Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}



class CrashTest extends StatefulWidget {
  @override
  _CrashTestState createState() => _CrashTestState();
}

class _CrashTestState extends State<CrashTest> {
  @override
  Widget build(BuildContext context) {

//    Future.delayed(Duration(seconds: 1)).then((e) => Future.error("这就是一个错误"));
//      Dio().get("http://www.test.com");

    try {
         Dio().get("http://www.test.com");

    }  catch (e) {
//      debugPrint("异常信息" + e.toString());
      return null;
    }

//  print(("自己的打印"));

  debugPrint("一次打印");
    return Column(
      children: <Widget>[
        Container(width: double.infinity,height: 160,color: Colors.deepOrangeAccent,),
        Container(width: double.infinity,height: 160,color: Colors.red,),
        Container(width: double.infinity,height: 160,color: Colors.blue,),
//        Container(width: double.infinity,height: 160,color: Colors.green,),
//        Container(width: double.infinity,height: 160,color: Colors.blueGrey,),
      ],
    );
  }

  void test(String str){

  }
}



class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {

    Localizations.localeOf(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Startup Name Generator"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text("Saved Suggestions"),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return new Divider();
          }
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadSaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadSaved ? Icons.favorite : Icons.favorite_border,
        color: alreadSaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadSaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}

class UmengTest extends StatefulWidget {
  @override
  _UmengTestState createState() => _UmengTestState();
}

class _UmengTestState extends State<UmengTest> {
  @override
  void initState() {
    super.initState();
    if(Platform.isIOS){
      LcfarmFlutterUmeng.init(
          iOSAppKey: "5e5370c0895cca2bcb0000a5",
          channel: "App Store",
          logEnable: true
      );
    }else if(Platform.isAndroid){
      LcfarmFlutterUmeng.init(
          androidAppKey: "5e539f370cafb2ed900001a6",
          channel: "aliyun",
          logEnable: true
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PluginTestWidget();
  }
}
