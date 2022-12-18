import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';
import 'package:restaurant_app/utils/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool? _isScheduled;

  bool? get isScheduled => _isScheduled;

  SettingsProvider() {
    getStateScheduled();
  }

  Future<bool> scheduledNotification(bool value) async {
    if (value) {
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      return await AndroidAlarmManager.cancel(1);
    }
  }

  void setStateScheduled(bool isSwitchOn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(Globals.keyState, isSwitchOn);
    _isScheduled = isSwitchOn;
    notifyListeners();
  }

  void getStateScheduled() async {
    final prefs = await SharedPreferences.getInstance();
    _isScheduled = prefs.getBool(Globals.keyState);
    notifyListeners();
  }
}
