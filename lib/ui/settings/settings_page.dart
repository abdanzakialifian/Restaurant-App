import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                top: 12,
                right: 5,
                bottom: 15,
              ),
              child: SizedBox(
                height: 40,
                child: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          "Setting",
                          style: TextStyle(
                            fontFamily: "Poppins Bold",
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Scheduled Notification",
                    style: TextStyle(
                        fontFamily: "Poppins Regular",
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  Consumer<SettingsProvider>(
                    builder: (context, provider, child) {
                      return Switch.adaptive(
                        value: provider.isScheduled ?? false,
                        onChanged: (value) async {
                          provider.setStateScheduled(value);
                          if (Platform.isIOS) {
                            _alertDialogIOS(context);
                          } else {
                            provider.scheduledNotification(value);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _alertDialogIOS(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Coming Soon!'),
          content: const Text('This feature will be coming soon!'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
