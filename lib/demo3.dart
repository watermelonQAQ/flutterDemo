

import 'package:flutter/material.dart';

class Demo3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo 3',
      home: Scaffold(
        appBar: AppBar(
          title: Text('这是第三个demo'),
        ),
        body: new Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(15.0),
          decoration: new BoxDecoration(
            border: new Border.all(
              color: Colors.red,
              width: 20
            ),
            image: const DecorationImage(
              image: const NetworkImage(
                'https://gw.alicdn.com/tfs/TB1CgtkJeuSBuNjy1XcXXcYjFXa-906-520.png',
              ),
              fit: BoxFit.contain,
            ),
            //borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
            borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(3.0),
              topRight: const Radius.circular(6.0),
              bottomLeft: const Radius.circular(9.0),
              bottomRight: const Radius.circular(0.0),
            ),
          ),
          child: Text(''),
        ),
      ),
    );
  }

}