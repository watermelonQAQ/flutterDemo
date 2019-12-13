import 'package:flutter/material.dart';

import 'WaveWidget.dart';

///创建时间：2019/12/12 14:18
///作者：杨淋
///描述：


class AnimationTest extends StatefulWidget {
  @override
  _AnimationTestState createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest> with SingleTickerProviderStateMixin{

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration:Duration(seconds: 5),
        lowerBound: 10,upperBound: 100,vsync: this);
    controller.addListener((){
      setState(() {

      });
    });

    controller.addStatusListener((AnimationStatus status){
      print(status.toString());
    });

  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Text(controller.value.round().toString()),
      SizedBox(width: 20,),
      RaisedButton(
        child: Text("开始"),
        onPressed: (){
          if(controller.value == 10){

            controller.forward();
          }else{
            controller.reverse();
          }
        },
      )
    ],);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}
