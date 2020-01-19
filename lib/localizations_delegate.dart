import 'package:flutter/material.dart';
import 'package:flutter_demo/app_strings.dart';

///创建时间：2020-01-19 10:18
///作者：杨淋
///描述：

class AppLocalizationsDelegate extends LocalizationsDelegate<AppStrings> {
  @override
  Future<AppStrings> load(Locale locale) {
    return AppStrings.load(locale);
  }

  @override
  bool isSupported(Locale locale) =>
      ['zh', 'en'].contains(locale.languageCode); // 支持的类型要包含App中注册的类型

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}