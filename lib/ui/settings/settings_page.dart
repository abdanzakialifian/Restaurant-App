import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

class SettingsPage extends StatefulWidget {
  final List<RestaurantDataResponse> listRestaurant;

  const SettingsPage({Key? key, required this.listRestaurant})
      : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _notificationHelper
                .showNotification(flutterLocalNotificationsPlugin);
          },
          child: const Text("Test Notif"),
        ),
      ),
    );
  }
}
