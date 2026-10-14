import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/services/public/service_status.dart';
import 'package:kitx_mobile/utils/extensions/service_status_to_string.dart';
import 'package:kitx_mobile/utils/handlers/permissions_handlers.dart';

/// [NotificationService] class
class NotificationService {
  /// Status notification id
  var statusNotificationId = 10;

  /// Status channel key
  var statusChannelKey = "status_channel";

  /// Initialize the notification service
  Future<void> initAsync() async {
    if (await requestNotificationPermission() == false) return;

    if (GetPlatform.isAndroid) {
      AwesomeNotifications().initialize(
        'resource://drawable/notification_icon',
        [
          NotificationChannel(
            channelKey: statusChannelKey,
            channelName: 'KitX Status Notifications',
            channelDescription: 'KitX Mobile Status',
            locked: true,
            playSound: false,
            enableVibration: false,
            onlyAlertOnce: true,
          ),
        ],
      );
      AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceivedMethod);
    } else if (GetPlatform.isIOS) {
      // TODO: Adapt to iOS
    }
  }

  /// On action received method
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    var key = receivedAction.buttonKeyPressed;
    if (key == 'action_view_button') {
      // 必须比较 .value，否则 Rx<ServiceStatus> 与枚举恒不相等，永远走 restart 分支。
      if (instances.devicesService.serviceStatus.value == ServiceStatus.running) {
        instances.shutdownDevicesServer();
      } else {
        instances.restartDevicesServer();
      }
    } else if (key == 'action_view_exit') {
      instances.shutdownDevicesServer();

      AwesomeNotifications().cancelAll();

      await SystemNavigator.pop();

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
          // 通知小图标必须是单色透明图标，直接复用彩色应用图标会被系统拒绝
          // （PlatformException: Invalid notification (no valid small icon)）。
          icon: 'resource://drawable/notification_icon',
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
            isDangerousOption: true,
            color: Colors.red,
          ),
        ]);
  }
}
