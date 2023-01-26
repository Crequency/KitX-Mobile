// import 'dart:async';

// import 'package:flutter_logs/flutter_logs.dart';
// import 'package:sms_advanced/sms_advanced.dart';

// class SmsServer{
//   late SmsReceiver _smsReceiver;

//   SmsServer();

//   Future<void> initServer() async {
//     _smsReceiver = SmsReceiver();
//     _smsReceiver.onSmsReceived?.listen((SmsMessage msg) => print(msg.body));
//     // _smsReceiver = SmsReceiver(_onSmsReceived, onTimeout: _onTimeout);
//     // if (_smsReceiver == null) return;
//     // await _smsReceiver?.startListening();
//     // Timer.periodic(const Duration(seconds: 2), (_) async {
//     //   String? message = await AndroidSmsRetriever.listenForSms();
//       // FlutterLogs.logInfo("server", "SmsServer", "Sms receive: $message");
//     // });
//   }

//   void _onSmsReceived(String? message) {
//     FlutterLogs.logInfo("server", "SmsServer", "Sms receive: $message");
//   }

//   void _onTimeout() {
//     FlutterLogs.logError("error", "SmsServer", "Sms server timeout.");
//   }

//   void _stopListening() async {
//     // if (_smsReceiver == null) return;
//     // await _smsReceiver?.stopListening();
//   }
// }