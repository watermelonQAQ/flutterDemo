import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

///创建时间：2019/11/11 11:03
///作者：杨淋
///描述：插件功能测试页面
///

class PluginTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("测试页面"),
        ),
        body: ListView(
          children: <Widget>[
            addItem("SP功能测试", SPTest()),
            addItem("设备信息", DeviceInfoTest()),
            addItem("软件信息", PackageInfoTest()),
            addItem("定位权限申请", ApplyPermissionTest()),
          ],
        ),
      ),
    );
  }

  Widget addItem(String label, Widget widget) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(12),
      decoration:
          BoxDecoration(border: Border.all(color: randomColor(), width: 1)),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          widget
        ],
      ),
    );
  }

  Color randomColor() {
    return Color.fromARGB(255, Random().nextInt(256) + 0,
        Random().nextInt(256) + 0, Random().nextInt(256) + 0);
  }
}

class SPTest extends StatefulWidget {
  @override
  _SPTestState createState() => _SPTestState();
}

class _SPTestState extends State<SPTest> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController _unameController = TextEditingController();

  Future<String> _input;

  @override
  void initState() {
    super.initState();
    _input = _prefs.then((SharedPreferences sp) {
      print("SP获取信息:" + sp.getString("input"));
      return sp.getString("input");
    });
    print("初始化完成");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: TextField(
            controller: _unameController,
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          flex: 1,
          child: FutureBuilder<String>(
            future: _input,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                    return Text(
                      snapshot.data,
                    );
              }
            },
          ),
        ),
        RaisedButton(
          color: Colors.blue,
          child: Text("保存"),
          onPressed: () {
            _saveInput();
          },
        )
      ],
    );
  }

  _saveInput() async {
    SharedPreferences sharedPreferences = await _prefs;
    setState(() {
      _input = sharedPreferences
          .setString("input", _unameController.text)
          .then((bool flag) {
        return _unameController.text;
      });
    });
  }
}

class DeviceInfoTest extends StatefulWidget {
  @override
  _DeviceInfoTestState createState() => _DeviceInfoTestState();
}

class _DeviceInfoTestState extends State<DeviceInfoTest> {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String sdkNum = "-1";

  @override
  void initState() {
    super.initState();
    obtainSdkNum();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text("手机版本："),
        Text(sdkNum),
      ],
    );
  }

  obtainSdkNum() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      sdkNum = androidDeviceInfo.version.sdkInt.toString();
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      sdkNum = iosDeviceInfo.systemVersion;
    }
    setState(() {});
  }
}

class PackageInfoTest extends StatefulWidget {
  @override
  _PackageInfoTestState createState() => _PackageInfoTestState();
}

class _PackageInfoTestState extends State<PackageInfoTest> {
  String appName = "-1";

  String packageName = "-1";

  String version = "-1";

  String buildNumber = "-1";

  @override
  void initState() {
    obtainPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text("appName:" + appName),
        Text("packageName:" + packageName),
        Text("version:" + version),
        Text("buildNumber:" + buildNumber),
      ],
    );
  }

  obtainPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    setState(() {});
  }
}

class ApplyPermissionTest extends StatefulWidget {
  @override
  _ApplyPermissionTestState createState() => _ApplyPermissionTestState();
}

class _ApplyPermissionTestState extends State<ApplyPermissionTest> {
  String state = "unknown";

  @override
  void initState() {

    checkPermissionStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text("定位权限状态：" + state+"   "),
        Row(
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Text("权限申请"),
              onPressed: () async{
                final Map<PermissionGroup, PermissionStatus> permissionRequestResult
                = await PermissionHandler().requestPermissions([PermissionGroup.location]);
                state =  permissionRequestResult[PermissionGroup.location].toString();
                setState(() {

                });
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              color: Colors.blue,
              onPressed: () {
                PermissionHandler().openAppSettings().then((bool hasOpened) =>
                    debugPrint('App Settings opened: ' + hasOpened.toString()));
              },
            ),
          ],
        )
      ],
    );
  }

  void checkPermissionStatus() async{
    PermissionStatus permissionStatus = await PermissionHandler().checkPermissionStatus(PermissionGroup.location);
    state = permissionStatus.toString();
    setState(() {

    });

  }
}
