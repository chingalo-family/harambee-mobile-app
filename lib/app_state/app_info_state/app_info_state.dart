import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoState extends ChangeNotifier {
  bool _loading = true;
  String _appName = '';
  String _packageName = '';
  String _version = '';

  String get appName => _appName;
  String get packageName => _packageName;
  String get version => _version;
  bool get loading => _loading;

  void initiatizeAppInfo() async {
    _loading = true;
    notifyListeners();
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      _packageName = packageInfo.packageName;
      _appName = packageInfo.appName;
      _version = packageInfo.version;
    } catch (e) {
      //
    }
    _loading = false;
    notifyListeners();
  }
}
