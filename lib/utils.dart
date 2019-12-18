import 'dart:math';

import 'package:flutter/material.dart';

///创建时间：2019/12/18 17:30
///作者：杨淋
///描述：

class Utils {


 static Color randomColor() {
    return Color.fromARGB(255, Random().nextInt(256) + 0,
        Random().nextInt(256) + 0, Random().nextInt(256) + 0);
  }

 static Color randomColorWithAlpha() {
   return Color.fromARGB(Random().nextInt(256) + 0, Random().nextInt(256) + 0,
       Random().nextInt(256) + 0, Random().nextInt(256) + 0);
 }
}
