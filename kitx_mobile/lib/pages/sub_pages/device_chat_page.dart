import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/models/chat_message.dart';
import 'package:kitx_mobile/pages/controls/chat_message_bubble.dart';
import 'package:kitx_mobile/pages/pages.dart';

/// Get Random String
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

/// Device Chat Page
class DeviceChatPage extends StatefulWidget implements ConstantPage {
  /// Get Route
  static String getRoute() => '/devices/chat';

  /// Get Page
  static Widget Function() getPage() => () => const DeviceChatPage();

  /// Constructor
  const DeviceChatPage({super.key});

  @override
  State<DeviceChatPage> createState() => _DeviceChatPage();
}

class _DeviceChatPage extends State<DeviceChatPage> {
  final _messages = <ChatMessage>[];
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send() {
    var text = _inputController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          id: randomString(),
          text: text,
          isMine: true,
          createdAt: DateTime.now(),
        ),
      );
    });

    _inputController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    // 等这一帧布局完成后再滚动，否则读到的 maxScrollExtent 还是旧值。
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeviceChatPage_Title'.tr),
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildMessageList(context)),
            _buildComposer(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList(BuildContext context) {
    if (_messages.isEmpty) {
      return Center(
        child: Text(
          'DeviceChatPage_Empty'.tr,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: _messages.length,
      itemBuilder: (context, index) => ChatMessageBubble(message: _messages[index]),
    );
  }

  Widget _buildComposer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              minLines: 1,
              maxLines: 5,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _send(),
              decoration: InputDecoration(
                hintText: 'DeviceChatPage_InputHint'.tr,
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: _send,
            icon: const Icon(Icons.send_rounded),
            tooltip: 'DeviceChatPage_Send'.tr,
          ),
        ],
      ),
    );
  }
}
