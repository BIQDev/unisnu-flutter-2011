import 'package:flutter/material.dart';
import 'package:perpus/models/setting_model.dart';

class SettingProvider with ChangeNotifier {
  SettingModel _setting = SettingModel(
    apiHost: "http://192.168.1.10:2000",
  );

  SettingModel get setting {
    return _setting;
  }
}
