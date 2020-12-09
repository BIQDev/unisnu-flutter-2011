import 'package:flutter/material.dart';
import 'package:perpus/models/setting_model.dart';

class SettingProvider with ChangeNotifier {
  SettingModel _setting = SettingModel(
    apiHost: "https://perpus-api.biqdev.com",
    userName: "biqdev",
  );

  SettingModel get setting {
    return _setting;
  }
}
