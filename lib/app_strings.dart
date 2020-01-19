import 'package:flutter/material.dart';
import 'package:flutter_demo/l10n/messages_all.dart';
import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

///创建时间：2020-01-19 10:07
///作者：杨淋
///描述：



class AppStrings {
  AppStrings(Locale locale) : _localeName = locale.toString();

  final String _localeName;

  static Future<AppStrings> load(Locale locale) {
    return initializeMessages(locale.toString())
        .then((Object _) {
      return new AppStrings(locale);
    });
  }

  static AppStrings of(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings);
  }

  String title() {
    return Intl.message(
      'Localization Demo',
      name: 'title',
      desc: '应用标题',
      locale: _localeName,
    );
  }

  String click() => Intl.message(
    'Click',
    name: 'click',
    desc: '点击',
    locale: _localeName,
  );

  String helloFromDemo() => Intl.message(
    'Hello~',
    name: 'helloFromDemo',
    desc: '一句问候',
    locale: _localeName,
  );
}