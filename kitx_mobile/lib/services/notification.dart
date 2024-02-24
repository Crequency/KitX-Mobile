import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/services/public/service_status.dart';
import 'package:kitx_mobile/utils/extensions/service_status_to_string.dart';
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
          locked: true,
          // defaultColor: Color(0xFF9D50DD),
          // ledColor: Colors.white,
        ),
      ],
    );
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
        title:
            'NotificationService_StatusNotificationTitle'.tr.replaceAll("%status%", serviceStatus.toText()),
        body: 'NotificationService_StatusNotificationBody'
            .tr
            .replaceAll('%device_count%', deviceCount.toString()),
        locked: true,
        autoDismissible: false,
        category: NotificationCategory.Status,
      ),
    );
  }
}
