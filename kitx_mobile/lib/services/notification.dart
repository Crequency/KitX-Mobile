import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/services/public/service_status.dart';
import 'package:kitx_mobile/utils/extensions/service_status_to_string.dart';
import 'package:kitx_mobile/instances.dart';
// import 'package:flutter/material.dart';

/// [NotificationService] class
class NotificationService {
  /// Status notification id
  var statusNotificationId = 10;

  /// Status channel key
  var statusChannelKey = "status_channel";

  /// Initialize the notification service
  Future<void> initAsync() async {
    // TODO: Adapt to iOS
    AwesomeNotifications().initialize(
      'resource://drawable/app_icon',
      [
        // KitX status channel
        NotificationChannel(
          channelKey: statusChannelKey,
          channelName: 'KitX Status Notifications',
          channelDescription: 'KitX status',
          locked: true, // Prevents the user from deleting the channel
          playSound: false, // Do NOT play sound when the notification is displayed
          enableVibration: false, // Do NOT vibrate when the notification is displayed
          onlyAlertOnce: true, // Only alert once
          // defaultColor: Color(0xFF9D50DD),
          // ledColor: Colors.white,
        ),
      ],
    );
    AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  /// On action received method
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    var key = receivedAction.buttonKeyPressed;
    if (key == 'action_view_button') {
      if (instances.devicesService.serviceStatus == ServiceStatus.running) {
        // Stop service
        instances.shutdownDevicesServer();
      } else {
        // Start service
        instances.restartDevicesServer();
      }
    } else if (key == 'action_view_exit') {
      // Exit app
      instances.shutdownDevicesServer();

      // Delete all notifications
      AwesomeNotifications().cancelAll();

      await SystemNavigator.pop(); // Probably not working on iOS (by Copilot)
      exit(0);
    }
  }

  /// Update status notification
  Future<void> updateStatusNotification({
    required int deviceCount,
    required ServiceStatus serviceStatus,
  }) async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: statusNotificationId,
          channelKey: statusChannelKey,
          title: 'NotificationService_StatusNotificationTitle'.trParams({"status": serviceStatus.toText()}),
          body: 'NotificationService_StatusNotificationBody'.trParams({'device_count': deviceCount.toString()}),
          locked: true,
          autoDismissible: false,
          category: NotificationCategory.Status,
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'action_view_button',
            label: (serviceStatus == ServiceStatus.running) ? 'Public_Stop'.tr : 'Public_Launch'.tr,
            actionType: ActionType.KeepOnTop,
            autoDismissible: false,
          ),
          NotificationActionButton(
            key: 'action_view_exit',
            label: 'Public_Quit'.tr,
            actionType: ActionType.SilentAction,
            autoDismissible: false,
          ),
        ]);
  }
}
