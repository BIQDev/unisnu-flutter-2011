import 'package:flutter/material.dart';
import 'package:perpus/models/setting_model.dart';

class SettingProvider with ChangeNotifier {
  SettingModel _setting = SettingModel(
    apiBaseUri: "http://localhost:1001",
  );

  SettingModel get setting {
    return _setting;
  }
}
