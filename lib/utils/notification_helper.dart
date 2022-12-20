import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/data/model/restuarant_notification.dart';
import 'package:restaurant_app/ui/detail/detail_page.dart';
import 'package:restaurant_app/utils/globals.dart';
import 'package:rxdart/rxdart.dart';

final selectedNotificationSubject = BehaviorSubject<String>();
final didReceiveLocalNotificationSubject =
    BehaviorSubject<RestaurantNotification>();

class NotificationHelper {
  static const _channelId = "1001";
  static const _channelName = "restaurant_info";
  static const _channelDesc = "restaurant information channel";
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings("drawable/app_icon");

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        didReceiveLocalNotificationSubject.add(
          RestaurantNotification(
            id: payload,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      },
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        selectedNotificationSubject.add(details.payload ?? "");
      },
    );
  }

  void requestIOSPermission(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void configureDidReceiveLocalNotificationSubject(BuildContext context) {
    didReceiveLocalNotificationSubject.stream
        .listen((RestaurantNotification restaurantNotification) async {
      await showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: restaurantNotification.title != null
              ? Text(restaurantNotification.title ?? "")
              : null,
          content: restaurantNotification.body != null
              ? Text(restaurantNotification.body ?? "")
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("OK"),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      id: restaurantNotification.id.toString(),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }

  void configureSelectedNotificationSubject(BuildContext context) {
    selectedNotificationSubject.stream.listen((String id) async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(id: id),
        ),
      );
    });
  }

  Future showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantListResponse restaurant) async {
    List<RestaurantDataResponse> listRestaurant = restaurant.restaurants ?? [];
    // get random list
    var randomIndex = Random().nextInt(listRestaurant.length);
    // get random restaurant
    var randomRestaurant = listRestaurant[randomIndex];

    String imageUrl =
        Globals.baseUrlImage + randomRestaurant.pictureId.toString();

    var largeIconPath = await _downloadAndSaveFile(imageUrl, 'largeIcon');
    var bigPicturePath = await _downloadAndSaveFile(imageUrl, 'bigPicture');
    String description = "Yuk lihat detail restaurantnya!";

    var bigPictureStyleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        largeIcon: FilePathAndroidBitmap(largeIconPath),
        contentTitle: "<b>Rekomendasi Restaurant Hari Ini!<b>",
        htmlFormatContentTitle: true,
        summaryText: randomRestaurant.name);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        channelDescription: _channelDesc,
        styleInformation: bigPictureStyleInformation,
        importance: Importance.high,
        priority: Priority.high);

    var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      attachments: [
        DarwinNotificationAttachment(bigPicturePath),
      ],
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      randomIndex,
      randomRestaurant.name,
      description,
      platformChannelSpecifics,
      payload: randomRestaurant.id,
    );
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
